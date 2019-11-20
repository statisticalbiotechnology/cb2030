# From knowledge to network

1. In the article they mention that some systems are so large we have not yet fully mapped them, for example neurons within the human brain. However, I feel like there are a lot of examples where we might miss some interactions, for example in gene regulatory networks. Are there any thumb rules for when to accept a system "fully mapped"? Are there any tools for trying to predict if a connection or relationship is missing?
> When buiding a model, it is good to keep in mind the old adage "everything should be made as simple as possible, but no simpler." There are always things left out from your model, and at some point including more details on your model will detract from your ability to make inferences on that model, instead of helping.

2. Since many pathways in a cell are co-dependent, is it possible to have a network of pathways?
> Yes, it is absolutely possible, but before constructing such network, you have to ask yourself how you will study it and whether it will help you attack the problem you want to study.

3. In the readings, they state "Most networks of scientific interest are weighted, but we can not always measure the appropriate weights. Consequently we often approximate these networks with an unweighted graph."  
Does this mean that there is a way of measuring the weights of the links? If so, how?
> Usually, this is done the other way around. You have some phenomena that connects two things and you might want to use the strenght of that phenomena as the weight of the link between them.

4. How is the actuall geometry of a network determined, if the only data that is saved about the network is the weight and the conections between the nodes?
> The topology of the network is formed exclusively by the connections in the networks.

5. My question is two part question:
 In the Jupyter notebook, the networkx takes the input as edges. I do not completely understand what the data represents and partially the reason why I do not understand as to why the input is taken as edges and not as nodes itself.
  - Is it done because the package is designed to take edges as input?
  - Or is that a standard way to define a network i.e. values in the data always corresponds to edges and nodes are derived by the algorithm?  

  Further, If we consider an example where we have a single cell RNA-seq data, and we plan to determine the covariation (which if I understand correctly is a type of interaction) between genes, then we would end up with a matrix that is similar to the one that is loaded into the jupyter notebook. In this case the numbers would correspond to the transcript abundance. Now, if I want to find covariation between two genes, then can I take each value in the table as a node and then generate edges i.e. interactions based on that?
> A network is defined by nodes and links, and it just happen that networkx is smart enough that when you ask it to add a link involving a node that has not been added to the network yet, it adds the node first and then links it. You can also add the nodes independently.
> You can create a network from a covariance matrix, but there are many ways to do it. The most obvious one is to have the nodes represent the transcripts and the links the covariance between two nodes. The drawback of constructing the network this way is that the network will be dense, that is, all nodes connect to each other.

6. Weighting edges is a way of telling the network that between these two nodes, there is a stronger interaction. But if we are exploring de novo connections of a studied system, on what basis can we weight the edges on?
> Usually, you would fist determine the nature of the interactions on your system of study, and then construct the network accordingly.

7. In the book, section 2.2, they point out that "some networks simultaneously have directed and undirected links" for example some metabolic networks which have both reversible and irreversible reactions . How do you treat these type of networks, e.g. when you want to calculate network metrics? Should the different characteristics (directed and undirected) be treated separately or is there some middle-way where you can deal with them both in one?
> If a network has both directed and undirected links, treat it as a directed network, and for the undirected links, establish two links, one going in each direction.

8. how is an edge weighed or scored in a directed network? Does it depend on the relationship between two nodes and a particular distance like euclidean calculated between the nodes? 
> There is no general answer to this question, as different networks are defined in different ways.

9. In the notebook, you used the connected components function. Can you interpret the result of it a little? As my understanding, the lonely nodes are nodes that don't have any connection with the other node as there is only one number in the bracket, but then why it will be shown in the result of connected components function since "it returns all the subgraphs consisting of nodes that are connected by any path".
> A single node is still a subgraph.

10. When we want to choose an algorithm to cluster the network, which features of the network should be considered to find a suitable algorithm?
> The main thing you should focus on is how well the assumptions of the algorithm reflect the dynamics of the system you are studying.

# From networks to knowledge

1. There are many algorithms to divide data points into communities, but different algorithms can result in different communities, if that can we get the same interpretation of this network when using different algorithms? If not, which one do we prefer to use in real case?
> Each algorithm makes different assumptions about the nature of communities. Everytime you get some results results, you shoudl always go back to those assumptions to see what they mean on the real system you are studying. And in this sense there is no algorithm that is better on all cases.

