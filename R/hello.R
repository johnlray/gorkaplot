#' @title Generates A Gorkaplot
#'
#' @description Takes a dataframe with an x and a y, some variable labels, and produces a Gorkaplot.
#'
#' @param data, x, y, x_var_lab, ymin_lab, ymax_lab
#'
#' @examples gorka_plot(mtcars, x = "wt", y = "mpg", x_var_lab = "Weight?", ymin_lab = "Low MPG", ymax_lab = "High MPG", caption = "Diagram One: MPG and the Scale of Weight")
#'
#' @export
gorka_plot <- function(data, x, y, x_var_lab = "Terrorism?", ymin_lab = "Peacekeeping", ymax_lab = "Thermonuclear war", caption = "Diagram Nine: Terrorism and the Scale of Conflict") {
  require(ggplot2)
  require(gridExtra)
  require(scales)

  dat = data[,c(x, y)]
  dat$x_var = dat[, x]
  dat$y_var = dat[, y]
  dat$x_var = rescale(dat$x_var, range(dat$y_var))

  if(quantile(dat$y_var, .21) == quantile(dat$y_var, .39)) {
    curve_end = quantile(dat$y_var, .38) + runif(n = 1, min = 0.001, max = 0.0001)
  } else {
    curve_end = quantile(dat$y_var, .38)
  }

  p <- ggplot(data = dat, aes(x = y_var, y = x_var)) +
    annotate(geom = 'text', x = quantile(dat$x_var, .1), y = 0.1, label = ymin_lab, color = 'blue', fontface = "bold", size = 8, family = "Times") +
    annotate(geom = 'text', x = quantile(dat$x_var, .9), y = 0.1, label = ymax_lab, color = 'red', fontface = "bold", size = 8, family = "Times") +
    annotate(geom = 'text', x  = quantile(dat$y_var, .3), y = -.1, label = x_var_lab, fontface = "italic", color = 'orange', size = 7, family = "Times") +
    annotate(geom = 'text', x = quantile(dat$y_var, .1), y = -.1, label = "?", color = 'black', size = 6, family = "Times") +
    annotate(geom = 'text', x = quantile(dat$y_var, .5), y = -.1, label = "?", color = 'black', size = 6, family = "Times") +
    annotate(geom = 'text', x = quantile(dat$y_var, .85), y = -.3, label = caption, color = 'black', size = 5, family = "Times", fontface = "italic") +
    geom_segment(aes(x = min(x_var), xend = max(x_var), y = 0, yend = 0), size = 1, arrow = arrow(length = unit(0.03, 'npc'), type = 'closed', ends = "last"), color = 'black') +
    geom_segment(aes(x = quantile(dat$y_var, .12), xend = quantile(dat$y_var, .22), y = -.1, yend = -.1), size = .5, arrow = arrow(length = unit(0.03, 'npc'), type = 'closed', ends = "first"), color = 'black') +
    geom_segment(aes(x = quantile(dat$y_var, .38), xend = quantile(dat$y_var, .48), y = -.1, yend = -.1), size = .5, arrow = arrow(length = unit(0.03, 'npc'), type = 'closed', ends = "last"), color = 'black') +
    geom_curve(x = quantile(dat$y_var, .22), xend = curve_end, y = -.1, yend = -.1, curvature = -1, size = .2) +
    geom_curve(x = quantile(dat$y_var, .22), xend = curve_end, y = -.1, yend = -.1, curvature = 1, size = .2) +
    ylim(-.4, .4) +
    theme(axis.line=element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          legend.position="none",
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          plot.background=element_blank())

  return(p)
}
