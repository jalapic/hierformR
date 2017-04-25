#' Get burst frequencies of attacking individuals
#'
#' @param df a dataframe with one variable named actor or winner
#' @return a list with the burst lengths (number of consecutive attacks) by
#'     each individual
#' @examples
#' burst_freq(chickens)
#' @export

burst_freq <- function(df){


  if("actor" %in% colnames(df)){
    x <- rle(df$actor)
  } else
  {
    x <- rle(df$winner)
  }

  bursts <- x$lengths
  names(bursts) <- x$values
  bursts <- rev(sort(bursts))
  b <- split(bursts, names(bursts))
  b <- lapply(b, unname)
  return(b)
}
