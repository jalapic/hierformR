#' Add State ids and classes
#'
#' @param df a dataframe with two variables, winners and losers
#' @return the df with two extra rows containing state id and class
#' @examples
#' df<-data.frame(winner=c(1,2,3,1,2,3,2,1,2,3,3,1,2,3,4,3,1,3,2,1,1,1,1,2,2),
#' loser=c(2,4,4,4,3,2,1,3,3,4,4,2,3,2,3,4,2,4,3,3,3,2,2,4,3)
#' )
#' addstates(df)
#' @export

addstates <- function(df){
  v<-lastnet(df)
  v1<-lapply(v, netchar)
  df$id<-unlist(lapply(v1, stateid))
  df$class<-unlist(lapply(v1, stateclass))
  return(df)
}
