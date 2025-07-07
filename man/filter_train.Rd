\name{filter_train}
\docType{data}
\alias{filter_train}
\title{Training Data for Filter Degradation and RUL Prediction}
\description{
Training data from a real-world degradation process involving the clogging of gas filters. The dataset includes right-censored lifetimes due to a preventive maintenance policy. Failure is defined when pressure differential exceeds 600 Pa.
}
\usage{
data(filter_train)
}
\format{
A data frame with 49 degradation trajectories. Variables include:
\describe{
  \item{Time}{Time}
  \item{Differential_pressure}{Differential pressure across the filter in Pascal (Pa).}
  \item{Data_No}{Unique identifier for each filter test unit. Integer from 1 to 50.}
}
}
\source{
Adapted from: \cr
Hagmeyer, S., Mauthe, F., & Zeiler, P. (2021). \emph{Creation of Publicly Available Data Sets for Prognostics and Diagnostics Addressing Data Scenarios Relevant to Industrial Applications}. International Journal of Prognostics and Health Management, 12(2). \doi{10.36001/ijphm.2021.v12i2.3087}
}
\references{
See full description in the dataset repository on Kaggle by "Prognostics @ HSE".
}
