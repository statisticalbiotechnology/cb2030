# Q&A on Network Analysis

# Errata

1. In the video about the Girvan-Newman method the edge betweenness is described as a property of a node and that nodes with high edge betweenness are removed. However, in the Network Science book the edge betweenness is described as a property of an edge and that edges with high edge betweenness are removed. This made me a bit confused.. Are they two variations of the method? Or am I misunderstanding something? 

> Good catch! As the name suggests, edge betweenness is a property of an edge. And I did misspeak this in the video.

# Building networks
1. Are there methods of, from a distance matrix or points in R^n to predict a possible underlying network or connectivity between points based on proximity, for example for mapping allosteric protein interactions based on static crystal structures?


2. In Barabási's Network Science book section 2.6 it is meantioned that most scientific networks feature weighted nodes or links. This is most likley very beneficial to more easily discern relevant links or relationships to key genes or proteins. How should we in systems biology evaluate how to weight our data, do we do so manually or is this something we can automate?

3. Network analysis is a powerful method that help us understand&analyse the relationship in and between pathways.  In the case of a node being a protein, is it possible to implement protein deficiency in order to see how it affects the rest of the network? how can that be done? 

4. In Jupiter notebook, the same dataset is analyzed using multiple different methods always showing different results/networks. With different possible options from the same data, how do we make sure that we choose the correct method? do we need to have knowledge of the system in advance? Furthermore, I assume that we label data for the nodes in for example protein/gene interactions, but I can also see the possibility that some nodes won't be labeled. How is this affect the analysis of the pathway? or do we only include the nodes with which we have previous knowledge? For example, can a network analysis find a missing unidentified protein in a protein network, by saying there should be something here? 

5. What could the weights represent in a weighted protein network? 

6. How do we determine the edge weights?

7. Could you elaborate how one would prove weighted links while studying biological systems? Do the weights increase if there exists previous research, fundamental concepts or hypotheses regarding a particular link? Usually while studying interactions in STRING, you see various colors represented with how the links are formed. Can we infer that more the number of lines, the greater the weight?

8. In a biological context, when would we want to use a directed network instead of an undirected network?

> There is not one way correct way to create a network given a problem/data. Always remember that you are in charge of defining what a node, and most importantly, what a relationship means in you context. A network is a tool as flexible (or perhaps even more) as a data table. 
> Always keep in mind then that the results of your analysis will depend heavily on the way you constructed the network, so it is as important to translate the network analysis results back as it is to construct the network correctly.

9. In the presentation and the jupyter notebook, there is this concept of "preferential attachment" and that many biology networks are formed by preferential attachment,  is there a biological explanation for this (why nodes with high degree tend to accumulate more interactions)?

> A biological explanations will, of course, depend on what system we are looking on. An easy example would be the size of ant colonies, as larger colonies will produce more ants.

# Network properties

1. The sentence from the video: "Since every subset of a clique is also a clique, we talk of maximum cliques as cliques that are not a subset of any larger clique". Can you explain this further or give an example?

2. Could you please explain cliques a little further? I am confused if the maximum clique is the most densely connected set of nodes or the set of nodes that do not connect to other cliques. It seems to contradict the idea of a clique.

> Think of a set of 5 nodes that are all connected to each other, therefore forming a clique. Select 4 nodes out of those 5, they by definition are also connected to each other, and so also belong to a smaller clique.

3. In the bridges of Königsberg example, based on what property of the graph can we determine if an euler circuit exists?

4. Eulerian and Hamiltonian paths are quite famous and i understand what they are. What kind of information/usage do they provide? 

> Since in an Euler cycle all the edges have to be visited, there is no local property that can tell us if there is such a path or not.
> In a Hamiltonian path it's all the vertex that have to be visited. We will see a very interesting application of these on class.

4. Is there a way to calculate the average cluster coefficient when we are dealing with directed and weighted networks?

> Yes, as many things on networks, this concept has been expanded for both weighted and directed graphs (Wikipedia can point you to those solutions). Yet before going down this path, ask yourself what clustering means in the context of the weighted/directed networks you are working on and see if they fit your idea.

