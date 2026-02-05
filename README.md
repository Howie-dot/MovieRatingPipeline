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

[ Raw Data Sources ]
        │
        │  (CSV, CPI, Metadata)
        ▼
[ Bash Orchestration ]
  run_pipeline.sh
  ├─ Secure ingestion
  ├─ Spark job control
  └─ End-to-end reproducibility
        │
        ▼
[ PySpark Processing Layer ]
  run_spark.py
  ├─ Data cleaning
  ├─ Schema alignment
  ├─ Multi-source joins
  └─ Inflation adjustment
        │
        ▼
[ Curated Datasets ]
  Analytics-ready outputs
        │
        ▼
[ DuckDB Analytical Layer ]
  duckdb_query.sql
  ├─ View creation
  └─ BI-friendly aggregations
        │
        ▼
[ Analytics & BI ]
  SQL · Tableau

---

## Pipeline Orchestration

The entire pipeline is executed via a single Bash entrypoint:

```bash
bash/run_pipeline.sh

This script coordinates:

- Secure dataset ingestion via the Kaggle API  
- External macroeconomic data downloads (CPI)  
- Execution of PySpark batch jobs  
- Initialization of DuckDB and analytical view creation  

This design allows the pipeline to be re-run end-to-end without manual intervention.

---

## Data Sources

- **Movie Metadata (2008–2023)**  
  Public movie-level metadata including revenue, budget, genres, cast, and directors  

- **Genre, Cast, and Director Enrichment**  
  Supplemental datasets used to enrich movie-level observations  

- **Inflation (CPI)**  
  Consumer Price Index data used to normalize revenue figures across years  

All revenue metrics are adjusted to constant dollars to enable fair comparison across time.

---

## Distributed Data Processing (PySpark)

All transformations are performed using PySpark to support scalable data processing.

Key transformation steps include:

- Schema standardization across heterogeneous CSV inputs  
- Join optimization across movie, cast, director, and genre datasets  
- Feature engineering for revenue, budget, and temporal indicators  
- CPI-based inflation adjustment  
- Partitioned writes of processed datasets for downstream consumption  

The Spark job implementation is located in `spark/run_spark.py`.

---

## Analytical Serving Layer (DuckDB)

Processed datasets are loaded into DuckDB, where SQL is used to define analytical views optimized for fast querying and BI tool integration.

DuckDB was selected for:

- High-performance local analytical queries  
- Lightweight deployment with minimal operational overhead  
- Seamless downstream integration with visualization tools  

View definitions are maintained in `duckdb/duckdb_query.sql`.

---

## Example Analytical Use Cases

- Revenue performance comparison across genres and release periods  
- Portfolio allocation analysis for production companies  
- Inflation-adjusted ROI analysis by director or lead actor  
- Budget efficiency trends over time  

---

## Reproducibility

To reproduce the full pipeline:

1. Configure Kaggle API credentials  
   - Create a Kaggle API token and place `kaggle.json` under `.kaggle/`  

2. Execute the pipeline:

```bash
bash/run_pipeline.sh

3. Query analytical views via DuckDB or connect a BI tool

---

## Tech Stack

- PySpark – Distributed data processing  
- Bash – Pipeline orchestration  
- DuckDB – Analytical SQL engine  
- Tableau – Downstream visualization (optional)  
- Python / SQL – Core implementation  

---

## Design Decisions and Trade-offs

- **Spark over pandas**: chosen to reflect production-scale workflows and handle datasets that exceed single-machine memory  
- **DuckDB over traditional RDBMS**: enables fast analytical queries without standing up external infrastructure  
- **Batch architecture**: well-suited for historical analysis and portfolio-level decision support  

---

## Notes

This project emphasizes scalable pipeline design, data quality, and analytical usability over predictive modeling, mirroring real-world analytics and data engineering workflows.

