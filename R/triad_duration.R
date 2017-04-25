#' Calculate Dominance Index over time
#'
#' @param df a dataframe containing two columns -
#'     the first column being the winner
#'     and the second column being the loser
#' @return a list of dataframes with each element being
#'     individual triads. Each dataframe describes the type of
#'     edge (new,same,flip), the state of the triad (single,
#'     double dominant, double subordinate, pass-along, transitive,
#'     cycle), and the number of nodes and edges in the triad at
#'     each row.
#' @importFrom igraph "graph.edgelist"
#' @importFrom igraph "V"
#' @importFrom igraph "E"
#' @importFrom igraph "triad.census"
#' @importFrom stats "setNames"
#' @importFrom utils "combn"
#' @examples
#' triad_duration(chickens[,3:4])
#' @export



triad_duration <- function(df){
uids<-sort(unique(c(df[,1],df[,2])))
uids.comb <- as.data.frame(utils::combn(uids,3))
df.combs <- apply(uids.comb, 2, function(x) df[df[,1]%in%x & df[,2]%in%x, ] )
dfs.ints <- lapply(df.combs, interactions)
dfs.lastints <- lapply(df.combs, lastints)
dfs.triads <- lapply(dfs.lastints, function(z) lapply(z, function(x) igraph::graph.edgelist(as.matrix(x))))
dfs.names <- lapply(dfs.triads, function(z) lapply(z, function(g) paste(sort(attr(igraph::E(g), "vnames")),collapse="-")))
dfs.triadlengths <- lapply(dfs.triads, function(z) lapply(z, function(g) length(igraph::V(g))))
dfs.edges <- lapply(dfs.triads, function(z) lapply(z, function(g) length(igraph::E(g))))
dfs.edges1 <- lapply(dfs.edges, function(x) as.data.frame(do.call('rbind',x)))
dfs.names1 <- lapply(dfs.names, function(x) as.data.frame(do.call('rbind',x)))
dfs.triadlengths1 <- lapply(dfs.triadlengths, function(x) as.data.frame(do.call('rbind',x)))
dfs.triadcensus <- lapply(dfs.triads, function(z) lapply(z, function(g) igraph::triad.census(g)))
dfs.triadcensus1 <- lapply(dfs.triadcensus, function(z) lapply(z, function(x) x[c(2,4,5,6,9,10)]))
ids<-c("single", "doubledom", "doublesub", "passalong", "transitive", "cycle","nodes","edges","names")
dfs.triadcensus2 <- lapply(dfs.triadcensus1,  function(x) as.data.frame(do.call("rbind", x)))
newdf <-  Map(cbind, dfs.triadcensus2, dfs.triadlengths1)
newdf <-  Map(cbind, newdf, dfs.edges1)
newdf <-  Map(cbind, newdf, dfs.names1)
newdf <- lapply(newdf, stats::setNames, ids)
newdf1 <- Map(cbind, dfs.ints, newdf)
newdf1 <- lapply(newdf1, function(x) {x$single <- ifelse(x$nodes==2,1,0);x})
names(newdf1) <- lapply(uids.comb,paste,collapse="|")
return(newdf1)
}



