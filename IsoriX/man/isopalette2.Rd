% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IsoriX-dataset.R
\docType{data}
\name{isopalette2}
\alias{isopalette2}
\alias{isopalette1}
\title{Colour palettes for plotting}
\format{A vector of colours}
\source{
For information on how to use themes, check:

\url{https://oscarperpinan.github.io/rastervis/#themes}
}
\description{
These datasets contain colour vectors that can be used for plotting. In our
examples, we use the \code{isopalette1} for plotting the isoscape using
\code{\link{plot.isoscape}} and \code{isopalette2} for plotting the
assignment outcoume using \code{\link{plot.isorix}}.
}
\details{
Colour palettes can be created by using the function \code{\link{colorRamp}}
that interpolates colours between a set of given colours. One can also use
\code{\link{colorRampPalette}} to create functions providing colours. Also
interesting, the function \code{colorspace::choose_palette} offers a GUI
interface allowing to create and save a palette in a hexadecimal format
(which can later on be imported into R). This latter function is however
limited to a maximum of 50 colours. You can also use R colour palettes
already available such as \code{\link{terrain.colors}} or others available
(see examples below). Alternatively, you can design your own colour palette
by writing standard hexadecimal code of colours into a vector.
}
\note{
We use the package \pkg{rasterVis} for plotting. Instead of using
colour palettes directly, one can also use any "Theme" designed for the
lattice graphic environment (see source for details).
}
\examples{

## A comparison of some colour palette

par(mfrow = c(2, 3))
pie(rep(1, length(isopalette1)), col = isopalette1,
	border = NA, labels = NA, clockwise = TRUE, main = "isopalette1")
pie(rep(1, length(isopalette2)), col = isopalette2,
	border = NA, labels = NA, clockwise = TRUE, main = "isopalette2")
pie(rep(1, 100), col = terrain.colors(100), border = NA, labels = NA,
    clockwise = TRUE, main = "terrain.colors")
pie(rep(1, 100), col = rainbow(100), border = NA, labels = NA,
    clockwise = TRUE, main = "rainbow")
pie(rep(1, 100), col = topo.colors(100), border = NA, labels = NA,
    clockwise = TRUE, main = "topo.colors")
pie(rep(1, 100), col = heat.colors(100), border = NA, labels = NA,
    clockwise = TRUE, main = "heat.colors")

## Creating your own colour palette
my.palette  <- colorRampPalette(c("blue", "green", "red"), bias = 0.7)
par(mfrow = c(1, 1))
pie(1:100, col = my.palette(100), border = NA, labels = NA,
    clockwise = TRUE, main = "a home-made palette")

## Turing palettes into functions for use in IsoriX
Isopalette1Fn <- colorRampPalette(isopalette1, bias = 0.5)
Isopalette2Fn <- colorRampPalette(isopalette2, bias = 0.5)
par(mfrow = c(1, 2))
pie(1:100, col = Isopalette1Fn(100), border = NA, labels = NA,
    clockwise = TRUE, main = "isopalette1")
pie(1:100, col = Isopalette2Fn(100), border = NA, labels = NA,
    clockwise = TRUE, main = "isopalette2")

}
\seealso{
\code{\link{rainbow}} for information about R colour palettes

\code{\link{colorRamp}} and \code{colorspace::choose_palette} to create your
own palettes
}
\keyword{color}
\keyword{datasets}
