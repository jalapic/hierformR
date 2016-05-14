#' Determine class-stability factor (CSF)
#'
#' @param df either a two-column dataframe of winners and losers or
#' a dataframe produced by `addstates` with columns winner, loser,
#' id and class
#' @return a named vector of state ids with the CSF for all link numbers
#' @examples
#' df<-data.frame(winner=c(1,2,3,1,2,3,2,1,2,3,3,1,2,3,4,3,1,3,2,1,1,1,1,2,2),
#' loser=c(2,4,4,4,3,2,1,3,3,4,4,2,3,2,3,4,2,4,3,3,3,2,2,4,3)
#' )
#' csf(df)
#'
#' csf(addstates(wldf()))
#' @export


csf<-function(df){

 if(ncol(df)==4) { x <- df }
 if(ncol(df)==2) { x <- addstates(df) }

 xx <- c(csf_n(x,1),csf_n(x,2),csf_n(x,3),csf_n(x,4),csf_n(x,5),csf_n(x,6))
 xx <- round(xx,3)
 return(xx)
}
