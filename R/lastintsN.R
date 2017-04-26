#' Get last N interactions between each pair of nodes
#'
#' @param df a dataframe with two variables, winners and losers
#' @param N the number of last interactions to get
#' @return a list with each element being the last N interactions for each pair of nodes
#' up to that row of the dataframe
#' @importFrom stats "ave"
#' @examples
#' lastintsN(ladybugs[,2:3],N=3)
#' @export

lastintsN <- function (df,N=3) {

  xx<-NULL

  if (ncol(df) != 2)
    stop("input datframe does not have two columns")

  df$group <- paste(pmin(df[,1],df[,2]),pmax(df[,1],df[,2]),sep="-")#addpairid.
  df$rownumber <- stats::ave(df$group, df$group, FUN = seq_along)#addrownumber in pairid
  xx <- lapply(1:nrow(df), function(i) df[1:i, ]) #split
  xx <- lapply(xx, function(x) {x$Max <- with(x, stats::ave(rownumber, group, FUN=max));x}) #in each element - add max value for each group as new column.
  xx <- lapply(xx, function(x)  x[(as.numeric(x$Max)-as.numeric(x$rownumber))<=N-1,1:2])
  return(xx)
}
