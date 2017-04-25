#' Get N/N(1) ratio
#'
#' @param x a vector of integers
#' @return the value of each integer divided by the number of integers equal to 1
#' @examples
#' nn1(c(10,6,3,2,2,2,1,1,1,1,1,1))
#' @export


nn1 <- function(x){

  if(sum(x==1)==0) stop("no integers in vector equal to 1")

  table(x)/sum(x==1)
}
