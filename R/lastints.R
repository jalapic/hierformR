#' Get last interaction between each pair of nodes
#'
#' @param df a dataframe with two variables, winners and losers
#' @return a list with each element being the last interaction for each pair of nodes
#' up to that row of the dataframe
#' @examples
#' df<-data.frame(winner=c(1,2,3,1,2,3,2,1,2,3,3,1,2,3,4,3,1,3,2,1,1,1,1,2,2),
#' loser=c(2,4,4,4,3,2,1,3,3,4,4,2,3,2,3,4,2,4,3,3,3,2,2,4,3)
#' )
#' lastints(df)
#' @export
#'

lastints<-function(df){
  xx<- lapply(1:nrow(df), function(i) df[1:i,][!duplicated(df[1:i,], fromLast=T),])
  xx0 <- lapply(xx, function(x) apply(x,1,range))
  xx1 <- lapply(xx0, function(x) !duplicated(t(x), fromLast=T))

  resout=vector('list', length(xx))
  for(j in 1:length(xx)){resout[[j]]<-xx[[j]][xx1[[j]]==T,]}

  return(resout)
}
