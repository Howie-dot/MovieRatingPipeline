# End-to-End Spark Data Pipeline for Movie Revenue Strategy Analysis

This project implements a production-style, end-to-end data pipeline designed to support strategic decision-making for movie production companies. The pipeline ingests large-scale public movie metadata, performs distributed transformations using PySpark, and exposes curated analytical views through DuckDB for downstream analysis and visualization.

The emphasis of this project is on pipeline design, automation, and analytical readiness, rather than exploratory notebooks or ad-hoc analysis.

---

## Problem Statement

Movie production companies operate in a capital-intensive and highly uncertain environment. Decisions around genre allocation, talent selection, and release timing depend on understanding historical performance while accounting for inflation and structural differences across films.

The goal of this project is to transform raw, heterogeneous movie datasets into a clean, analytics-ready data layer that supports portfolio-level revenue strategy analysis.

---

## Solution Overview

I designed and implemented a batch analytics pipeline with the following characteristics:

- Automated ingestion from multiple external data sources  
- Distributed data cleaning and feature engineering using PySpark  
- Inflation-adjusted revenue normalization  
- Analytical view creation using DuckDB  
- A single-entrypoint Bash workflow to ensure reproducibility  

The resulting data model enables flexible analysis across genres, directors, lead actors, budgets, and time periods.

---

## Architecture Overview

Raw Data Sources  
↓  
Bash Orchestration (`run_pipeline.sh`)  
- Data extraction (Kaggle API, wget)  
- Spark job execution  

↓  
PySpark Transformations (`run_spark.py`)  
- Data cleaning and schema normalization  
- Multi-source joins  
- Inflation adjustment  

↓  
Processed Datasets  

↓  
DuckDB Analytical Layer (`duckdb_query.sql`)  
- View creation  
- Aggregations for BI consumption  

↓  
Downstream Analytics (Tableau / SQL)

---

## Pipeline Orchestration

The entire pipeline is executed via a single Bash entrypoint:

```bash
bash/run_pipeline.sh
