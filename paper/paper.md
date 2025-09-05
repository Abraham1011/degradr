---
title: "degradr: Estimating Remaining Useful Life with Linear Mixed Effects Models"
tags:
  - R
  - reliability
  - prognostics
  - degradation models
  - remaining useful life
authors:
  - name: Pedro Abraham Montoya-Calzada
    orcid: 0009-0002-3497-210X
    affiliation: 1
  - name: Rogelio Salinas-Gutiérrez
    orcid: 0000-0002-1669-4460
    corresponding: true
    affiliation: 1
  - name: Silvia Rodríguez-Narciso
    orcid: 0000-0001-5429-5914
    affiliation: 1
  - name: Netzahualcóyotl Castañeda-Leyva
    orcid: 0000-0001-9414-3923
    affiliation: 1
affiliations:
  - name: Universidad Autónoma de Aguascalientes (UAA), México
    index: 1
    ror: 03ec8vy26
date: 27 August 2025
bibliography: references.bib
link-citations: true
---

# Summary

**degradr**[@degradr] is an R package that provides tools for estimating the Remaining Useful Life (RUL) of degrading systems using the mixed effects model proposed by [@Lu01051993]. It supports both univariate and multivariate degradation signals, where multivariate inputs are fused into a univariate health index prior to modeling. The package implements both linear and exponential degradation trajectories, with the latter handled via a log-transformation. RUL distributions are estimated using Bayesian updating, enabling predictive maintenance in real-world settings. The methodology builds upon the data fusion and degradation modeling framework proposed by [@6902828].  
The package is freely available on CRAN, ensuring accessibility and easy installation for the R community [@RCoreTeam].  


# Statement of need
The ability to accurately predict the Remaining Useful Life of components and systems is critical for reliability engineering, predictive maintenance, and risk management. While several prognostic methods exist, many require complex model specification or are restricted to specific data sources. **degradr** addresses this gap by providing a flexible and user-friendly framework for modeling degradation processes using mixed-effects models.  

The main contribution of the package is the implementation of a health index to fuse signals from multiple inputs and predict the RUL with such an index. To our knowledge, there is currently no other package in R that provides this approach.  

There are existing packages in R that are widely used in reliability and survival analysis, such as survival[@Survival], which provides core tools for time-to-event analysis (e.g., Kaplan–Meier curves, Cox models, accelerated failure time models)
, and SPREDA[@SPREDA], which implements advanced methods for reliability data with dynamic covariates, degradation models, and lifetime data with censoring. However, these packages do not focus on combining heterogeneous sensor data into a health index that can be directly integrated into degradation modeling for RUL prediction.

By integrating health-index construction from multiple sensors with mixed-effects degradation models, **degradr** offers a complementary approach that broadens the toolbox available to practitioners. Its focus is on providing reproducible workflows, illustrative datasets (e.g., NASA C-MAPSS [@saxena2008] and real-world filter clogging data [@hagmeyer2021]), and visualization functions. Its availability on CRAN further guarantees that the software can be easily integrated into academic research, industrial projects, and teaching activities.


# Software description

## Key functionality

- **Health index construction**  
  - `fit_healthindex()`: It constructs a univariate health index from multivariate data by minimizing the error of the model fit and minimizing the variance of the fall threshold jointly. 
  - `compute_healthindex()`: applies the learned projection to new multivariate data to construct the health index.

- **Degradation modeling**  
  - `fit_model()`: fits polynomial mixed-effects models (linear or exponential) to degradation trajectories.
  - Supports exponential trajectories via a log-transformation with offset parameter \(\phi\).

- **Remaining Useful Life prediction**  
  - `predict_rul()`: computes RUL distributions using Bayesian updating conditional on observed data. Works with both fixed-threshold and random-threshold models.  
  - Returns the point estimate of the RUL for each unit.

- **Distribution of Remaining Useful Life**  
  - `prul()`: computes RUL distributions using Bayesian updating conditional on observed data. Works with both fixed-threshold and random-threshold models.  
  - returns the probability that the RUL is less than a time t.

- **Quantile function of Remaining Useful Life**  
  - `qrul()`: computes RUL distributions using Bayesian updating conditional on observed data and computes the quantile function of Remaining Useful Life. Works with both fixed-threshold and random-threshold models.  
  - Returns quantiles of the Remaining Life Distribution for one or more units based on their observed degradation signals and a fitted model.


- **Visualization**  
  - `plot_degradr()`: plots degradation trajectories for multiple units, with optional failure threshold overlays.  

- **Illustrative datasets**  
  - `train_FD001`, `test_FD001`, `RUL_FD001`: subsets of the NASA C-MAPSS turbofan engine dataset [@saxena2008].  
  - `filter_train`, `filter_test`: real-world gas filter clogging data [@hagmeyer2021].

## Workflow

A typical workflow with **degradr** consists of:

1. Load degradation data (`train_FD001`, `filter_train`, or user-provided).  
2. Visualize degradation trajectories (`plot_degradr()`).
3. Fit the model, `fit_healthindex()` if they are multivariate data or `fit_model()` if they are univariate data.
4. Apply **Bayesian updating** to predict RUL for new units (`predict_rul`,`prul`,`qrul`).  

This pipeline enables reproducible prognostic analyses in R, lowering the barrier for applying advanced degradation modeling to academic research, industrial projects, and teaching activities.


# Illustrative example

The package can be installed directly from CRAN

```R
install.packages("degradr")
```

```R
library(degradr)
library(tidyverse)

data(train_FD001)
data(test_FD001)
data <- train_FD001 %>%
  select(unit,t,T24,T50,Nf,Ps30) 
test <- test_FD001 %>%
  select(unit,t,T24,T50,Nf,Ps30) 
head(data,5)
```

```
  unit t    T24     T50      Nf  Ps30
1    1 1 641.82 1400.60 2388.06 47.47
2    1 2 642.15 1403.14 2388.04 47.49
3    1 3 642.35 1404.20 2388.08 47.27
4    1 4 642.35 1401.87 2388.11 47.13
5    1 5 642.37 1406.22 2388.06 47.28
```

fit the model:

```R
model <- fit_healthindex(data = data, type = "exponential",
 degree = 2, r = 0.8)
```

Probability that the run length will be less than or equal to 86 cycles:

```R
head(prul(t = 86, data = test, model = model))
```

```
 unit   prob
1    1 0.0006
2    2 0.1121
3    3 0.8070
4    4 0.8223
5    5 0.4686
6    6 0.1940
```

Estimate the RUL:

```R
rul_pred <- predict_rul(data = test, model = model)
head(rul_pred)
```

```
  unit       RUL
1    1 172.50174
2    2 122.94194
3    3  68.58376
4    4  67.98462
5    5  94.17453
6    6 127.29824
```

# Acknowledgements

Thanks to SECIHTI for its support and to the Universidad Autónoma de Aguascalientes for the use of its facilities.

# References



