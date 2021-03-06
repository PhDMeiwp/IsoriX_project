#' @rdname IsoriX-defunct
#' @export
queryGNIP <- function(...) {
  .Defunct("prepdata")
}

#' @rdname IsoriX-defunct
#' @export
QueryGNIP <- function(...) {
  .Defunct("prepdata")
}

#' Filter the dataset to create an isoscape
#' 
#' This function prepares the available dataset to be used for creating the
#' isoscape (e.g. \var{GNIPDataDE}) . This function allows the trimming of data
#' by months, years and location, and for the aggregation of selected data per 
#' location, location:month combination or location:year combination. The
#' function can also be used to randomly exclude some observations.
#' 
#' This function aggregates the data as required for the IsoriX workflow. Three 
#' aggregation schemes are possible. The most simple one, used as default, 
#' aggregates the data so to obtained a single row per sampling location. 
#' Datasets prepared in this way can be readily fitted with the function 
#' \code{\link{isofit}} to build an isoscape. It is also possible to aggregate 
#' data in a different way in order to build sub-isoscapes representing temporal
#' variation in isotope composition, or in order to produce isoscapes weighted 
#' by the amount of precipitation (for isoscapes on precipitation data only). 
#' The two possible options are to either split the data from each location by 
#' month or to split them by year. This is set with the \code{split.by} argument
#' of the function. Datasets prepared in this way should be fitted with the
#' function \code{\link{isomultifit}}.
#' 
#' The function also allows the user to filter the sampling locations 
#' based on time (years and/ or months) and space
#' (locations given in geographic coordinates, i.e. longitude and latitude) to
#' calculate tailored isoscapes matching e.g. the time of sampling and speeding
#' up the model fit by cropping/clipping a certain area. The dataframe
#' produced by this function can be used as input to fit the isoscape (see
#' \code{\link{isofit}} and  \code{\link{isomultifit}}).
#' 
#' @param data A \var{dataframe} containing original isotopic measurements
#' @param month A \var{numeric vector} indicating the months to select
#' from. Should be a vector of round numbers between 1 and 12. The default is 
#' 1:12 selecting all months.
#' @param year A \var{numeric vector} indicating the years to select
#' from. Should be a vector of round numbers. The default is 
#' to select all years available.
#' @param long.min A \var{numeric} indicating the minimum longitude to select
#' from. Should be a number between -180 and 180. If not provided, -180 will be
#' considered.
#' @param long.max A \var{numeric} indicating the maximal longitude to select
#' from. Should be a number between -180 and 180. If not provided, 180 will be
#' considered.
#' @param lat.min A \var{numeric} indicating the minimum latitude to select
#' from. Should be a number between -90 and 90. If not provided, -90 will be
#' considered.
#' @param lat.max A \var{numeric} indicating the maximal latitude to select
#' from. Should be a number between -90 and 90. If not provided, 90 will be
#' considered.
#' @param split.by A \var{string} indicating whether data should be aggregated 
#'   per location (\code{split.by = NULL}, the default), per location:month 
#'   combination (\code{split.by = "month"}), or per location:year combination 
#'   (\code{split.by = "year"}).
#' @param prop.random A \var{numeric} indicating the proportion of observations 
#'   or sampling locations (depending on the argument for \code{random.level})
#'   that will be kept. If \code{prop.random} is greater than 0, then the
#'   function will return a list containing two dataframes: one containing the
#'   selected data, called \code{selected.data}, and one containing the
#'   remaining data, called \code{remaining.data}.
#' @param random.level A \var{string} indicating the level at which random draws
#'   can be performed. The two possibilities are \code{"obs"}, which indicates
#'   that observations are randomly drawn taken independently of their location,
#'   or "station" (default), which indicates that observations are randomly
#'   drawn at the level of sampling locations.
#' @param col.isoscape.value A \var{string} indicating the column containing the
#'   isotopic measurements
#' @param col.stationID A \var{string} indicating the column containing the ID
#'   of each sampling location
#' @param col.lat A \var{string} indicating the column containing the latitude
#'   of each sampling location
#' @param col.long A \var{string} indicating the column containing the longitude
#'   of each sampling location
#' @param col.elev A \var{string} indicating the column containing the elevation
#'   of each sampling location
#' @param col.month A \var{string} indicating the column containing the month of
#'   sampling
#' @param col.year A \var{string} indicating the column containing the year of
#'   sampling
#' @return This function returns a \var{dataframe} containing the filtered data 
#'   aggregated by sampling location, or a \var{list}, see above argument 
#'   \code{prop.random}. For each sampling location the mean and variance sample
#'   estimates are computed.
#' @seealso \code{\link{IsoriX}} for the complete workflow
#' @examples
#' ## Create a processed dataset for Germany
#' GNIPDataDEagg <- prepdata(data = GNIPDataDE)
#' 
#' head(GNIPDataDEagg)
#' 
#' ## Create a processed dataset for Germany per month
#' GNIPDataDEmonthly <-prepdata(data = GNIPDataDE,
#'                              split.by = "month")
#' 
#' head(GNIPDataDEmonthly)
#' 
#' ## Create a processed dataset for Germany per year
#' GNIPDataDEyearly <- prepdata(data = GNIPDataDE,
#'                              split.by = "year")
#' 
#' head(GNIPDataDEyearly)
#' 
#' ## Create isoscape-dataset for warm months in germany between 1995 and 1996
#' GNIPDataDEwarm <- prepdata(data = GNIPDataDE,
#'                            month = 5:8,
#'                            year = 1995:1996)
#' 
#' head(GNIPDataDEwarm)
#' 
#' 
#' ## Create a dataset with 90% of obs
#' GNIPDataDE90pct <- prepdata(data = GNIPDataDE,
#'                             prop.random = 0.9,
#'                             random.level = "obs")
#' 
#' lapply(GNIPDataDE90pct, head) # show beginning of both datasets
#' 
#' ## Create a dataset with half the weather stations
#' GNIPDataDE50pctStations <- prepdata(data = GNIPDataDE,
#'                                     prop.random = 0.5,
#'                                     random.level = "station")
#' 
#' lapply(GNIPDataDE50pctStations, head)
#'
#'
#' ## Create a dataset with half the weather stations split per month
#' GNIPDataDE50pctStationsMonthly <- prepdata(data = GNIPDataDE,
#'                                            split.by = "month",
#'                                            prop.random = 0.5,
#'                                            random.level = "station")
#' 
#' lapply(GNIPDataDE50pctStationsMonthly, head)
#' 
#' @export
prepdata <- function(data, 
                     month = 1:12,
                     year,
                     long.min ,
                     long.max,
                     lat.min,
                     lat.max,
                     split.by = NULL,
                     prop.random = 0,
                     random.level = "station",
                     col.isoscape.value = "isoscape.value",
                     col.stationID = "stationID",
                     col.lat = "lat",
                     col.long = "long",
                     col.elev = "elev",
                     col.month = "month",
                     col.year = "year"
) {
  
  ## Some checks
  if (any(month %% 1 != 0) | any(month < 1) | any(month > 12)) {
    stop("Months must be provided as a vector of integers and should be between 1 and 12.")
  }
  
  if (prop.random > 1) {
    stop("The value you entered for prop.random is > 1. It must be a proportion (so between 0 and 1)!")
  }
  
  ## Handle missing data
  if (missing("year")) year <- sort(unique(data[, col.year], na.rm = TRUE))
  if (missing("long.min")) long.min <- -180
  if (missing("long.max")) long.max <- 180
  if (missing("lat.min")) lat.min <- -90
  if (missing("lat.max")) lat.max <- 90 
  
  ## Handle the month column and convert all months to numbers
  data[, col.month] <- .converts_months_to_numbers(data[, col.month])
  
  ## Prepare selection
  month.select <- data[, col.month] %in% month 
  year.select <- data[, col.year] %in% year
  long.select <- data[, col.long] >= long.min & data[, col.long] <= long.max
  lat.select  <- data[, col.lat]  >= lat.min  & data[, col.lat]  <= lat.max
  all.select <-  month.select & year.select & long.select & lat.select
  
  ## Apply selection
  query.data <- data[all.select, ]
  
  ## Defining function returning unique values with test
  unique2 <- function(x, key) {
    u.x <- unique(x)
    if (length(u.x) == 1) return(u.x)
    warning(paste(c("some", key, "values are not unique but should be, so the first element was taken among:", u.x), collapse = " "))
    return(u.x[1])
  }
  
  ## Defining function for aggregation
  aggregate.data <- function(d, split.by = split.by) {
    d <- droplevels(d)
    
    ## Create the variable used for the split
    if (is.null(split.by)) {
      split <- d[, col.stationID]
    } else if (split.by == "month") {
      split <- paste(d[, col.stationID], d[, col.month], sep = "_")
    } else if (split.by == "year") {
      split <- paste(d[, col.stationID], d[, col.year], sep = "_")
    } else {
      stop("argument split.by unknown.")
    }
    
    ## Perform the aggregation
    df <- data.frame(split = factor(c(tapply(as.character(split), split, unique2, key = "split"))),
                     stationID = factor(c(tapply(as.character(d[, col.stationID]), split, unique2, key = "stationID"))),
                     isoscape.value = c(tapply(d[, col.isoscape.value], split, mean, na.rm = TRUE)),
                     var.isoscape.value = c(tapply(d[, col.isoscape.value], split, stats::var, na.rm = TRUE)),
                     n.isoscape.value = c(tapply(d[, col.stationID], split, length)),
                     lat = c(tapply(d[, col.lat], split, unique2, key = "latitude")),
                     long = c(tapply(d[, col.long], split, unique2, key = "longitude")),
                     elev = c(tapply(d[, col.elev], split, unique2, key = "elevation"))
    )
    ## Note that above the c() prevent the creation of 1d arrays that are troublesome in spaMM
    
    null.var <- !is.na(df$var.isoscape.value) & df$var.isoscape.value == 0
    if (sum(null.var) > 0) {
      df$var.isoscape.value[null.var] <- 0.01
      warnings(paste(length(null.var), "null variances were obtained during aggregation. They were changed to 0.01 assuming that the actual variance cannot be smaller than the measurement error variance."))
    }
    
    ## Retrieve the relevant splitting information
    if (is.null(split.by)) {
      df <- df[order(df$stationID), ]
    } else if (split.by == "month") {
      df$month <- as.numeric(unlist(lapply(strsplit(as.character(df$split), split = "_", fixed = TRUE), function(i) i[2])))
      df <- df[order(df$stationID, df$month), ]
    } else if (split.by == "year") {
      df$year <- as.numeric(unlist(lapply(strsplit(as.character(df$split), split = "_", fixed = TRUE), function(i) i[2])))
      df <- df[order(df$stationID, df$year), ]
    }
    
    ## Clean-up and output
    df$split <- NULL
    df <- droplevels(df[!is.na(df$isoscape.value), ])
    rownames(df) <- NULL
    return(df)
  }
  
  ## Return aggregated data if no random selection is needed
  if (prop.random == 0) {
    return(aggregate.data(query.data, split.by = split.by))
  }
  
  ## Random draw of observations
  if (random.level == "obs") {
    howmanylines <- round(prop.random * nrow(query.data))
    whichlines <- sample(x = nrow(query.data), size = howmanylines, replace = FALSE)
    selected.data <- query.data[whichlines, ] 
    remaining.data <- query.data[-whichlines, ]
    return(list(selected.data = aggregate.data(selected.data, split.by = split.by),
                remaining.data = aggregate.data(remaining.data, split.by = split.by)
    )
    )
  } 
  
  ## Random draw of stationID
  if (random.level == "station") {
    howmanystations <- round(prop.random * length(unique(query.data[, col.stationID])))
    whichsstations <- sample(x = unique(query.data[, col.stationID]), size = howmanystations, replace = FALSE)
    dolines <- query.data[, col.stationID] %in% whichsstations
    selected.data <- query.data[dolines, ] 
    remaining.data <- query.data[!dolines, ]
    return(list(selected.data = aggregate.data(selected.data, split.by = split.by),
                remaining.data = aggregate.data(remaining.data, split.by = split.by)
    )
    )
  }
  
  ## Display error if no return encountered before
  stop("the argument you chose for random.level is unknown.")
  
}
