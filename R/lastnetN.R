#' Get network for last N interactions between each pair of nodes
#'
#' @param df a dataframe with two variables, winners and losers
#' @param N the number of last interactions to get
#' @param all If = \strong{\code{FALSE}} then generates network based on one
#'     directed edge with clear winner being individual with highest wins from
#'     last N interactions between each pair. If = \strong{\code{TRUE}}
#'     then keeps uses all edges from last N interactions between each pair.
#' @return a list with each element being the network object derived from the last
#'     N interactions for each pair of nodes up to that row of the dataframe
#' @importFrom compete "get_di_matrix"
#' @importFrom compete "get_wl_matrix"
#' @importFrom igraph "graph.adjacency"
#' @importFrom igraph "graph.edgelist"
#' @examples
#' lastnetN(ladybugs[,2:3],N=3)
#' @export

lastnetN <- function(df,N=3,all=FALSE){

  xx <- lastintsN(df,N)

  if(all==TRUE){
    xxx <- lapply(xx, function(x) igraph::graph.edgelist(as.matrix(x)))
    return(xxx)
  } else {
    xxx <- lapply(xx, function(x) igraph::graph.adjacency(compete::get_di_matrix(compete::get_wl_matrix(as.matrix(x)))))
    return(xxx)
  }

}

