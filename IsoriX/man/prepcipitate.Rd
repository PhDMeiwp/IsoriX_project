% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prepcipitate.R
\name{prepcipitate}
\alias{prepcipitate}
\title{Prepare the raster brick containing the precipitation data}
\usage{
prepcipitate(path = NULL, elevation.raster, verbose = interactive())
}
\arguments{
\item{path}{A \var{string} indicating the path where the WorldClim data have
been downloaded. If the path is null (the default) the function will assume
that the folder containing the precipitation data is in the current 
directory}

\item{elevation.raster}{A \var{raster} containing the elevation raster}

\item{verbose}{A \var{logical} indicating whether information about the 
progress of the procedure should be displayed or not while the function is 
running. By default verbose is \var{TRUE} if users use an interactive R 
session, and \var{FALSE} otherwise.}
}
\description{
This functions turns the WorldClim data downloaded using the function
\code{\link{getprecip}} into a \var{RasterBrick} of same resolution and
extent as the elevation raster. This function is designed to be used with
\code{\link{isomultiscape}}.
}
\examples{

## The following example takes some time and download heavy data.
## It will therefore not be run unless you type: 
## example(prepcipitate, run.dontrun = TRUE)

\dontrun{

## We fit the models for Germany:
GNIPDataDEagg <- prepdata(data = GNIPDataDE)

GermanFit <- isofit(iso.data = GNIPDataDEagg,
                    mean.model.fix = list(elev = TRUE, lat.abs = TRUE))

elevation.raster <- relevate(
    elevation.raster = ElevRasterDE,
    isofit = GermanFit,
    aggregation.factor = 0)

getprecip(path = "~/Desktop/")

precipitation.brick <- prepcipitate(path = "~/Desktop/",
                                    elevation.raster = ElevRaster
                                    )
 
 if (require(rasterVis)) {
   levelplot(precipitation.brick)
 }

}
}
\seealso{
\code{\link{getprecip}} to download the relevant precipitation data

\code{\link{relevate}} to prepare the elevation raster
}
