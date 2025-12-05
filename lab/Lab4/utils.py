import pandas as pd
import numpy as np
import plotly.express as px
import plotly.graph_objects as go

# Chromosome sorting key
def chromosome_sort_key(x):
    x = x.replace('chr', '')
    return (int(x) if x.isdigit() else float('inf'), x)
  
# Filter minimum SNPs
def filter_minimum_snp_olink(data, pvalue_cutoff):
    data_ = data.copy()
    data_['SNP_type'] = np.where(data_['P'] <= pvalue_cutoff, data_['SNP_type'], 'nonsig')
    idx = data_.groupby(['OlinkID', 'protein_gene_name'])['P'].idxmin()
    filtered_data = data_.loc[idx].reset_index(drop=True)
    
    return filtered_data

# Prepare data for Manhattan plot
def prepare_manhattan_data(data, pvalue_cutoff):
    filtered_data = filter_minimum_snp_olink(data, pvalue_cutoff)
    
    chromosome_order = sorted(filtered_data['CHR'].unique(), key=chromosome_sort_key)
    filtered_data['CHR'] = pd.Categorical(filtered_data['CHR'], categories=chromosome_order, ordered=True)
    
    filtered_data = filtered_data.sort_values(by=['CHR', 'BP']).reset_index(drop=True)
    chr_lengths = (
        filtered_data.groupby('CHR', observed=False)['BP']
        .max()
        .reset_index()
        .rename(columns={'BP': 'chr_len'})
    )
    chr_lengths['tot'] = chr_lengths['chr_len'].cumsum() - chr_lengths['chr_len']
    filtered_data = filtered_data.merge(chr_lengths[['CHR', 'tot']], on='CHR', how='left')
    filtered_data['BPcum'] = filtered_data['BP'] + filtered_data['tot']
    
    filtered_data['is_annotate'] = np.where(filtered_data['P'] < pvalue_cutoff, 'yes', 'no')
    
    return filtered_data

def plot_manhattan(data, pvalue_cutoff):   
    data = prepare_manhattan_data(data, pvalue_cutoff)
    
    trans_color = '#1f77b4'
    cis_color = '#d62728'
    nonsig_color = '#A9A9A9'
    
    # Non-significant SNPs
    nonsig_data = data[data['is_annotate'] == 'no']
    fig = go.Figure()
    fig.add_trace(go.Scatter(
        x=nonsig_data['BPcum'],
        y=-np.log10(nonsig_data['P']),
        mode='markers',
        marker=dict(
            color=nonsig_color,
            size=5,
            opacity=0.8
        ),
        text=nonsig_data['protein_gene_name'],
        name='Non-significant SNPs'
    ))
    
    # cis SNPs
    cis_data = data[(data['is_annotate'] == 'yes') & (data['SNP_type'] == 'Cis')]
    fig.add_trace(go.Scatter(
        x=cis_data['BPcum'],
        y=-np.log10(cis_data['P']),
        mode='markers+text',
        marker=dict(
            color=cis_color,
            size=6
        ),
        text=cis_data['protein_gene_name'],
        textposition='top center',
        textfont=dict(size=8),
        name='Significant Cis SNPs'
    ))
    
    # trans SNPs
    trans_data = data[(data['is_annotate'] == 'yes') & (data['SNP_type'] == 'Trans')]
    fig.add_trace(go.Scatter(
        x=trans_data['BPcum'],
        y=-np.log10(trans_data['P']),
        mode='markers+text',
        marker=dict(
            color=trans_color,
            size=6
        ),
        text=trans_data['protein_gene_name'],
        textposition='top center',
        textfont=dict(size=8),
        name='Significant Trans SNPs'
    ))
    
    fig.update_layout(
        title=dict(
            text="Manhattan Plot of the Sentinel pQTL per Protein",
            x=0.5,
            xanchor="center"
        ),
        xaxis=dict(
            title="Chromosome",
            tickmode='array',
            tickvals=data.groupby('CHR', observed=False)['BPcum'].mean(),
            ticktext=data['CHR'].unique(),
            tickangle=0
        ),
        yaxis=dict(title="-log10(P-value)"),
        template="simple_white",
        width=1200,
        height=600,
        legend=dict(
            orientation="h",
            yanchor="top", 
            y=-0.3,
            xanchor="center",
            x=0.5
        )
    )

    fig.add_hline(
        y=-np.log10(pvalue_cutoff),
        line_width=3,
        line_color='black',
        line_dash='dash',
        opacity=1
    )
    fig.update_traces(hoverinfo='skip', hovertemplate=None)
    return fig

# Filter significant SNPs for location plot
def filter_pQTL(data, pvalue_cutoff):
    data_ = data.copy()
    data_['SNP_type'] = np.where(data_['P'] <= pvalue_cutoff, data_['SNP_type'], 'nonsig')
    filtered_data = data_[data_["P"] <= pvalue_cutoff].reset_index(drop=True)
    filtered_data = filtered_data.sort_values(by=["CHR", "BP"]).reset_index(drop=True)
    return filtered_data
  
