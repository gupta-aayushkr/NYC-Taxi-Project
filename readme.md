# NYC Taxi Data Analysis Project

## Overview

This data engineering project utilizes Azure Synapse Analytics to analyze and transform New York City taxi data released by nyc.gov. The project covers the entire data processing pipeline, from raw data ingestion to creating meaningful insights using Azure Synapse Analytics, Apache Spark, and Power BI.

## Table of Contents

1. [NYC Taxi Data Overview](#nyc-taxi-data-overview)
2. [Project Resources and Architecture](#project-resources-and-architecture)
3. [Architecture Explanation & Project Working](#architecture-explanation--project-working)
4. [Synapse Pipeline Orchestration](#synapse-pipeline-orchestration)
5. [Power BI Reporting](#power-bi-reporting)
6. [Budget Analysis For Project](#budget-analysis-for-project)
7. [Conclusion and Future Enhancements](#conclusion-and-future-enhancements)

## NYC Taxi Data Overview

The project analyzes NYC taxi data, categorizing taxis into types (Yellow Taxis, Green Taxis, For-Hire Vehicles) and considering boroughs as distinct administrative divisions. The seven main tables contributing to the project include Trip Data, Taxi Zone, Calendar, Trip Type, Payment Type, Rate Code, and Vendor.

## Project Resources and Architecture

The project relies on Azure Synapse Analytics, utilizing Azure Data Lake Storage, Serverless SQL Pool, Apache Spark, Synapse Pipelines, and Power BI. The architecture ensures seamless integration and ease of use for handling big data projects.

## Architecture Explanation & Project Working

Detailed explanations are provided for loading raw data into the Raw Container, transforming data from the Bronze Schema to Silver Schema, and further transforming it into the Gold Schema. The project utilizes External Tables, CETAS, and Stored Procedures for efficient data processing.

## Synapse Pipeline Orchestration

The Synapse pipeline orchestrates various stages of the data processing pipeline, including creating Silver External Tables, handling Trip Data partitioning in the Silver Schema, and transforming data from the Silver Schema to the Gold Schema. Triggers are used for scheduling these pipelines.

## Power BI Reporting

Power BI is employed for creating insightful reports on payment methods used by passengers and taxi demand in NYC. The reports offer valuable insights for decision-making.

Explore the Power BI reports for detailed insights:
- [Payment Methods & Taxi Demand Analysis](https://www.novypro.com/project/nyc-taxi-project/payment-methods-report)

## Budget Analysis For Project

A budget analysis section outlines the incurred costs, primarily from Azure Synapse Analytics Workspace, SQL Serverless Pool, Pipelines, and Storage.

## Conclusion and Future Enhancements

The project successfully demonstrates the capabilities of Azure Synapse Analytics. Future enhancements could include cost optimization, real-time data processing, machine learning integration, data governance, security measures, and improved Power BI dashboards.

Feel free to explore the GitHub repository and use the code as a reference or starting point for similar projects.
