Fatman Evolutionary Model

In the code, 

create_graph(no_of_nodes:n) takes n as parameter and returns a graph of n 'person' nodes having BMIs assigned to them, randomly between 15 to 40.

add_edge(G,n,v) takes graph G, n no. of people nodes in G and v a vector having names of 'clubs' and returns the graph G now also having clubs in the network.

add_edge(G,n,v) randomly assigns people to clubs by adding edges between person nodes and club nodes.

homophily(G,n) implements homophily in this network that is the people who are having singular BMI should become friends with
each other.

closure(G) implements the 3 kinds of closures in the network.

social2(G,n,v) simulates social influence, the BMI of a person node connected to 'gym' club is reduced by 1 and that of the person connected to 'food' club is increased by one on calling this function once.


Results:

We started with a graph with people connected to one community. 
People make more friends due to homophily and the three closures (triadic, foci and membership). 
The people in eat-out community gained BMIs with time whereas people in gym lost.
