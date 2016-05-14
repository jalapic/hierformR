#' Generate random winner-loser dataframe
#'
#' @param ints number of interactions
#' @param actors number of individuals
#' @param intprob vector of interaction probabilities of same length as `actors`
#' @return a dataframe with two variables, winner and loser
#' @examples
#' df<-data.frame(winner=c(1,2,3,1,2,3,2,1,2,3,3,1,2,3,4,3,1,3,2,1,1,1,1,2,2),
#' loser=c(2,4,4,4,3,2,1,3,3,4,4,2,3,2,3,4,2,4,3,3,3,2,2,4,3)
#' )
#' wldf()
#' wldf(ints=30, actors=3, intprob=c(0.8,0.1,0.1))
#' @export


wldf<-function(ints=100,actors=4, intprob=NULL){
  df <- as.data.frame(matrix(replicate(ints,sample(LETTERS[1:actors],2,prob=intprob)),ncol=2,byrow=T))
  colnames(df)<-c("winner","loser")
  return(df)
}


