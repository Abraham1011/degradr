\name{qrul}
\alias{qrul}
\title{
Quantiles of the Remaining Useful Life (RUL) Distribution
}
\description{
Returns quantiles of the Remaining Life Distribution for one or more units based on their observed degradation signals and a fitted model.
}
\usage{
qrul(prob = 0.05, data, model, D = NULL, upper = NULL)
}
\arguments{
  \item{prob}{Probability at which to evaluate the quantile of the RUL distribution.}
  \item{data}{A data frame with columns \code{t} (time), \code{x} (degradation measurement), and \code{unit} (unit identifier). If \code{model} is of class \code{"healthindex"}, provide the multivariate sensor data; the health index is computed internally.}
  \item{model}{An object of class \code{"degradation_model"} returned by \code{\link{fit_model}} or a \code{"healthindex"} object from \code{\link{fit_healthindex}}.}
  \item{D}{Optional critical degradation threshold. If \code{NULL}, a random-threshold model is used; otherwise the provided threshold is used. For exponential models the threshold is internally log-transformed.}
  \item{upper}{Optional upper bound for the numerical search when computing quantiles. If \code{NULL}, the maximum time observed during training is used.}
}
\details{
For each unit in \code{data} the function computes the posterior distribution of the model parameters and evaluates the specified quantile of the Remaining Life Distribution. Units that result in computational errors return \code{NA}.
}
\value{
A data frame with one row per unit containing:
\item{unit}{Unit identifier.}
\item{RUL}{The requested quantile of the RUL distribution.}
}
\seealso{\code{\link{prul}}, \code{\link{predict_rul}}}
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

# Compute the median RUL for each test unit
qrul(prob = 0.5, data = filter_test, model = model, D = 600)
}
}
\keyword{models}
