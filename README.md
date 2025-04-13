# Enterprise Data Warehouse for Fashion Retail Analytics
Building a modern data warehouse with SQL Server, including ETL processes, data modeling and analytics.

---
## 🏗 Data Architecture

The data architecture for this project follow the Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![image_alt](https://github.com/princeabdul99/Design-and-Deployment-of-a-Fashion-Retail-Data-Warehouse/blob/645bddfc991cd25d4f1b02ded96ffb187f62edcc/docs/architecture.png)  

1. **Bronze Layer:** Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer:** This layer includes data cleansing, standardization processes to prepare data for analysis.
3. **Gold Layer:** Houses business-ready data modeled into a star schema required for reporting and analytics.

---
## 📖 Project Overview
This project involves: 
1. **Data Architecture**: Designing a Modern Data Warehouse using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, Transforming and Loading Data from source systems into the warehouse using SSIS.
3. **Data Modelling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

🎯 This repository showcase my expertise in: 
- SQL Development
- Data Architecture
- Data Engineering
- ETL Pipeline Development
- Data Modeling
- Data Analytics

---
## 🚀 Project Requirements

### Design and Deployment of a Fashion Retail Data Warehouse

#### Objective
Build a robust and scalable data warehouse solution using SQL Server and SSIS to consolidate fashion retail sales data from multiple sources, ensuring data accuracy and performance optimization, while empowering business users with actionable insights for inventory control, sales analysis, and strategic decision-making.

#### Specifications
- **Data Sources**: Import data from source system provided as CSV files.
- **Data Quality**: Cleanse and resolve data 	quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation on the data model to support both business stakeholders and analytics teams.

---
### BI: Analytics & Reporting (Data Analysis)

#### Objective
Develop SQL-based analytics to deliver detailed insight into:
- **Geographic Sales Comparison**
- **Analyze Staffing and Performance**
- **Customer Behavior and Segmentation**
- **Product Trends**
- **Pricing and Discount Analysis**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.


## 📂 Repository Structure
```
Design-and-Deployment-of-a-Fashion-Retail-Data-Warehouse/
│
├── datasets/                           # Raw datasets used for the project (ERP, HR, CRM and POS data)
│
├── docs/                               # Project documentation and architecture details
│   ├── etl.drawio                      # Draw.io file shows all different techniquies and methods of ETL
│   ├── data_architecture.png           # Shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io file for the data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
└── requirements.txt                    # Dependencies and requirements for the project
```
---





















