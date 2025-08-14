\name{compute_healthindex}
\alias{compute_healthindex}
\title{
Constructing the Health Index on New Data Using Trained Weights
}
\description{
Given a fitted \code{"healthindex"} object, this function constructs the univariate health index for new multivariate sensor data by applying the stored projection (weights and offsets).
}
\usage{
compute_healthindex(model, data)
}
\arguments{
  \item{model}{An object of class \code{"healthindex"} returned by \code{\link{fit_healthindex}}.}

  \item{data}{A data frame with new sensor readings over time. Must include the columns \code{t} (time) and \code{unit} (unit identifier), plus the same set of degradation signals used at training. All degradation signals must follow an upward trend.}
}
\details{
This function applies the projection learned in the first stage of \code{\link{fit_healthindex}} to new data:
}
\value{
A data frame (tibble) with the columns:
  \item{unit}{Unit identifier.}
  \item{t}{Time index.}
  \item{x}{Constructed health index at each \code{(unit, t)}.}
}
\seealso{
\code{\link{fit_healthindex}} for learning the health index and mixed-effects model,
\code{\link{predict_rul}} for RUL prediction based on the fitted model.
}
\examples{
library(degradr)
library(dplyr)
# Load example data
data(train_FD001)
data(test_FD001)
data <- train_FD001 \%>\%
  select(unit,t,T24,T50,P30,
         Nf,Ps30,phi, NRf,
         BPR,htBleed,
         W31, W32) \%>\%
  mutate(across(c(P30,phi,W31,W32), ~ . * -1))

test <- test_FD001 \%>\%
  select(unit,t,T24,T50,P30,
         Nf,Ps30,phi, NRf,
         BPR,htBleed,
         W31, W32) \%>\%
  mutate(across(c(P30,phi,W31,W32), ~ . * -1))

# Fit a health index model (exponential trajectory of degree 2)
model <- fit_healthindex(data = data, type = "exponential",
                         degree = 2, r = 0.8)

# Construct the health index on new data using stored weights/offsets
hi_new <- compute_healthindex(model = model, data = test)
head(hi_new)
}
\keyword{models}
