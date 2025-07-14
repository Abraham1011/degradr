\name{plot_degradr}
\alias{plot_degradr}
\title{
Plot Degradation Trajectories for Multiple Units
}
\description{
Generates a line plot of degradation signals over time for each unit, optionally overlaying a failure threshold line. This function is useful for visualizing degradation paths across multiple components or systems.
}
\usage{
plot_degradr(data, D = NULL)
}
\arguments{
  \item{data}{A data frame with three columns: \code{t} for time, \code{x} for the degradation signal, and \code{unit} as the unit identifier.}
  \item{D}{
  Optional numeric value indicating the failure threshold.
  }
}
\details{
The function is designed to work with degradation datasets where each row represents an observation of a unit at a particular time. The plot shows how the degradation variable \code{x} evolves over time \code{t} for each unit. This is especially useful for visual inspection before model fitting or threshold analysis.
}
\value{
Returns a \code{ggplot} object that can be further customized or directly printed.
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
plot_degradr(data = filter_train, D = 600)
}
\keyword{visualization}
