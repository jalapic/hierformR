#' Identify which rows of win-loss dataframe are new or changed interactions
#'
#' @param df a dataframe with two variables, winners and losers
#' @return a dataframe with extra variables showing interaction number
#'     and if interaction is 'same', 'new' or a 'flip'.
#' @importFrom stats "aggregate"
#' @importFrom stats "ave"
#' @importFrom utils "tail"
#' @examples
#' interactions(chickens[,3:4])
#' @export


interactions <- function(df) {

  changeids <- interactions_diff(df)
  df0 <- lastints(df)
  df1 <- do.call('rbind', (Map(cbind,df0,timebin = 1:length(df0))))
  timebins <- stats::aggregate(cbind(count = timebin) ~ timebin, data = df1,FUN = function(x){NROW(x)})
  df1$totrows <- timebins$count[match(df1$timebin,timebins$timebin)]
  df1$prevrows <- c(NA, timebins$count[match(df1$timebin,timebins$timebin)-1])
  df1$rownumber <- stats::ave(df1$totrows, df1$timebin, FUN = seq_along)
  df1$lastrow <- ifelse(df1$totrows==df1$rownumber, 1, 0)
  df1$change <- ifelse(df1$timebin%in%changeids, T,F)

  df1$type <- ifelse(is.na(df1$prevrows), "new",
                            ifelse(df1$lastrow==0, "same",
                                   ifelse(df1$totrows>df1$prevrows, "new",
                                          ifelse(df1$change==T, "flip",
                                                 "same"))))

  newdf <- stats::aggregate(df1, by=list(df1$timebin), FUN = function(x) utils::tail(x,1))
  newdf<-as.data.frame(newdf)[c(2:4,10)]
  colnames(newdf)[3]<-c("interaction")
  return(newdf)
}
