\name{fit_model}
\alias{fit_model}
\title{
Fitting the Linear Mixed Effects Model
}
\description{
Fits a linear or exponential mixed-effects model of degree \(p\) for the degradation process.
}
\usage{
fit_model(data,
  type = "exponential",
  method = "nlme",
  degree = 2,
  phi = NULL)
}
\arguments{
  \item{data}{A data frame with three columns: \code{t} for time, \code{x} for the degradation signal, and \code{unit} as the unit identifier. At least two distinct units are required.}

  \item{type}{Model type. Either \code{"linear"} or \code{"exponential"}. The exponential model applies a logarithmic transformation to \code{x - phi}. Default is \code{"exponential"}.}

  \item{method}{Estimation method. Either \code{"nlme"} to fit a nonlinear mixed-effects model using \code{nlme::lme()}, or \code{"lm"} to fit separate linear models per unit and estimate fixed and random effects from the set of coefficients. Default is \code{"nlme"}.}

  \item{degree}{Degree of the polynomial model. Default is \code{2}. The fixed and random effects will include powers of time up to the specified degree.}

  \item{phi}{Initial degradation level for non-defective units.
  Used in the exponential model as a fixed offset to ensure that the logarithmic transformation is valid and interpretable.
  If \code{NULL}, it is automatically estimated as a value slightly below the minimum observed degradation level.
  Ignored when \code{type = "linear"}.}
}

\details{
This function fits a linear or exponential polynomial mixed-effects model of degree \code{p} to degradation data collected over time from multiple units. The model captures both fixed effects (population-level degradation trends) and random effects (unit-specific deviations).

The exponential model applies a logarithmic transformation with an offset parameter \code{phi}. The offset \code{phi} can be provided or automatically estimated from the data.

At least two distinct units are required to estimate random effects. The degree parameter controls the polynomial order for the time terms in both fixed and random effects.
}
\value{
  Returns a list with the estimated model and prior distributions.
}
\references{
{
Liu, K. and Huang, S. (2016). \emph{Integration of Data Fusion Methodology and Degradation Modeling Process to Improve Prognostics}. IEEE Transactions on Automation Science and Engineering, 13(1), 344--354.\doi{10.1109/TASE.2014.2349733}
}

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

