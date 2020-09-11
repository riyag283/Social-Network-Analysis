library(igraph)

girvan <- function(G){
  c = decompose.graph(G)
  l = length(c)
  v <- vector()
  while(l==1){
    x <- E(G)
    y <- edge_betweenness(G)
    z <- which.max(y)
    edge <- x[z]
    a <- ends(G,z[1])[1]
    b <- ends(G,z[1])[2]
    v <- c(v,a,b)
    G <- delete_edges(G,edge)
    c = decompose.graph(G)
    l = length(c)
  }
  if(l==2){
    paths <- shortest.paths(G)
    for(i in 1:length(V(G))){
      if(paths[a,i]!=Inf){
        V(G)[i]$color = "lightblue"
      }
      else{
        V(G)[i]$color = "orange"
      }
    }
    G <- G + edge(v)
    plot(G)
  }
  return(c)
}


g <- read.graph("C:/Users/Riya/Desktop/RHEA/6th sem/SNA/SNA/karate.gml",format = "gml")
plot(g)
c <- girvan(g)