5. In Barabasi 2.5, it is said that most real networks are sparse and therefore their adjacent matrices contain lots of 0s, which takes up a lot of storage space for no valuable information. In that case, using a list is suggested. For example, if we had this adjacent matrix of dimension 4x4. Then it would be favorable to store the list below with a dimension 1x5 instead. However this representation seems less useful since we directly store the identity instead 0s and 1s. No calculations/projections can then be performed with this vector? Are there situations where the matrix would still be kept? 

6. In the Barabási’s Network Science book, section 2.6 the author says: "In real networks L is much smaller than Lmax, reflecting the fact that most real networks are sparse. We call a network sparse if L‹‹ Lmax." I am not really sure that I understand what he means by the network being sparse, could you perhaps explain this in other words? Also, does the real network "lose" information when L‹‹ Lmax?

7. When discovering a new node in any scientific network or when a certain node/link has been under-/overestimated in previous studies, how large impact does it have on the reconstruction of the entire network? In the first command of the "Loading the data and creating the network" in jupyter, a 5x2 matrix appears. Can it be that the missing columns were omittable zeros?

> A sparse network is a network where most of the links that can possibility exist are not there. This is in contrast with a dense network where most of the nodes are linked to all the other nodes.
> To store a network with a full matrix, we need a matrix that has a number of elements that is the square of the number of nodes, no matter how many links there are. It is indeed much easier to perform operations with them since they are in the end just matrices.
> However these matrices can get big quite fast. And that is why most are stored in sparse format. That is, we only record the presence of links, and the absence of a recording is inferred as the absence of a link. It is harder to perform operations in this format, however most computational software packages can use these two representations interchangeably.

8. Both in the video and the book the network shown in the picture is discussed. In this network, the nodes at the bottom are isolated or have a low degree (k=0 - k=2). In the case of isolated nodes, how were they connected to the rest of the network? Can these nodes at the bottom be a source of problems? For example, when we have to compare two networks, could a network with a high quality in the core region but some isolated nodes be considered worse than a network withouth isolated nodes but poor linking?

9. In the book by Barabási, image 2.4 shows a protein network with some nodes unconnected (shown below). In the analysis would we just ignore this data or would we try to see whether there is another network where the outliers belong to the network?

10. In the jupyter notebook we first remove the nodes that are not connected to any other node, is there some situation where we are interested in analyzing these nodes (the nodes that have no links)?

> Isolated node are just a feature of how the network was constructed. After coming up with a suitable definition for what relationships you want represented as links, it may be natural that some node will have no such relationship with other nodes. Again this is a function of how the network was constructed, and not the underlying system itself.

11. How can we convert an undirected network to a directed one (selecting the direction we want)?

> Usually a link in an undirected network represents a symmetric relationships, and as such it is not suitable to be translated into a directed network. However, there are cases in a directed network where you might want to represent symmetric interactions, and you can do so by using two links, going on the opposite direction of each other, and with the same weight. 

12. In case of a degree distribution analysis: How are you reading the graph that is supposed to help in the network analysis understanding. In the slides there are two examples but I don't really understand how to read the graph accordingly.

> Degree distribution is a very powerful tool and it gives you a quick glimpse of how the network is wired. Before looking at the graph think to yourself: do I expect that all my nodes are connected in equal measure, or are there more important nodes, such as hubs, probably present? This is one of the things this distribution can tell you. 


13. Regarding the clustering coefficient: How can I infer the degree of local clustering from the average clustering coefficient - are there typical cut-offs whether there would be a significant degree of local clustering or not? Would it in that case be useful to look at the distribution of local clustering coefficients? And does it in general hold true that hubs have a low clustering coefficient or are there examples of networks with hubs that have a high clustering coefficient? For example thinking about biological networks, is there maybe a set of central metabolites interacting which as a community on their own function as a hub that connects the rest of the network?

> As with all statistics, analyzing the distribution is better than just looking at the average.
> There is no reason why a hub could not have a high clustering coefficient, and this comes down to whether the neighbours are all connected as well. If this is likely to occur or not will again depend on how the network was constructed.



# Network algorithms

1. Why do we determine the path diameter and the connectedness by using BFS and not DFS? When is it better to use BFS and when it is better to use DFS (in which situations are they used)?Is one of them better than the other (in general)? If yes, why?

2. Where is breadth first search more useful than depth first search and vice versa?

