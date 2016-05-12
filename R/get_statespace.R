#' Get statespace characteristics of a directed graph
#'
#' @param g a unweighted directed igraph object.
#' @return a single row dataframe with characteristics of the graph
#' @examples
#' g=igraph::graph.edgelist(cbind(a=c(1,2,3,3), b=c(4,1,1,2)),directed=TRUE)
#' get_statespace(g)
#' @export
#'


get_statespace <- function(g){
  dd<-cbind(
    do.call('rbind',list(igraph::triad.census(g))),
    maxdom = max(table(igraph::head_of(g,es=1:length(igraph::E(g))))),
    noedges = length(igraph::E(g)),
    nonodes = length(igraph::V(g)),
    distance = igraph::mean_distance(g),
    degreediff = max(igraph::degree(g,mode="out")-igraph::degree(g,mode="in"))
  )
  return(dd)
}
