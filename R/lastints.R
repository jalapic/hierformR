#' Get last interaction between each pair of nodes
#'
#' @param df a dataframe with two variables, winners and losers
#' @return a list with each element being the last interaction for each pair of nodes
#' up to that row of the dataframe
#' @examples
#' lastints(ladybugs[,2:3])
#' @export

lastints<-function(df){
  if(ncol(df)!=2) stop("input datframe does not have two columns")
  xx<- lapply(1:nrow(df), function(i) df[1:i,][!duplicated(df[1:i,], fromLast=T),])
  xx0 <- lapply(xx, function(x) apply(x,1,range))
  xx1 <- lapply(xx0, function(x) !duplicated(t(x), fromLast=T))

  resout=vector('list', length(xx))
  for(j in 1:length(xx)){resout[[j]]<-xx[[j]][xx1[[j]]==T,]}

  return(resout)
}