> If you are looking to only visit all the nodes in your network, then both methods are equivalent.  
> However, the process of getting there might also be useful. For BFS, since it always visits the direct neighbours first, it always takes the shortest path possible (but maybe not the only shortest) to each node, and therefore it is used for many algorithms that need the shortest path. If, however, you only want to find out **if** there is a path between two somewhat distant nodes, than DFS might be a better alternative, since it follows each path to its length before starting over. These are just some examples. 

3. What is the faster algorithm for a global minimum cut of a graph?

> Which algorithm is faster will depend on the network you have. However, most algorithms are very fast and will not make enough difference for most but the largest networks. 

4. Regarding the minimum cut algorithm in the video lecture, it is mentioned that the algorithm tries to divide the network into similar-sized groups, by cutting edges in a manner that the number of cuts through edges is minimised. My first question is how to determine the number of groups in a network, do procedures similar to information criteria in clustering algorithms exist? Secondly, doesn't this approach often result in insignificant community detection in real life networks, as it is mentioned by Barabási that real networks are usually sparse and only a small number of hubs exists?

> As mentioned above, this algorithm is very fast, and that is it's advantages. In reality however, the assumption that all the groups have the same size is very difficult to hold, and that is why this algorithm is rarely used. 

5. Referring to the minimum cut in a community structure, it minimizes the number of the edge. I was wondering about the difference between the minimum cut and the minimum spanning tree? Though both of them minimize the links, are the differences that the minimum cut shows our favorite nodes separated from all nodes and the minimum spanning tree just contains all nodes?

> They are really very different algorithms, as the name suggests, minimum cut cuts the network into two. The minimum tree in the other hand, gives you **one** network that contains all the nodes from the original network, but with the least amount of links possible so that all the nodes still have a path to each other.

6. What information does the minimum spanning tree provide in a biology related context? 

7. Would it be possible to have different paths on a cyclic network? If so, what biological information would give the largest shortest path in front of the other alternatives?

8. How do we choose the network algorithm to describe our system of interest? Is it enough to know which type of system we want to study, for ex. a protein-protein interaction network? What else do we need to know about the system? 

> As we see in the class, even a protein-protein interaction network can be constructed in a lot of different ways. Depending on how it is constructed, a

# Community detection

1. How do you validate the robustness of a community structure network?

> A good way to test robustness in any algorithm is to perturb the input slightly and see how the results change. In this case you can perturb the link weights or even remove some edges and see it the communities stay roughly the same.

3. In the last slide of the video lecture there is a figure showing which community detection algorithm to use based on the network size and the mixing parameter. What is this mixing parameter and how is it determined?

> You can look in the paper itself for the specific definition of the mixing parameter, but the intuition it that it is the ratio of links **between** communities over the total number of links in the network.


5. In the video, it seems network analysis is aiming to find the communities (which similar to clusters concept) in a high dimensional dataset, which the conventional clustering algorithms are hard to do that. My question is, 1) It seems many clustering algorithms works well while we do dimension reduction first. What's the exact benefit to do network analysis?  2) Is the finding communities only one of the many applications for network analysis? Taken the Scilifelab-KTH distance example, can I say that network analysis is also able to judge the distance between two communities, while conventional clustering might harder to do that? 

6. In the video lecture it is mentioned that "regular" clustering is not a good approach when it comes to networks, as the data is very highly dimensional (in theory one dimension per node). It made me associate to other high dimensional data that we cluster through dimension reduction, e.g. using PCA. I can't quite finish the thought myself, and I have a feeling it wouldn't make any sense for some reason, but what happens if we use dimension reduction for clustering of a network?

> Networks are a different way of representing data where the concept of "dimensions" doesn't strictly apply. Therefore there is no direct way to perform dimensionality reduction on a network.

# Questions I didn't understand

1. You mention in the video that traditional clustering is not preferred for community structures and you need a measure of similarity. Distance because of embedding problem and presence of multiple dimension is not a good choice. What else could be be a good measure of similarity between different networks?

2. Is there a risk with label propagation that your resulting network communities are all low in numbers and quite big since an increase in nodes belonging to a specific community will increase the probability that an unclassified neighbour has a lot of neighbours classified to said community and therefore also be assigned to it?
