\name{prul}
\alias{prul}
\title{
Probability of Remaining Useful Life (RUL) Falling Within a Time Horizon
}
\description{
Evaluates the cumulative probability that the Remaining Useful Life (RUL) of a unit is less than or equal to a specified time \code{t}. The computation is based on a fitted degradation model and the observed degradation signal for the unit.
}
\usage{
prul(t, data, model, D = NULL)
}
\arguments{
  \item{t}{Time at which to evaluate the RUL cumulative distribution function.}
  \item{data}{A data frame with columns \code{t} (time), \code{x} (degradation measurement), and \code{unit} (unit identifier) or a data frame containing sensor readings over time: must include the columns \code{t} (time), \code{unit} (unit identifier), and multiple degradation signals. Multiple units can be passed simultaneously.}
  \item{model}{An object of class \code{"degradation_model"} produced by \code{\link{fit_model}} or a \code{"healthindex"} object returned by \code{\link{fit_healthindex}}.}
  \item{D}{Optional critical degradation threshold. If provided, a fixed-threshold model is used; otherwise a random-threshold model is assumed. For exponential models the threshold is automatically transformed to the log scale.}
}
\details{
For a fixed threshold model (\code{D} supplied), the function computes the Remaining Life Distribution (RLD) using the specified failure threshold. If \code{D} is \code{NULL}, the distribution is computed under a random-threshold formulation based on the training data.
}
\value{
Numeric value between 0 and 1 giving \eqn{P(\mathrm{RUL} \le t)}.
}
\seealso{\code{\link{qrul}}, \code{\link{predict_rul}}}
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
#Probability that the run length will be less than or equal to 86 cycles
head(prul(t = 86, data = test, model = model))

}
\keyword{models}
