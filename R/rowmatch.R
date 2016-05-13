#' Match rows of dataframes
#'
#' @param v1 a dataframe or matrix
#' @param v2 a row of a dataframe or matrix or a vector of length equal to ncol(v1)
#' @param nomatch how to represent non matching indices of rows
#' @return a vector with a 1 in the index of matched rows
#' @examples
#' v1 <- data.frame(A=c(1,2,3),B=c(2,3,3),C=c(3,3,2),D=c(1,1,1))
#' v2 <- data.frame(A=3,B=3,C=2,D=1)
#' rowmatch(v1,v2,nomatch=NA)
#' @export


rowmatch<-function (v1, v2, nomatch = NA)
{
  if (class(v2) == "matrix")
    v2 <- as.data.frame(v2)
  if (is.null(dim(v1)))
    v1 <- as.data.frame(matrix(v1, nrow = 1))
  cv1 <- do.call("paste", c(v1[, , drop = FALSE], sep = "\r"))
  cv2 <- do.call("paste", c(v2[, , drop = FALSE], sep = "\r"))
  match(cv1, cv2, nomatch = nomatch)
}
