# From knowledge to network

1. In the article they mention that some systems are so large we have not yet fully mapped them, for example neurons within the human brain. However, I feel like there are a lot of examples where we might miss some interactions, for example in gene regulatory networks. Are there any thumb rules for when to accept a system "fully mapped"? Are there any tools for trying to predict if a connection or relationship is missing?

> When buiding a model, it is good to keep in mind the old adage "everything should be made as simple as possible, but no simpler." There are always things left out from your model, and at some point including more details on your model will detract from your ability to make inferences on that model, instead of helping.


2. Since many pathways in a cell are codependent on each other, is it possible to have a network of pathways?

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

# From networks to knwoledge

1. There are many algorithms to divide data points into communities, but different algorithms can result in different communities, if that can we get the same interpretation of this network when using different algorithms? If not, which one do we prefer to use in real case?

> 

# Networks in biology

1. Networks are a nice way to visualize interactions, but what conclusion can you draw from network analysis in a biological context beyond visualization?

> This is a very broad question, but I will point you to the fields of Systems Biology (!) and Network Medicine as good examples on where you might find your answer.

2. Are not most of the biological networks directed networks? Are there examples of non-directed networks in a biological concept?

> A good example of undirected network would be a gene coexpression network.


# Network properties

1. The concept of connected components was not very clearly described in the video. If you have 2 or more separated entities (each entity itself may consist of nodes that are linked via edges) that are not connected with each other, why are those not 2 independent “networks”. I don’t understand how a network can consists of multiple connected components, even though these are not connected (no common links) accordning to the youtube video.

> If a network is defined as a collection of nodes and links, there is nothing on that definition that states all nodes should be connected. You are correct that each of the connected components are also (sub)networks, but so is the original one.
It again depends largely on what you are modelling with the network.

2. In a bipartite network, wouldn't projection potentially make the interactions harder to interpret? As an example (not sure how correct it is), if looking at cancer diseases and genes, TP53 would be linked to many cancers (>50% of them according to Wikipedia), so projecting to get a disease graph would link lots of cancers due to TP53 even if they are otherwise not at all related (even if the fact that TP53 conncets them could be interesting in itself).

> This again depends on different cases. You are (probably) correct that all cancers would be linked by TP53, but depending on how you construct the network, you might find other unexpected ways on which they are connected. The tool is only as your reason for using it.

3. Would weighted networks be able to handle multidimensional data or would you have to reduce the dimensions down to one?

> Networks can definetely handle multidimentional data. However, networks usually exist outside the traditional cartesian space, that is, cannot be represented by a series of vectors. The process of converting a network to cartesian space is called "embedding" and is by no means trivial.

4. In the video you mentioned preferential attachment, i.e. that the probability of a node having a link to it is proportional to the amount of links it already has. What does this mean, practically? Are there any other methods to determine the probability of a link?

> Preferential attachment in this context in that context reffers to a way in which the system represented by the network has evolved over time. In that particular example (social network) the probability relates to the probabilty that a person connects with someone else, which is often proportional to the amount of people they already know.

5. You said a sentence in the video that maximum clique is just what we need to find in a network, why it is important? Can you give an example in real case?

> [This article](https://www.pnas.org/content/100/21/12123) is a good example of using cliques (and other techniques) to find protein modules in a protein interaction network.


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

6. In the Jupyter Notebook, section Community detection, the Girvan–Newman algorithm is used to generate a list of partitions. It is then mentioned that "You can see that there are many levels of the hierarchical structure, and a list of all the nodes in each community at every level". What is ment by the hierarchical structure and its levels? Does it refer to different solutions of the community detection algorithm? Why did you choose the fourth level (and how do you know which one to choose)?

> The Girvan-Newman algorithm works iteratively fist by "cutting" the network in two communities, and then cutting one of the resulting communities in two, and it continues doing so until there are no more cuts to be made, because all communities contain only one node. It is up to you to descide when you want to stop cutting, and there are many structured ways to do so, for instance, you may select the partition that gives you the largest [modularity](https://en.wikipedia.org/wiki/Modularity_(networks)) on the network.
If you backtrack the algorithm, you will find that at any iteration it will join two communities, in an analogous way to hierarichical clustering, and that is where the hierarchy comes from.


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
