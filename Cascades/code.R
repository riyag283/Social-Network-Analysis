library(igraph)
library(dplyr)

refresh_action <- function(G){
  G <- as.undirected(G,mode=c("collapse"))
  for(i in 1:length(V(G))){
    V(G)[i]$action = 'B'
  }
  return(G)
}

set_seed <- function(G,seed){
  for(i in 1:length(seed)){
    V(G)[seed[i]]$action = 'A'
  }
  return(G)
}

visualize <- function(G){
  for(i in 1:length(V(G))){
    if(V(G)[i]$action == 'A'){
      V(G)[i]$color = 'red'
    }
    else{
      V(G)[i]$color = 'blue'
    }
  }
  plot(G,edge.arrow.size=0.1)
}

checkred <- function(G,node){
  neigh <- neighbors(G, node, mode='total')
  red = 0
  for(i in 1:length(neigh)){
    if(V(G)[i]$action == 'A'){
      red <- red + 1
    }
  }
  return(red)
}
checkblue <- function(G,node){
  neigh <- neighbors(G, node, mode='total')
  blue = 0
  for(i in 1:length(neigh)){
    if(V(G)[i]$action == 'B'){
      blue <- blue + 1
    }
  }
  return(blue)
}
effect <- function(G,a,b,seed){
  for(i in 1:length(V(G))){
   # if(i %in% seed){
   #   next
   # }
    payred = checkred(G,i)*a
    payblue = checkblue(G,i)*b
    if(payred >= payblue){
      V(G)[i]$action = 'A'
    }
    else{
      V(G)[i]$action = 'B'
    }
  } 
  return(G)
}

# input
G <- erdos.renyi.game(10, 0.5)
plot(G)
g1 = G

#G = g1
a <- 5
b <- 2
seed <- c(3,5)

G = refresh_action(G)
visualize(G)
G = set_seed(G,seed)
visualize(G)

G = effect(G,a,b,seed)
visualize(G)

# input graph
makeGraph <- function(){
  n <- as.integer(readline(prompt = "Enter number of nodes: "))
  G <- make_empty_graph(n)
  edges <- as.integer(readline(prompt = "Enter number of edges: "))
  for(i in 1:edges){
    from <- as.integer(readline(prompt = "Enter start node: "))
    to <- as.integer(readline(prompt = "Enter end node: "))
    G <- G + edge(from,to)
  }
  G = refresh_action(G)
  visualize(G)
  return(G)
}

runprogram <- function(G){
  G = refresh_action(G)
  a <- as.integer(readline(prompt = "Enter a: "))
  b <- as.integer(readline(prompt = "Enter b: "))
  seed <- vector()
  nseeds <- as.integer(readline(prompt = "Enter number of seed nodes: "))
  for(j in 1:nseeds){
    s <- as.integer(readline(prompt = "Enter seed: "))
    seed <- c(seed,s)
  }  
  par(mfrow=c(1,2))
  G = set_seed(G,seed)
  visualize(G)
  
  G = effect(G,a,b,seed)
  visualize(G)
  par(mfrow=c(1,1))
  
  casade = 0
  for(i in 1:length(V(G))){
    if(V(G)[i]$action == 'A'){
      casade = casade + 1 
    }
  }
  return(casade)
}

g <- makeGraph()
g2 = g
g3 = g
c = runprogram(g)
