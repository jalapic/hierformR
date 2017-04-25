#' Calculate Dominance Index over time
#'
#' @param df a dataframe containing three columns
#'     the first column being the time, the second column the winner
#'     and the second column being the loser
#' @param plot If equals TRUE will plot dominance over time
#' @param type If \strong{\code{lc}} will calculate the win proportion
#'     dominance index used by Lindquist & Chase (2009). If \strong{\code{ds}}
#'     will use David's Scores as the dominance index.
#' @return a dataframe with the dominance index - a numeric value
#' between 0 and 1 for each animal at each timepoint
#' @importFrom compete "ds"
#' @importFrom graphics "matplot"
#' @examples
#' di(chickens[,-2], type="ds")
#' di(chickens[,-2], type="lc", plot=TRUE)
#' @export


di <- function(df, plot=FALSE, type="ds"){

if(ncol(df)!=3) stop("Dataframe does not have three columns")

getdi <- function(x){
  dfstab <- table(x[,2], x[,3])
  wins <- rowSums(dfstab)
  losses <- colSums(dfstab)
  wins / (wins+losses)
}

getdavids <- function(x){
  dfstab <- table(x[,2], x[,3])
  compete::ds(dfstab)
}


uniqueids <- sort(unique(c(df[,2],df[,3])))
df[,2] <- factor(df[,2], levels=uniqueids)
df[,3] <- factor(df[,3], levels=uniqueids)
dfs <- lapply(1:nrow(df), function(x) df[1:x,])

if(type=="ds"){ newdf<-cbind(df, do.call('rbind', lapply(dfs, getdavids))) } else
if(type=="lc"){ newdf<-cbind(df, do.call('rbind', lapply(dfs, getdi))) }

if(plot==FALSE){
  return(newdf)
} else

if(plot==TRUE){
dfx<-newdf[,-c(1:3)]
graphics::matplot(dfx, type = c("b"),pch=1,col = 1:ncol(dfx), xlab = "Time", ylab="Dominance Index")
return(newdf)
}
}
