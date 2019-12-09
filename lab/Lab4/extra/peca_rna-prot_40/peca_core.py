"""peca summary table and plots"""
from collections import Counter
#from pathlib import Path
from sys import stdout

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages


NPROT = sum(1 for line in open("x.txt"))-1
NSAMPLES = sum(1 for line in open("s_RR"))


NREPS, NTIME = (int(x) for x in open("attr.txt").readline().rstrip().split('\t')[:2])
#print(NREPS, NTIME)


RR = np.zeros((NPROT, NTIME-1))
for line in (l.rstrip().split('\t') for l in open("s_RR")):
    RR += np.array(line, dtype=float).reshape(NPROT, NTIME-1)
RR /= NSAMPLES


CPS = np.zeros((NPROT, NTIME-2))
for line in (l.rstrip().split('\t') for l in open("s_CPS")):
    CPS += np.array(line, dtype=int).reshape(NPROT, NTIME-2)
CPS /= NSAMPLES

### append the fdr columns
CNT = Counter(CPS.flatten())

SORTKEY = sorted(CNT, reverse=True)

FDRMAP = dict()
DENOM = CNT[SORTKEY[0]]
NUMER = (1-SORTKEY[0])*DENOM
for key in SORTKEY:
    FDRMAP[key] = NUMER/DENOM
    NUMER += (1-key)*CNT[key]
    DENOM += CNT[key]
#print(SORTKEY)
#print([FDRMAP[x] for x in SORTKEY])

with open('imputex.txt') as xX, \
        open('imputey.txt') as yY, \
        open('data_R_CPS.txt', 'w') as cp_:
    #cp_.write(xX.readline().rstrip().split('\t', 1)[1] \
    #        +'\t'+yY.readline().rstrip().split('\t', 1)[1] \
    cp_.write('\t'.join(z+"_X"+str(int(n/NTIME))+"t"+str(n%NTIME) \
        for n, z in enumerate(xX.readline().rstrip().split('\t')[1:])) \
        +'\t'+'\t'.join(z+"_Y"+str(int(n/NTIME))+"t"+str(n%NTIME) \
        for n, z in enumerate(yY.readline().rstrip().split('\t')[1:])) \
        +'\t'+'\t'.join(['R'+str(i) for i in range(NTIME-1)]) \
        +'\t'+'\t'.join(['signedCPS'+str(i) for i in range(1, NTIME-1)]) \
        +'\t'+'\t'.join(['FDR'+str(i) for i in range(1, NTIME-1)]) \
        +'\n')
    for i in range(NPROT):
        cp_.write(xX.readline().rstrip() \
            +'\t'+yY.readline().rstrip().split('\t', 1)[1] \
            +'\t'+'\t'.join(str(x) for x in RR[i,]) \
            +'\t'+'\t'.join(str(x*(1 if RR[i, n] > RR[i, n-1] else -1)) \
            for n, x in enumerate(CPS[i,], 1)) \
            +'\t'+'\t'.join(str(FDRMAP[x]) for x in CPS[i,]) \
            +'\n')


###loglikelihood traceplot########################
plt.title('loglikelihood traceplot')
plt.plot(range(1, NSAMPLES+1), [float(x) for x in open('s_loglike').readlines()])
plt.savefig('trace_loglike.pdf')
##################################################


EFSY = dict()
XAX = []
with open('EfsY.txt') as efsy:
    #XAX = efsy.readline().rstrip('\n').split('\t')[3:]
    XAX = [float(x) for x in efsy.readline().rstrip('\n').split('\t')[3:]]
    for line in (l.rstrip('\n').split('\t') for l in efsy):
        #EFSY['\t'.join(line[:3])] = line[3:]
        EFSY['\t'.join(line[:3])] = [float(x) for x in line[3:]]

