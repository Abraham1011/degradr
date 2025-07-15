\name{predict_rul}
\alias{predict_rul}
\title{
Predicting Remaining Useful Life (RUL) from Degradation Signals
}
\description{
Estimates the Remaining Useful Life (RUL) for one or more partially observed degradation signals based on a previously fitted linear or exponential mixed-effects model.
}
\usage{
predict_rul(data, model, D = NULL, upper = NULL)
}
\arguments{
  \item{data}{A data frame with columns \code{t} (time), \code{x} (degradation measurement), and \code{unit} (unit identifier). Multiple units can be passed simultaneously.}

  \item{model}{An object of class \code{"degradation_model"} produced by the \code{\link{fit_model}} function.}

  \item{D}{(Optional) Critical degradation threshold. If provided, it will be used to compute the RUL via a fixed-threshold model. If \code{NULL} (default), a random-threshold model will be used based on training data statistics.}

  \item{upper}{Optional upper bound for the search interval when solving for the quantiles of the RUL distribution. If \code{NULL}, the function will use the maximum observed time in the training data.}
}
\details{
This function applies Bayesian updating to compute the posterior distribution of the degradation model parameters for each unit, conditional on its observed signal. Then, it computes the Remaining Life Distribution (RLD) and returns the estimated Remaining Useful Life.

It supports both linear and exponential degradation models, matching the formulation used in \code{\link{fit_model}}. The posterior updating follows the methodology of Liu and Huang (2016).
}
\value{
A data frame with one row per unit and the following columns:
\describe{
  \item{unit}{Unit identifier.}
  \item{RUL}{Estimated RUL.}
}
}
\references{
Liu, K. and Huang, S. (2016). \emph{Integration of Data Fusion Methodology and Degradation Modeling Process to Improve Prognostics}. IEEE Transactions on Automation Science and Engineering, 13(1), 344--354. \doi{10.1109/TASE.2014.2349733}
}
\examples{
library(degradr)

# Load example data sets
data(filter_train)
data(filter_test)

# Show the original column names
colnames(filter_train)

# Rename the columns to match the expected format: t, x, unit
colnames(filter_train) <- c("t", "x", "unit")
colnames(filter_test)  <- c("t", "x", "unit", "RUL")

# Plot the training set
plot_degradr(data = filter_train, D = 600)

# Fit an exponential mixed-effects model of degree 1
model <- fit_model(data = filter_train, type = "exponential", degree = 1)

# Predict the remaining useful life (RUL) for the test units,
# assuming a fixed failure threshold D = 600
predict_rul(data = filter_test, model = model, D = 600)
}
