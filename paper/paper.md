---
title: "degradr: Estimating Remaining Useful Life with Linear Mixed Effects Models"
tags:
  - R
  - reliability
  - prognostics
  - degradation models
  - remaining useful life
authors:
  - name: Pedro Abraham Montoya Calzada
    orcid: 0009-0002-3497-210X
    corresponding: true
    affiliation: 1
  - name: Rogelio Salinas Gutiérrez
    orcid: 0000-0002-1669-4460
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
    ror: 01m8c9483
date: 27 August 2025
bibliography: references.bib
---

# Summary

**degradr** is an R package that provides tools for estimating the Remaining Useful Life (RUL) of degrading systems using linear mixed-effects models. It supports both univariate and multivariate degradation signals, where multivariate inputs are fused into a univariate health index prior to modeling. The package implements both linear and exponential degradation trajectories, with the latter handled via a log-transformation. RUL distributions are estimated using Bayesian updating, enabling predictive maintenance in real-world settings. The methodology builds upon the data fusion and degradation modeling framework proposed by Liu and Huang (2016) [@6902828].  
The package is freely available on CRAN, ensuring accessibility and easy installation for the R community [@RCoreTeam].  

# Statement of need

The ability to accurately predict the Remaining Useful Life of components and systems is critical for reliability engineering, predictive maintenance, and risk management. While several prognostic methods exist, many require complex model specification or are restricted to specific data sources. **degradr** addresses this gap by providing a flexible and user-friendly framework for modeling degradation processes using mixed-effects models.  

The package is designed for engineers, statisticians, and researchers who work with degradation data in fields such as manufacturing, aerospace, and industrial maintenance. By combining health-index construction from multiple sensors with mixed-effects degradation models, **degradr** offers a general framework that is applicable across domains. Compared to existing tools, it lowers the barrier for practitioners to implement advanced prognostics in R, with reproducible workflows, illustrative datasets (e.g., NASA C-MAPSS [@saxena2008] and real-world filter clogging data [@hagmeyer2021]), and visualization functions. Its availability on CRAN further guarantees that the software can be easily integrated into academic research, industrial projects, and teaching activities.