EFSX = dict()
#EFSXPATH = Path("EfsX.txt").is_file()
#if EFSXPATH:
with open('EfsX.txt') as efsx:
    efsx.readline()
    for line in (l.rstrip('\n').split('\t') for l in efsx):
        #EFSX['\t'.join(line[:3])] = line[3:]
        EFSX['\t'.join(line[:3])] = [float(x) for x in line[3:]]

ETAY = np.array(open('mean_xRyD').readline().rstrip().split('\t'), \
        dtype=float).reshape(NPROT, NTIME*NREPS)


with PdfPages('mRNAprot.pdf') as pdf, \
        open('x.txt') as xx, \
        open('y.txt') as yy, \
        open('imputex.txt') as xX, \
        open('imputey.txt') as yY:
    xx.readline()
    yy.readline()
    xX.readline()
    yY.readline()
    for p, linex in enumerate(xx):
        x = [(i if i != 'NA' else np.nan) for i in linex.rstrip().split('\t')[1:]]
        x = np.array(x, dtype=float)
        X = np.array(xX.readline().rstrip().split('\t')[1:], dtype=float)
        y = [(i if i != 'NA' else np.nan) for i in yy.readline().rstrip().split('\t')[1:]]
        y = np.array(y, dtype=float)
        Y = np.array(yY.readline().rstrip().split('\t')[1:], dtype=float)
        #if p > 10:
        #    break
        plt.figure(figsize=((NREPS+1)*4, 2*4))
        plt.suptitle(linex.rstrip().split('\t', 1)[0])
        print('\x08'*99, p, '/', NPROT, end=' ')
        stdout.flush()

        for j in range(NREPS):
            plt.subplot(2, NREPS+1, j+1).set_title('log(mRNA) '+str(j+1))
            plt.ylim(np.nanmin(x), np.nanmax(x))
            plt.scatter(range(NTIME), x[NTIME*j:NTIME*(j+1)], c='k')
            plt.scatter(range(NTIME), X[NTIME*j:NTIME*(j+1)], \
                    facecolors='none', \
                    edgecolors=np.where(np.isnan(x[NTIME*j:NTIME*(j+1)]), 'red', 'black'))
            #if EFSXPATH:
            plt.plot(XAX, EFSX[str(p)+'\t0\t'+str(j)], 'k-')

        plt.subplot(2, NREPS+1, NREPS+1).set_title('Protein regulation')
        plt.xlim(0, NTIME-1)
        plt.ylim(0, 1)
        plt.step(np.arange(0.5, NTIME-0.5), RR[p,], 'k-', where='mid')

        for j in range(NREPS):
            plt.subplot(2, NREPS+1, NREPS+2+j).set_title('log(protein) '+str(j+1))
            plt.ylim(np.nanmin(y), np.nanmax(y))
            plt.scatter(range(NTIME), y[NTIME*j:NTIME*(j+1)], c='k')
            plt.scatter(range(NTIME), Y[NTIME*j:NTIME*(j+1)], \
                    facecolors='none', \
                    edgecolors=np.where(np.isnan(y[NTIME*j:NTIME*(j+1)]), 'red', 'black'))
            plt.plot(range(NTIME), np.median(Y[NTIME*j:NTIME*(j+1)]) \
                    +ETAY[p, NTIME*j:NTIME*(j+1)], 'k--')
            plt.plot(XAX, EFSY[str(p)+'\t0\t'+str(j)], 'k-')

        plt.subplot(2, NREPS+1, 2*NREPS+2).set_title('Change point probability')
        plt.xlim(0, NTIME-1)
        plt.ylim(0, 1)
        objects = range(1, NTIME-1)
        y_pos = np.arange(1, len(objects)+1)
        plt.bar(y_pos, CPS[p,], align='center', alpha=0.5)
        plt.xticks(y_pos, objects)

        pdf.savefig()  # saves the current figure into a pdf page
        plt.close()

    D = pdf.infodict()
    D['Title'] = 'gene-specific plots'
    D['Author'] = 'guo shou TEO'