2. In a biological network such as a network modelling protein-protein interactions - what would computing these types of network analysis metrics give you? What conclusions can you draw from clustering coefficients and average shortest path in such a network?
> This always depends on what is your network representing. Even protein-protein interaction networks can be constructed in different ways.


# Networks in biology

1. Networks are a nice way to visualize interactions, but what conclusion can you draw from network analysis in a biological context beyond visualization?
  > This is a very broad question, but I will point you to the fields of Systems Biology (!) and Network Medicine as good examples on where you might find your answer.

2. Are not most of the biological networks directed networks? Are there examples of non-directed networks in a biological concept?
 > A good example of undirected network would be a gene co-expression network.

# Network properties

1. The concept of connected components was not very clearly described in the video. If you have 2 or more separated entities (each entity itself may consist of nodes that are linked via edges) that are not connected with each other, why are those not 2 independent “networks”. I don’t understand how a network can consists of multiple connected components, even though these are not connected (no common links) accordning to the youtube video.
> If a network is defined as a collection of nodes and links, there is nothing on that definition that states all nodes should be connected. You are correct that each of the connected components are also (sub)networks, but so is the original one.
It again depends largely on what you are modelling with the network.

2. In a bipartite network, wouldn't projection potentially make the interactions harder to interpret? As an example (not sure how correct it is), if looking at cancer diseases and genes, TP53 would be linked to many cancers (>50% of them according to Wikipedia), so projecting to get a disease graph would link lots of cancers due to TP53 even if they are otherwise not at all related (even if the fact that TP53 conncets them could be interesting in itself).
> This again depends on different cases. You are (probably) correct that all cancers would be linked by TP53, but depending on how you construct the network, you might find other unexpected ways on which they are connected. The tool is only as good as your reason for using it.

3. Would weighted networks be able to handle multidimensional data or would you have to reduce the dimensions down to one?
> Networks can definetely handle multidimentional data. However, networks usually exist outside the traditional cartesian space, that is, cannot be represented by a series of vectors. The process of converting a network to cartesian space is called "embedding" and is by no means trivial.

4. In the video you mentioned preferential attachment, i.e. that the probability of a node having a link to it is proportional to the amount of links it already has. What does this mean, practically? Are there any other methods to determine the probability of a link?
> Preferential attachment in this context in that context reffers to a way in which the system represented by the network has evolved over time. In that particular example (social network) the probability relates to the probabilty that a person connects with someone else, which is often proportional to the amount of people they already know.

