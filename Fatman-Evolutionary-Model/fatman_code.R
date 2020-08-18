library(igraph)
library(dplyr)
library(png)

create_graph <- function(n){
  G = make_empty_graph(n)
  for(i in 1:n){
    V(G)[i]$name = i
    rand = runif(1,15,40)
    x = round(rand,digits = 0)
    V(G)[i]$label = x
    V(G)[i]$type = 'person'
  }
  return(G)
}

add_foci <- function(G,v,n){
  for(i in 1:length(v)){
    G <- G + vertices(i+n)
    V(G)[i+n]$name = i+n
    V(G)[i+n]$label = v[i]
    V(G)[i+n]$type = 'foci'
  }
  return(G)
}

add_edge <- function(G,n,v){
  for(i in 1:n){
    r = sample(v,1)
    G <- G + edge(i,r)
  }
  return(G)
}

homophily <- function(G,n){
    for(i in 1:n){
      for(j in 1:n){
        if(i!=j){
          diff = abs(as.numeric(V(G)[i]$label) - as.numeric(V(G)[j]$label))
          p = 1/(diff+3000)
          r = runif(1)
          if(r < p){
            G <- G + edge(i,j)
          }
        }
      }
    }
  return(G)
}

common <- function(G,i,j){
  x=neighbors(G, i, mode='total')
  y=neighbors(G, j, mode='total')
  v=union(x,y)
  return(length(v))
}


add_closure <- function(G,v){
  i = 0
  while(TRUE){
    x = i+1
    y = i+2
    z = i+3
    r = runif(1)
    if(r < v[z]){
      G <- G + edge(v[x],v[y])
      #cat(r,"<",v[z]," edgeadded\n")
    }
    i <- i+3
    if(i>=length(v)/3){
      break
    }
  }
  return(G)
}

closure <- function(G){
  v <- vector()
  m <- length(V(G))
  for(i in 1:m){
    for(j in 1:m){
      if(i!=j && (V(G)[i]$type=='person' || V(G)[j]$type=='person')){
        k <- common(G,i,j)
        p = 1 - (1-0.001)^k
        v1 <- c(i,j,p)
        v <- c(v,v1)
      }
    }
  }
  G <- add_closure(G,v)
  return(G)
}

social <- function(G,v,n){
  for(i in 1:length(v)){
    j = n+i
    if(v[i] == 'eat-out'){
      x = adjacent_vertices(G,j,mode='all')
      for(k in 1:length(x)){
        l = as.numeric(V(G)[k]$label)
        if(l != 40){
          V(G)[k]$label <- l + 1
        }
      }
    }
    if(v[i] == 'gym'){
      x = adjacent_vertices(G,j,mode='al')
      for(k in 1:length(x)){
        l = as.numeric(V(G)[k]$label)
        if(l != 15){
          V(G)[k]$label <- l - 1
        }
      }
    }
  }
  return(G)
}



social2 <- function(G,n,v){
  G <- as.undirected(G,mode=c("collapse"))
  for(i in 1:length(v)){
    if(v[i] == 'eat-out'){
      j = i+n
      x = neighbors(G,j)
      for(k in 1:length(x)){
        l = x[k]
        if(as.numeric(V(G)[l]$label) != 40){
          V(G)[l]$label <- as.numeric(V(G)[l]$label)+1
        }
      }
    }
    if(v[i] == 'gym'){
      j = i+n
      x = neighbors(G,j)
      for(k in 1:length(x)){
        l = x[k]
        if(as.numeric(V(G)[l]$label) != 15){
          V(G)[l]$label <- as.numeric(V(G)[l]$label)-1
        }
      }
    }
  }
  return(G)
}


visualize <- function(G,pic){
  for(i in 1:length(V(G))){
    if(V(G)[i]$type == 'person'){
      x = as.numeric(V(G)[i]$label)
      if(x<16)
        V(G)[i]$color = 'blue'
      else if(x>39)
        V(G)[i]$color = 'red'
      else
        V(G)[i]$color = 'orange'
      
      V(G)[i]$shape = 'circle'
      V(G)[i]$size = x*0.25
    }
    else{
      V(G)[i]$color = 'green'
      V(G)[i]$shape = 'square'
      V(G)[i]$size = 10
    }
  }

  png(paste("C:/Users/Riya/Desktop/RHEA/6th sem/SNA/FATMAN/pics2/myplot1_",pic,".png",sep=""),600,600)
  plot(G,edge.arrow.size=0.1,layout=layout.auto)
  dev.off()
}

e = 0
n = 100
g <- create_graph(100)
visualize(g,e)
e <- e + 1

v <- c('gym','eat-out','karate','yoga','movie')
v1 <- c(n+1:length(v))
g <- add_foci(g,v,n)
visualize(g,e)
e <- e + 1

g <- add_edge(g,n,v1)
visualize(g,e)
e <- e + 1

for(i in 1:11){
  for(j in 1:2){
    g <- homophily(g,n)
    visualize(g,e)
    e <- e+1
  }
  
  g <- closure(g)
  visualize(g,e)
  e <- e+1
  for(j in 1:3){
    g<-social2(g,n,v)
    visualize(g,e)
    e <- e+1
  }
}

