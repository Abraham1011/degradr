\name{test_FD001}
\alias{test_FD001}
\docType{data}
\title{
NASA Turbofan Engine Degradation Simulation Test Data (Subset FD001)
}
\description{
Truncated time series data from turbofan engine degradation simulations, generated using the C-MAPSS (Commercial Modular Aero-Propulsion System Simulation) model. This test dataset contains operational sensor data up to a point before failure, intended for validating prognostic algorithms that estimate Remaining Useful Life (RUL).
}
\format{
  A data frame with multiple observations (rows) on the following 24 variables (columns):
  \describe{
    \item{\code{unit}}{Engine unit number (identifier)}
    \item{\code{t}}{Time in cycles}
    \item{\code{T2}}{Total temperature at fan inlet (°R)}
    \item{\code{T24}}{Total temperature at LPC outlet (°R)}
    \item{\code{T30}}{Total temperature at HPC outlet (°R)}
    \item{\code{T50}}{Total temperature at LPT outlet (°R)}
    \item{\code{P2}}{Pressure at fan inlet (psia)}
    \item{\code{P15}}{Total pressure in bypass-duct (psia)}
    \item{\code{P30}}{Total pressure at HPC outlet (psia)}
    \item{\code{Nf}}{Physical fan speed (rpm)}
    \item{\code{Nc}}{Physical core speed (rpm)}
    \item{\code{epr}}{Engine pressure ratio (P50/P2)}
    \item{\code{Ps30}}{Static pressure at HPC outlet (psia)}
    \item{\code{phi}}{Ratio of fuel flow to Ps30 (pps/psi)}
    \item{\code{NRf}}{Corrected fan speed (rpm)}
    \item{\code{NRc}}{Corrected core speed (rpm)}
    \item{\code{BPR}}{Bypass Ratio}
    \item{\code{farB}}{Burner fuel-air ratio}
    \item{\code{htBleed}}{Bleed Enthalpy}
    \item{\code{Nf_dmd}}{Demanded fan speed (rpm)}
    \item{\code{PCNfR_dmd}}{Demanded corrected fan speed (rpm)}
    \item{\code{W31}}{HPT coolant bleed (lbm/s)}
    \item{\code{W32}}{LPT coolant bleed (lbm/s)}
  }
}
\details{
Key characteristics of this test dataset:
\itemize{
  \item Simulates progressive degradation in the High Pressure Compressor (HPC) module
  \item Time series are truncated prior to failure (true RUL values not included)
  \item Includes realistic measurement noise and unit-to-unit variability
  }
}
\references{
Saxena, A., Goebel, K., Simon, D., & Eklund, N. (2008). \emph{Damage propagation modeling for aircraft engine run-to-failure simulation}. In \emph{2008 International Conference on Prognostics and Health Management} (pp. 1--9). IEEE. \doi{10.1109/PHM.2008.4711414}
}
\examples{
data(test_FD001)
}
\keyword{datasets}
