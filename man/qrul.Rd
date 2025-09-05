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
head(qrul(prob = 0.05, data = test, model = model))
}
\keyword{models}
