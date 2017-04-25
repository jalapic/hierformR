#' Identify which rows of win-loss dataframe are new or changed interactions
#'
#' @param df a dataframe with two variables, the first being winners and
#'     the second being losers
#' @return a vector with indices of rows that are new or changed interactions
#' @examples
#' interactions_diff(chickens[,3:4])
#' @export


interactions_diff <- function(df) {

  tmpints <- lastints(df)

change_ints <- function(tmpints){
  outval<-list()
  for(i in 2:length(tmpints)){
    j<-i-1
    if(nrow(tmpints[[i]])==nrow(tmpints[[j]])){
      tablei <- table(tmpints[[i]][,1], tmpints[[i]][,2])
      tablej <- table(tmpints[[j]][,1], tmpints[[j]][,2])
      if(nrow(tablei)==nrow(tablej) & ncol(tablei)==ncol(tablej)) {
        outval[[i]] <- ifelse(sum(tablei!=tablej)>0,FALSE,TRUE)
      }
      else{
        outval[[i]] <- FALSE
      }
    }
    else
      outval[[i]] <- FALSE
  }

  changes <- which(c(FALSE,unlist(outval))==F)
  return(changes)
}

return(change_ints(tmpints))
}
