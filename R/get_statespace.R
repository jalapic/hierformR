#' Get statespace characteristics of a directed graph
#'
#' @param g a unweighted directed igraph object.
#' @return a single row dataframe with characteristics of the graph
#' @examples
#' g=igraph::graph.edgelist(cbind(a=c(1,2,3,3), b=c(4,1,1,2)),directed=TRUE)
#' get_statespace(g)
#' @export


get_statespace <- function(g){
  dd<-cbind(
    do.call('rbind',list(igraph::triad.census(g))),
    maxdom = max(table(igraph::head_of(g,es=1:length(igraph::E(g))))),
    noedges = length(igraph::E(g)),
    nonodes = length(igraph::V(g)),
    distance = igraph::mean_distance(g),
    degreediff = max(igraph::degree(g,mode="out")-igraph::degree(g,mode="in"))
  )

  colnames(dd)[1:16]<-c("X003","X012","X102","X021D","X021U","X021C","X111D","X111U",
                                "X030T","X030C","X201","X120D","X120U","X120C","X210","X300")

  dd=dd[c(1,2,4:6,9:10,17:21)]
  return(dd)
}
