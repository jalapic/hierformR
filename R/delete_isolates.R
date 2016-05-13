#' Delete isolated nodes from network
#'
#' @param q an igraph object
#' @return an igraph object containing only connected nodes
#' @examples
#' g=igraph::graph.edgelist(cbind(a=c(1,2,3,4), b=c(3,1,1,4)),directed=TRUE)
#' delete_isolates(g)
#' @export

delete_isolates<-function(q){
  igraph::delete.vertices(q,which(igraph::degree(q)==0))
}

