#' Create state space plot grid for specific interactions
#'
#' @param df A dataframe of tWO variables - winner and loser.
#'     Individuals should be named 1-4.
#' @param nc Number of columns in the grid
#' @param nr Number of rows in the grid
#' @param textsize Font size of labels
#' @param labelno Label to start plot at
#' @return a plot of the state space at row If \strong{\code{N}} of the dataframe
#' @importFrom ggplot2 "aes"
#' @importFrom ggplot2 "theme_bw"
#' @importFrom ggplot2 "geom_point"
#' @importFrom ggplot2 "geom_segment"
#' @importFrom ggplot2 "facet_wrap"
#' @importFrom ggplot2 "ggplot"
#' @importFrom ggplot2 "element_blank"
#' @importFrom ggplot2 "element_text"
#' @importFrom ggplot2 "theme"
#' @importFrom grid "arrow"
#' @importFrom grid "unit"
#' @examples
#' state_plot_grid(fish[1:30,2:3], nc=6, nr=5)
#' @export


state_plot_grid <- function(df,nc=NULL,nr=NULL,textsize=10, labelno=1) {

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

  tmpints_df <- do.call('rbind', (Map(cbind,tmpints_joined,timebin = 1:length(tmpints_joined))))
  tmpints_df$timebin <- tmpints_df$timebin + labelno - 1

  new_theme_empty <- ggplot2::theme_bw()
  new_theme_empty$line <- ggplot2::element_blank()
  new_theme_empty$rect <- ggplot2::element_blank()
  new_theme_empty$axis.text <- ggplot2::element_blank()
  new_theme_empty$plot.title <- ggplot2::element_blank()
  new_theme_empty$axis.title <- ggplot2::element_blank()
  new_theme_empty$plot.margin <- structure(c(1, 1, 1, 1), unit = "lines", valid.unit = 3L, class = "unit")


  g <- ggplot2::ggplot(tmpints_df) +
    new_theme_empty +
    ggplot2::geom_point(data=data.frame(x=c(.9,2.1), y=c(.9,.9,2.1,2.1)), ggplot2::aes(x,y),
               color="white",size=0)+
    ggplot2::geom_point(data=data.frame(x=c(1,2), y=c(1,1,2,2)), ggplot2::aes(x,y), size=4) +
    ggplot2::geom_segment(mapping=aes(x=x, y=y, xend=vx, yend=vy),
                 arrow=grid::arrow(type="open",
                             length = grid::unit(0.1, "inches")),
                 size=1, color="gray25")+
    ggplot2::facet_wrap(~timebin,ncol=nc,nrow=nr) +
    ggplot2::theme(panel.spacing = grid::unit(1, "lines")) +
    ggplot2::theme(strip.text.x = ggplot2::element_text(size=textsize))

  return(g)


}
