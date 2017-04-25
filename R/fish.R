#' Example dataset of fish behavior
#'
#' Dataframe with dominance behaviors directed from an actor
#' towards a recipient and timestampped.
#'
#' @format A data frame with 3189 observations and 4 variables:
#' \describe{
#'   \item{time}{Time in seconds of behavior}
#'   \item{winner}{Winner}
#'   \item{loser}{Loser}
#'   \item{behav}{Behavior: T = threat; B = bite; C = chase; L = lip-lock;}
#' }
"fish"
