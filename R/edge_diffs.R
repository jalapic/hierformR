#' Determine edge differences between two igraph objects
#'
#' @param g1 igraph object 1 - must be a subgraph of \strong{\code{g2}}
#' @param g2 igraph object 2
#' @return a vector of the number of same, different and new edges
#' @importFrom igraph "E"
#' @importFrom igraph "as.undirected"
#' @importFrom igraph "difference"
#' @importFrom igraph "intersection"
#' @examples g1 <- igraph::graph_from_literal( A -+ B -+ C)
#'     g2 <- igraph::graph_from_literal( A -+ B -+ C -+ A)
#'     edge_diffs(g1,g2)
#' @export


edge_diffs <- function(g1,g2){

  cg1 <-class(g1)
  cg2 <-class(g2)

  if(cg1!="igraph"|cg2!="igraph") stop("inputs are not igraph objects")

  u1 <- igraph::as.undirected(g1)
  u2 <- igraph::as.undirected(g2)

  same=length(igraph::E(igraph::intersection(g2,g1)))
  reverse=length(igraph::E(igraph::difference(g2,g1)))-length(igraph::E(igraph::difference(u2,u1)))
  new=length(igraph::E(igraph::difference(g2,g1)))-reverse

  v <- c(same,reverse,new)
  names(v)<-c("same","reverse", "new")
  return(v)
}

