#' Characteristics of 41 network states for 4 node graphs
#'
#' Dataframe showing the transitivity and intransitivity of each
#' of the four triads, the number of nodes,
#' the number of edges, the number of other individuals dominated
#' by the top-ranked individual, the mean distance of the network
#' and the maximum difference between out-degree and in-degrees,
#' in a four node network. Also gives the class of each state.
#'
#' @format A data frame with 41 rows and 14 variables:
#' \describe{
#'   \item{X003}{Number of unconnected nodes}
#'   \item{X012}{Number of triads with one single directed edge}
#'   \item{X021D}{Number of triads with 2 edges going down}
#'   \item{X021U}{Number of triads with 2 edges going up}
#'   \item{X021C}{Number of triads with 2 edges that could be transitive/intransitive}
#'   \item{X030T}{Number of transitive triads}
#'   \item{X030C}{Number of intransitive triads}
#'   \item{maxdom}{Number of individuals dominated by top ranked individual}
#'   \item{noedges}{Number of edges in network}
#'   \item{nonodes}{Number of nodes in network}
#'   \item{distance}{Mean distance of the network}
#'   \item{degreediff}{Max difference between each nodes out-degree and in-degree}
#'   \item{id}{The id of the network}
#'   \item{class}{The class of the network}
#' }
"states"
