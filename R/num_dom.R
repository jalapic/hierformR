#' Calculate Number of Individuals Dominated by each individual over Time
#'
#' @param df a dataframe containing two columns
#'     the first column being the winner
#'     and the second column being the loser
#' @param plot If equals TRUE will plot dominance over time
#' @return a dataframe with the number of animals dominated at each time
#'     based on the previous interaction between all pairs of individuals
#' @importFrom grDevices "dev.off"
#' @importFrom graphics "par"
#' @examples
#' num_dom(chickens[,3:4])
#' num_dom(chickens[,3:4], plot=TRUE)
#' @export


num_dom <- function(df, plot=FALSE) {

df[,1] <- factor(df[,1], levels = unique(c(df[,1], df[,2])))

domnum <- function(z){
x1 <- table(z[,1])
x2 <-x1[sort(names(x1))]
return(x2)
}

v <- lapply(lastints(df), domnum)
vdf <- do.call("rbind", v)


if(plot==FALSE){
  return(as.data.frame(vdf))
    } else

  if(plot==TRUE){

    if(ncol(vdf)>4) stop("Plot only possible for up to maximum four individuals")

    grDevices::dev.off()
    graphics::par(mfrow=c(2,2))
    plot(1:nrow(vdf),vdf[,1], main=colnames(vdf)[1], xlab="occurrence", ylab="Number dominated",ylim=c(0,3))
    plot(1:nrow(vdf),vdf[,2], main=colnames(vdf)[2], xlab="occurrence", ylab="Number dominated",ylim=c(0,3))
    plot(1:nrow(vdf),vdf[,3], main=colnames(vdf)[3], xlab="occurrence", ylab="Number dominated",ylim=c(0,3))
    plot(1:nrow(vdf),vdf[,4], main=colnames(vdf)[4], xlab="occurrence", ylab="Number dominated",ylim=c(0,3))
    return(as.data.frame(vdf))

  }

}


