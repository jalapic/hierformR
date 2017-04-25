#' Create state space plot for specific interaction
#'
#' @param df A dataframe of two variables - winner and loser.
#'     Individuals should be named 1-4.
#' @param N Row of the dataframe to plot the state space for.
#' @return a plot of the state space at row If \strong{\code{N}} of the dataframe
#' @importFrom ggplot2 "aes"
#' @importFrom ggplot2 "theme_bw"
#' @importFrom ggplot2 "ggplot"
#' @importFrom ggplot2 "geom_segment"
#' @importFrom ggplot2 "geom_point"
#' @importFrom ggplot2 "element_blank"
#' @importFrom grid "arrow"
#' @examples
#' state_plot(fish[1:20,2:3], N=20)
#' @export


state_plot <- function(df,N=1) {

  x<-y<-vx <- vy <- NULL

colnames(df)<-c("winner", "loser")

tmpints <- lastints(df)

rshdf <- data.frame(winner=rep(1:4,each=3),loser=c(2,3,4,1,3,4,1,2,4,1,2,3), rshp=1:12)

d=data.frame(x=c(1.1,1.9,1.9,1.1,2.0,2.0,1.0,1.0,1.1,1.9,1.1,1.9),
             y=c(2.0,2.0,1.1,1.9,1.1,1.9,1.9,1.1,1.0,1.0,1.1,1.9),
             vx=c(1.9,1.1,1.1,1.9,2.0,2.0,1.0,1.0,1.9,1.1,1.9,1.1),
             vy=c(2.0,2.0,1.9,1.1,1.9,1.1,1.1,1.9,1.0,1.0,1.9,1.1),
             rshp=c(1,4,10,3,11,6,2,7,9,12,8,5))

rshdf <- merge(x = rshdf, y = d, by = c("rshp"), all.x = TRUE)

ljoin <- function(xx) { merge(x = xx, y = rshdf, by = c("winner","loser"), all.x = TRUE) }

tmpints_joined <- lapply(tmpints, ljoin)

new_theme_empty <- ggplot2::theme_bw()
new_theme_empty$line <- ggplot2::element_blank()
new_theme_empty$rect <- ggplot2::element_blank()
new_theme_empty$strip.text <- ggplot2::element_blank()
new_theme_empty$axis.text <- ggplot2::element_blank()
new_theme_empty$plot.title <- ggplot2::element_blank()
new_theme_empty$axis.title <- ggplot2::element_blank()
new_theme_empty$plot.margin <- structure(c(1, 1, 1, 1), unit = "lines", valid.unit = 3L, class = "unit")



fourpoints <- data.frame(x=c(1,2), y=c(1,1,2,2))

fourplot <- function(d){
  ggplot2::ggplot() +
    new_theme_empty +
    ggplot2::geom_point(data=data.frame(x=c(1,2), y=c(1,1,2,2)), ggplot2::aes(x,y), size=7) +
    ggplot2::geom_segment(data=d, mapping=aes(x=x, y=y, xend=vx, yend=vy), arrow=grid::arrow(), size=1.5, color="gray25")
}


return(fourplot(tmpints_joined[[N]]))

}

