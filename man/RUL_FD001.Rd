\name{RUL_FD001}
\alias{RUL_FD001}
\docType{data}
\title{
Remaining Useful Life (RUL) Ground Truth for FD001 Dataset
}
\description{
Ground truth values of the Remaining Useful Life (RUL) for each engine unit in the FD001 subset of the C-MAPSS dataset. These values correspond to the last observed cycle in the test set and are used for evaluation purposes in prognostics models.
}
\usage{data("RUL_FD001")}
\format{
  A data frame with 100 observations on the following variable:
  \describe{
    \item{\code{RUL}}{Numeric vector indicating the true Remaining Useful Life (in cycles) for each unit in the test set.}
  }
}
\details{
This dataset is part of the C-MAPSS (Commercial Modular Aero-Propulsion System Simulation) benchmark and is used as ground truth for performance evaluation of predictive maintenance models, particularly for models estimating Remaining Useful Life (RUL) under the FD001 operating condition scenario.
}
\references{
Saxena, A., Goebel, K., Simon, D., & Eklund, N. (2008). \emph{Damage propagation modeling for aircraft engine run-to-failure simulation}. In \emph{2008 International Conference on Prognostics and Health Management} (pp. 1--9). IEEE. \doi{10.1109/PHM.2008.4711414}
}
\examples{
data(RUL_FD001)
}
\keyword{datasets}
