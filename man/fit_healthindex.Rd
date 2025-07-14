\name{fit_healthindex}
\alias{fit_healthindex}
\title{
Fitting a Health Index Model from Multivariate Signals
}
\description{
Fits a health index–based degradation model by projecting multivariate sensor signals into a univariate health index and modeling its evolution using a linear mixed-effects model.
}
\usage{
fit_healthindex(data,
  type = "exponential",
  method = "lm",
  degree = 2,
  phi = NULL,
  r = 0.5)
}
\arguments{
  \item{data}{A data frame containing sensor readings over time. Must include the columns \code{t} (time), \code{unit} (unit identifier), and multiple degradation signals. All degradation signals must have an upward trend.}
  \item{type}{Model type. Either \code{"linear"} or \code{"exponential"}. The exponential model applies a logarithmic transformation to \code{x - phi}. Default is \code{"exponential"}.}

  \item{method}{Estimation method. Either \code{"nlme"} to fit a nonlinear mixed-effects model using \code{nlme::lme()}, or \code{"lm"} to fit separate linear models per unit and estimate fixed and random effects from the set of coefficients. Default is \code{"lm"}.}

  \item{degree}{Degree of the polynomial model. Default is \code{2}. The fixed and random effects will include powers of time up to the specified degree.}

  \item{phi}{Initial degradation level for non-defective units.
  Used in the exponential model as a fixed offset to ensure that the logarithmic transformation is valid and interpretable.
  If \code{NULL}, it is automatically estimated as a value slightly below the minimum observed degradation level.
  Ignored when \code{type = "linear"}.}

  \item{r}{parameter that controls the relative importance of the threshold variance and the weighted residual sum of squares in the index-fitted degradation model.}
}
\details{
This function implements a two-stage modeling strategy. In the first stage, a univariate health index is constructed as a weighted linear combination of the input signals, using correlation-based shrinkage. In the second stage, the resulting health index is modeled over time with a linear mixed-effects model (on the log scale for exponential models).

The exponential model uses a log transformation of \code{x - phi}, where \code{phi} ensures positivity and interpretability. The \code{phi} parameter can be supplied by the user or estimated automatically.

The resulting object stores both the projection (health index definition) and the fitted model used for RUL prediction.
}
\value{
Returns an object of class \code{"healthindex"}, which contains:
  \item{index}{A list with components: weights \code{w}, offset \code{phi}, and raw projections.}
  \item{model}{A fitted mixed-effects model of the health index over time.}
}
\references{
Liu, K. and Huang, S. (2016). \emph{Integration of Data Fusion Methodology and Degradation Modeling Process to Improve Prognostics}. IEEE Transactions on Automation Science and Engineering, 13(1), 344--354.\doi{10.1109/TASE.2014.2349733}
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
rul <- predict_rul(data = test, model = model)
head(rul)
}
\keyword{models}
