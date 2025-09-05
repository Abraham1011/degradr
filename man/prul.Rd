\name{prul}
\alias{prul}
\title{
Probability of Remaining Useful Life (RUL) Falling Within a Time Horizon
}
\description{
Evaluates the cumulative probability that the Remaining Useful Life (RUL) of one or more units is less than or equal to a specified time \code{t}. The computation is based on a fitted degradation model and the observed degradation signals for the units.
}
\usage{
prul(t, data, model, D = NULL)
}
\arguments{
  \item{t}{Time at which to evaluate the RUL cumulative distribution function.}
  \item{data}{A data frame with columns \code{t} (time), \code{x} (degradation measurement), and \code{unit} (unit identifier) for one or more units. If \code{model} is of class \code{"healthindex"}, provide the multivariate sensor data; the health index will be constructed internally.}
  \item{model}{An object of class \code{"degradation_model"} produced by \code{\link{fit_model}} or a \code{"healthindex"} object returned by \code{\link{fit_healthindex}}.}
  \item{D}{Optional critical degradation threshold. If provided, a fixed-threshold model is used; otherwise a random-threshold model is assumed. For exponential models the threshold is automatically transformed to the log scale.}
}
\details{
For a fixed threshold model (\code{D} supplied), the function computes the Remaining Life Distribution (RLD) using the specified failure threshold. If \code{D} is \code{NULL}, the distribution is computed under a random-threshold formulation based on the training data.
}
\value{
A data frame with one row per unit containing:
\item{unit}{Unit identifier.}
\item{PRUL}{Cumulative probability that \eqn{\mathrm{RUL} \le t}.}
}
\seealso{\code{\link{qrul}}, \code{\link{predict_rul}}}
\examples{
\donttest{
library(degradr)

# Load example data sets
data(filter_train)
data(filter_test)

# Rename columns to the expected format
colnames(filter_train) <- c("t", "x", "unit")
colnames(filter_test)  <- c("t", "x", "unit", "RUL")

# Fit an exponential mixed-effects model of degree 1
model <- fit_model(data = filter_train, type = "exponential", degree = 1)

# Probability that each unit fails within 50 cycles given a failure threshold D = 600
prul(t = 50,
     data = filter_test,
     model = model, D = 600)
}
}
\keyword{models}
