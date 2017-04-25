#' Identify states that have changed from previous interaction
#'
#' @param df a dataframe produced from the \strong{\code{addstates()}} function
#' @param subset If \strong{\code{TRUE}} subset out rows where state change occurs
#'     If \strong{\code{FALSE}} add column to original dataframe with state changes.
#' @return either a subsetted dataframe with rows when states changed or
#'     an additional column to input dataframe stating if state change occurs
#' @importFrom Hmisc "Lag"
#' @examples
#' state_changes(addstates(ladybugs[,2:3]))
#' state_changes(addstates(ladybugs[,2:3]),subset=FALSE)
#' @export

state_changes <- function(df, subset=TRUE){

if(subset==TRUE){
df_changed <- df[df$class!=Hmisc::Lag(df$class),]
return(df_changed)
} else

#here add yes/no on 'state-change column' of add states.

df$state_change <- df$class!=Hmisc::Lag(df$class)
return(df)
}