5. You said a sentence in the video that maximum clique is just what we need to find in a network, why it is important? Can you give an example in real case?
> [This article](https://www.pnas.org/content/100/21/12123) is a good example of using cliques (and other techniques) to find protein modules in a protein interaction network.

6. What is the exact use of finding a maximum clique in a network ? Does it represent something ?
> It's important to note that there can be mant maximum cliques in a network. Again, to undertand what the maximum clique means you have to go back to how the network was fist defined. Different networks will have different interpretations. 

7. Regarding on clustering coefficient in the book,  the average clustering coefficient (C) is explained to define the degree of clustering for undirected networks. The clustering coefficient is also used for directed and weighted networks. I wonder the global clustering coefficient can be applied to both undirected and directed, or weighted networks?
> The deffiinition of clustering coefficient presented on that chapter of the book is only aplicable to undirected, unwheighted graphs. However, you can follow the references [13, 14, 15, 16] on that chapter for generalizations of that deffinition for other types of networks.

# Network algorithms

1. In the jupyter notebook, the two graph traversal algorithms generate tree objects. What exactly do these depict/tell us?
> They represent all the nodes reached, connected by only the links used by the algorithm. If you remember, the algorithm never visits a node that has already been previously visited, therefore, there will be no cycles, and a network without cycles is a tree.

2. Is it the pathway analysis a part of network analysis or these two are totally different concepts? If they are different, could you clarify their differences, especially their usefulness in terms of situation?
> They are mostly separate methods. The most common pathway analysis methods only consider a pathway as a set of genes, and not a network.

3. In my understanding, the graph transversal algorithms are the different method to read the graph, but the graph itself including the nodes and edges should be the same. Why the graph looks different in the Jupyter notebook between two algorithms?
> Graph traversal algorithms are ways of **exploring** the netowork in a structured way, and it is usefull in many ways, but it will not return a full representation for the network. It returns all nodes reacheable from the root node, as well as all the links used in the exploring. Since the two algorithms explore the network in different ways, they will return the same nodes, but different links.

4. As seen in Barabàsi's book (chapter 2), we can exploit the breadth-first search to determine various characteristic of the network (e.g. shortest path, diameter, components)... but the depth-first method is never mentioned again. Is it ever used? Does it have any functional purpose at all?
> By definition, BFS always returns a shortest path between the root node and any other node (but only on an unwheighted graph), and thus it can also be use in other methods that involve using shortest paths (diameter). But both DFS and BFS will give you the connected components.

5. In the Notebook you mention a "clever dynamic programming technique" that is used to find the average shortest path in a faster (and I guess non-holistic) way. What is that?
> That is the [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)

6. In the Jupyter Notebook, section __Community detection__, the Girvan–Newman algorithm is used to generate a list of partitions. It is then mentioned that "You can see that there are many levels of the hierarchical structure, and a list of all the nodes in each community at every level". What is ment by the hierarchical structure and its levels? Does it refer to different solutions of the community detection algorithm? Why did you choose the fourth level (and how do you know which one to choose)?
> The Girvan-Newman algorithm works iteratively fist by "cutting" the network in two communities, and then cutting one of the resulting communities in two, and it continues doing so until there are no more cuts to be made, because all communities contain only one node. It is up to you to descide when you want to stop cutting, and there are many structured ways to do so, for instance, you may select the partition that gives you the largest [modularity](https://en.wikipedia.org/wiki/Modularity_(networks)) on the network.
If you backtrack the algorithm, you will find that at any iteration it will join two communities, in an analogous way to hierarichical clustering, and that is where the hierarchy comes from.

7. I did not fully understand the explanation of minimum cut. It says that the algorithm divides the nodes in as many groups as possible that contains as many nodes as possible. How is this possible to do at the same time? As many groups as possible should according to my intuition contain as few nodes as possible?
> The video might have been confusing. You tell the min-cut algorithm how many communities you want and it tries to divide the networks in that many __equal__ parts, using cuts that pass through the smallest amount of edges possible, so in the end you end up with groups that are approximately equal in size.

8. BFS algorithm seems demanding for computer in networks with massive amounts of nodes and links, e.g. citation network. Is there an alternative algorithm more practical for such an extensive network?
> BFS is itself very fast, as its complexity is **linear** in terms of number of vertices and edges. But it is also a very versitile algorithm that can be used for many things, and you might find better algorithms for more specific cases. 

9. Regarding minimum cut as an algorithm to find network communities: does the algorithm find the optimal number of communities or does the user decide in how many communities should the network be divided (as in k-means clustering, where the user selects k)? If the last case were true, are there any other algorithms to complement minimum cut and decide how many comunities does our network have? 
> For the minimum cut algorithm, you do have to specify the the number of communities. However, the biggest issue with the algorithm is the fact that all its communities have equal size, an assumption that generally does not hold in most systems.

10. Since the clustering algorithms works differently do they also give different clustering coefficients? Is it common to run more than one clustering algorithm to be able to interpenetrate the results correctly? 
> Your abilty to interpret the results correctly is much more influeced by whether or not the assumptions of the algorithm hold or not on your system, that the performance of the algorithm itself. However, it is not rare to use more than one commuinty detection algorithm and [ensemble](https://en.wikipedia.org/wiki/Ensemble_learning) the results.

11. I did not fully understand the minimum cut algorithm, you say in the video that firstly you divide the network into a number of communities, after that you try to divide the network in as many equal parts as possible that is containing as many nodes as possible, why do you divide the network in equal parts? Then you explain that the separation between the nodes (the cut) passes through the least amount of edges possible, how is this done? 
> I won't go into detail on how the algorithm works, but you can find it [here](https://en.wikipedia.org/wiki/Karger%27s_algorithm). The main idea is that you specify the number of communities, and it will result in that many communities that are of equal size and are as leat connected (less edges) as possible as possible.

12. The Multilevel modularity algorithm (Louvain algorithm) can be applied on a network to find communities within the latter. Nodes a progressively merged into communities if they improve the modulatory of that community. In a second, step communities are also merged together into single nodes. The Louvain algorithm is presented in the articles as one of the most accurate but doesn’t it “ignore” smaller, distinct communities that are likely to end up merged into a bigger one?
> (Answer by student) It doesn't, because the information about the smaller modules is not lost. What you depicted is indeed the common drawback of modularity-based methods (it's called "resolution limit": the size of identified groups depends on the size of the whole network), but it's overcome by the Louvain algorithm. It's called "multilevel" because it can detect different levels of modules: the bigger ones and also the sub-modules within them. However, one issue is that once two nodes have been merged into a module, they can never be separated again and are forced to "travel together" to the upper levels.

13. The minimum cut algorithm for community detection tries to make groups of the same size. This seems, to me, a big assumption that will rarely correspond to any real group in a dataset, since I would expect groups of varying sizes. When can this type of algorithm be useful?
> You are correct that this is generally the case. This algorithm is rarely used nowadays and I included it in the presentation for historical reasons, as it was one of the fist. (This was been widely regarded as a bad move) 

14. In slide 21 (minimum cut),  you mean that the correct cut would be the green one, and this is because it passes through the least amount of edges, right?  Wouldn't it be an equally correct result if this cut was between the down-left node and all the other nodes? And if yes, every time we would run this algorithm would get one of these two cuts randomly, or we would get both the results?
> Both cuts are correct in that case, since we are trying to separate the network into 3 different parts.



# Composite

1. a) In the networkx module in python there is a possibility of doing a directed network using the Digraph class. Would the input file look different than the one used in the case of an undirected method? In case that a network has both directed or undirected relationships of the nodes how would this could be done in the networkx module?  
  b) In the Label propagation algorithm the first step is to assign labels in the nodes based on our interpretation of in which community we think they belong. How would this assignment affect the result in case it doesn't represent the reality? Is this algorithm widely used since it is not reproducible?  
  c) How would the edge weights be visualized in the case of a weighted network? In case we were doing the first steps of exploring the network like they were performed in the Jupyter Notebook, which steps would have been done different or what steps would have been added?
