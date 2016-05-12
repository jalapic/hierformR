#' Get last interaction between each pair of nodes
#'
#' @param df a dataframe with two variables, winners and losers
#' @return a list with each element being the network object derived from the last
#'  interaction for each pair of nodes up to that row of the dataframe
#' @examples
#' df<-data.frame(winner=c(1,2,3,1,2,3,2,1,2,3,3,1,2,3,4,3,1,3,2,1,1,1,1,2,2),
#' loser=c(2,4,4,4,3,2,1,3,3,4,4,2,3,2,3,4,2,4,3,3,3,2,2,4,3)
#' )
#' lastnet(df)
#' @export

lastnet<-function(df){

  resout <- lastints(df)
  gs <- lapply(resout, function(x) as.matrix(x, ncol=2))
  g<-lapply(gs, function(x) igraph::graph.edgelist(x))
  return(g)
}