# Create location plot
def plot_location(data, pvalue_cutoff):
    significant_data = filter_pQTL(data, pvalue_cutoff)
    chromosome_order = sorted(significant_data['CHR'].unique(), key=chromosome_sort_key)
    protein_chromosome_order = sorted(significant_data['protein_chr_name'].unique(), key=chromosome_sort_key)
    
    significant_data['CHR'] = pd.Categorical(significant_data['CHR'], categories=chromosome_order, ordered=True)
    significant_data['protein_chr_name'] = pd.Categorical(significant_data['protein_chr_name'], categories=protein_chromosome_order, ordered=True)
    
    chromosome_ticks_x = {label: i for i, label in enumerate(chromosome_order)}
    chromosome_ticks_y = {label: len(protein_chromosome_order) - 1 - i for i, label in enumerate(protein_chromosome_order)}

    significant_data["CHR_numeric"] = significant_data["CHR"].cat.codes
    significant_data["protein_chr_numeric"] = significant_data["protein_chr_name"].cat.codes

    significant_data["CHR_normalized"] = significant_data["CHR_numeric"] + (
        significant_data["BP"] / significant_data.groupby("CHR", observed=False)["BP"].transform("max")
    )
    significant_data["protein_chr_normalized"] = significant_data["protein_chr_numeric"] + (
        significant_data["protein_begin"] / significant_data.groupby("protein_chr_name", observed=False)["protein_begin"].transform("max")
    )

    fig = px.scatter(
        significant_data,
        x="CHR_normalized",
        y="protein_chr_normalized",
        color="SNP_type",
        labels={"CHR_normalized": "Chromosome (pQTL)", "protein_chr_normalized": "Chromosome (Protein)"},
        color_discrete_map={"Trans": "#1f77b4", "Cis": "#d62728"}
    )

    fig.update_layout(
        template="simple_white",
        width=800,
        height=500,
        legend=dict(
            orientation="h",
            yanchor="top", 
            y=-0.1,
            xanchor="center",
            x=0.5
        ),
        xaxis=dict(
            title="pQTL Position",
            tickmode="array",
            tickvals=[val + 0.5 for val in chromosome_ticks_x.values()],
            ticktext=list(chromosome_ticks_x.keys()),
            side="top",
            range=[0, len(chromosome_ticks_x)],
        ),
        yaxis=dict(
            title="Protein Position",
            tickmode="array",
            tickvals=[val + 0.5 for val in chromosome_ticks_y.values()], 
            ticktext=list(chromosome_ticks_y.keys()),
            side="right", 
            range=[0, len(chromosome_ticks_y)]
        ) 
    )

    for tick in chromosome_ticks_x.values():
        fig.add_vline(x=tick, line_width=1, line_color="black")  

    for tick in chromosome_ticks_y.values():
        fig.add_hline(y=tick, line_width=1, line_color="black") 

    fig.add_vline(x=len(chromosome_ticks_x), line_width=1, line_color="black")
    fig.add_hline(y=len(chromosome_ticks_y), line_width=1, line_color="black")
    fig.update_traces(hoverinfo='skip', hovertemplate=None)
    return fig

def plot_protein_visit(Olink_exprs, SNP_anno, pQTL_anno, protein_name, pvalue_cutoff=5e-8):
    filtered_pQTL = pQTL_anno[pQTL_anno["protein_gene_name"] == protein_name]
    filtered_pQTL = filtered_pQTL[filtered_pQTL["P"] <= pvalue_cutoff]
    
    filtered_pQTL = filtered_pQTL.loc[filtered_pQTL.groupby(["OlinkID", "protein_gene_name"])["P"].idxmin()]
    filtered_pQTL = filtered_pQTL.loc[filtered_pQTL.groupby(["OlinkID", "protein_gene_name"])["BP"].idxmin()]
    
    chromosome = f"chr{filtered_pQTL['CHR'].iloc[0]}"
    position = filtered_pQTL["BP"].iloc[0]
    
    qQTL_example_genotype = SNP_anno[
        (SNP_anno["CHROM"] == chromosome) & (SNP_anno["POS"] == position)
    ][["random_ID", "genotype_simp"]].drop_duplicates()
    
    protein_data = Olink_exprs[Olink_exprs["gene_name"] == protein_name]
    plot_data = protein_data.merge(qQTL_example_genotype, on="random_ID", how="left")

    fig = px.line(
        plot_data,
        x="visit",
        y="NPX",
        color="genotype_simp",
        line_group="random_ID",
        markers=True,
        title=f"{protein_name}<br>{chromosome}: {position}",
        labels={"visit": "Visit", "NPX": "NPX", "genotype_simp": "Genotype"}
    )
    
    fig.update_layout(
        width=600,
        height=450,
        template="simple_white",
        legend_title="Genotype",
        title_x=0.5,
        title_y=0.95
    )
    
    return fig