> a) In a directed network, the input of [node1 node2] is takes as a directed edge *from* node1 *to* node2, given it its direction. If a network has both directed and undirected edges, you shoud treat it as a directed network, and use two link in opposite directions for nodes where you want to represent an undirected link.  
> b) This is a case of the tool only being as good as the hand that weilds it. This algorithm is widely used because it is fast, and given a good input, will produce reasonable results that will help you understand your system.  
> c) There are many ways of visualizing a network. One ways in whichs the weights can be used is a forces in a "force-directed graph visualization". But I did not understand the last part of your question.

2. a) What is the "Depth and Breath first search" algorithm doing?  
  b) In the presentation many clustering methods were mentioned but sadly all of them on the side. Would it be possible to describe one of them more in detail so we get an understanding how it works?
> a) They are two different algorithms that do essentially the same thing, explore the network from a root node, in a structured way, and give you all the noodes reachable from that node.  
> b) The book "Network Science" on the reading list is a good place to start, Chapter 9 is exclusively about communities in networks.


# Unclear

1. So the networks mentioned in the files are undirected and directed. But they are all used for explaining data not for data analysis. What does one need to change to create a network capable of predicting outcomes from data.
  > Networks themselves can not be predictive. You need to apply your own definitions and rules to make use of them. This is not very different than other descriptions of data. E.g. numbers are neither predictive nor useful just as logic entities. It is just when you apply your own definitions of what the numbers stand for that they become useful. E.g. one apple plus one apple is two apples.
  You can easily apply a rule like "Hubs in protein-interaction networks are good drug targets", to predict drug targets.

2. In the Jupyter notebook “network”, the structure of the small network changes after the fourth level of the detected hierarchy was visualized. Does the detection of the hierarchy affect the structure of the network? Do the different levels of the hierarchy adopt different structures of the network? If so, why?
> It is unclear what you mean here by structure change, but as a rule, a community detection algorithm does not affect the network structure, and only labels its nodes.

3. Is it possible to determine network analysis in more than two dimensions?
> It is unclear to me what do you mean by dimesions here. But see question 3 in network properties. 

# Out of scope

1. Which network inference tools gives directionality and sign for interactions for the gene expression data? How many replicates are necessary to give good predictions?  
What are current challenges in assessing directionality of the protein-protein interactions? How to evaluate the robustness of the network with flows? How to evaluate the complexity of the algorithm and  what complexity is appropriate  for specific network size? 
