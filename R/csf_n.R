#' Determine class-stability factor (CSF) for specific number of links
#'
#' @param df a dataframe produced by `addstates` with columns winner, loser,
#' id and class
#' @param links the number of links to determine the CSF for
#' @return a named vector of state ids with the CSF for defined number of links
#' @importFrom utils "data"
#' @examples
#' csf_n(addstates(wldf()),links=6)
#' @export


csf_n<-function(df,links=4){

  data("states", envir = environment())
  xx <- get("states", envir  = environment())

  links4 <- xx[xx$noedges==links,]$id
  links4.p <- df[df$id %in% links4,]
  links4.val <- table(links4.p$id)/sum(table(links4.p$id))
  csfs<-rep(0, length(links4))
  names(csfs)<-links4
  LL=c(csfs, links4.val)
  csf=tapply(unlist(LL), names(unlist(LL)), sum)
  return(csf)
}
