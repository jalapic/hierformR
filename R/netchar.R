#' Get characteristics of a directed graph
#'
#' @param g a unweighted directed igraph object.
#' @return a single row dataframe with characteristics of the graph
#' @examples
#' g=igraph::graph.edgelist(cbind(a=c(1,2,3,3), b=c(4,1,1,2)),directed=TRUE)
#' netchar(g)
#' @export


netchar <- function(g){

  ## This is to work around an igraph 1.0.1 (and before) bug
    if (packageVersion("igraph") <= "1.0.1") {
        my_tail_of <- igraph::head_of
      } else {
          my_tail_of <- igraph::tail_of
        }


  g<-delete_isolates(g)

  dd<-cbind(
    do.call('rbind',list(igraph::triad.census(g))),
    maxdom = max(table(my_tail_of(g,es=1:length(igraph::E(g))))),
    noedges = length(igraph::E(g)),
    nonodes = length(igraph::V(g)),
    distance = igraph::mean_distance(g),
    degreediff = max(igraph::degree(g,mode="out")-igraph::degree(g,mode="in"))
  )


  dd=as.data.frame(dd)

  dd=dd[c(1,2,4:6,9:10,17:21)]

  colnames(dd)<-c("X003","X012","X021D","X021U","X021C",
                        "X030T","X030C","maxdom", "noedges",
                        "nonodes","distance","degreediff"
  )

    return(dd)
}
