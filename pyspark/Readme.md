# Data Analytics Project

## Introduction
A UK-based online retail company wants to turn raw transaction logs into decision-ready insights that drive revenue growth and retention. The current reporting is spreadsheet-driven, slow to refresh, and fragile for large files. This repository modernizes the workflow by implementing repeatable, scalable analytics pipelines on Databricks (Azure) and Zeppelin (Hadoop), producing KPIs such as Monthly Revenue, Orders (placed vs. cancelled), Sales Growth, MAU (Monthly Active Users), New vs. Existing Users, and RFM-based customer segmentation using Spark, Hive, Databricks, and Zeppelin.

---

## 1️⃣ WDI Data Analytics Using Zeppelin

### Overview

The WDI Data Analytics project analyzes World Development Indicators (WDI) dataset using **Zeppelin notebooks** on **Hadoop (GCP Dataproc)**. It provides insights into country-level indicators over time using Spark SQL and PySpark transformations.

### Dataset

* **Source**: `wdi_csv_parquet` Hive table (Parquet format, \~90MB)
* **Schema**:

  * `year` (INTEGER)
  * `countryName` (STRING)
  * `countryCode` (STRING)
  * `indicatorName` (STRING)
  * `indicatorCode` (STRING)
  * `indicatorValue` (FLOAT)

### Notebook

* Zeppelin notebook: [WDI Data Analytics Notebook](spark/notebook/Spark%20Dataframe%20-%20WDI%20Data%20Analytics.json) 

### Architecture

```
+------------------+        +-------------------+        +-------------------+
| Analyst/User     |  UI    |  Zeppelin         |  Jobs  |  Spark on YARN    |
| (PySpark/SQL)    +------->+  Notebooks        +------->+  (Executors)      |
+---------+--------+        +---------+---------+        +---------+---------+
          ^                            |                           |
          |                            v                           |
          |                   +------------------+                 |
          |                   |  Hive Metastore  |<----------------+
          |                   +---------+--------+
          |                             |
          |                             v
          |                   +------------------+
          +-------------------+   HDFS Storage   +--- Parquet/ORC (cleaned)
                              |  (Raw CSV)       |
                              +------------------+
```

### Steps

1. Download Zeppelin skeleton notebook.
2. Import notebook to Zeppelin on GCP.
3. Reuse existing `wdi_csv_parquet` Hive table or create a new table in HDFS + Hive.
4. Run analyses and visualize KPIs in Zeppelin.

---

## 2️⃣ Retail Data Analytics Using Databricks

### Overview

The Retail Data Analytics project analyzes online retail transactions to compute **KPIs**, **monthly trends**, **active users**, **new vs existing users**, and **RFM customer segmentation**. Implemented on **Databricks (Azure)** using PySpark and Spark SQL.

### Dataset

* **Source**: `pyspark/OnlineRetail.xlsx` (Excel, \~22.6MB)
* **Fields**: `InvoiceNo`, `StockCode`, `Description`, `Quantity`, `UnitPrice`, `CustomerID`, `InvoiceDate`, `Country`

### Notebook

* Databricks notebook: pyspark\Retail_Data_Analytics_Using_Databricks.ipynb

### Architecture

```
+-------------------+            +----------------------+            +-----------------+
|   Analyst/User    |  Notebooks |     Databricks       |  Tables    |  BI/Reporting   |
|  (SQL/PySpark)    +----------->+  Compute (Clusters)  +----------->+  (Power BI/SQL) |
+---------+---------+            +----------+-----------+            +--------+--------+
          ^                                   |                                 ^
          |                                   v                                 |
          |                         +--------------------+                      |
          |                         |   Spark (PySpark)  |                      |
          |                         +---------+----------+                      |
          |                                   |                                 |
          |                    Transform/SQL  v                                 |
          |                         +--------------------+                      |
          |      Upload            |  Hive Metastore    |  Delta (Gold/Silver)  |
          |   (Excel/CSV)          +---------+----------+          ^            |
          |                                   |                     |            |
          |                                   v                     |            |
          |                         +--------------------+          |            |
          +-------------------------+  DBFS / Azure Blob  +---------+------------+
                                    |   (Bronze layer)    |
                                    +---------------------+
```

### Steps

1. Upload Excel to DBFS and load with Pandas → Spark DataFrame.
2. Clean data: handle nulls, convert timestamps, compute `TotalPrice`.
3. Compute KPIs: monthly revenue, orders (placed vs cancelled), monthly sales growth, MAU, new vs existing users.
4. Perform RFM analysis and segment customers.
5. Visualize KPIs and RFM segments using Databricks `display()` or Matplotlib.
6. Optionally persist as Delta tables for reuse in dashboards.

---

## Future Improvements

1. Introduce **Data Quality Checks** using Great Expectations or Deequ.
2. Enable **Streaming / Near Real-Time Analytics**.
3. Integrate **Customer Lifetime Value (CLV) and churn predictions** with ML models.
4. Centralize governance with **Unity Catalog** and access controls.
5. Create interactive **BI dashboards** in Power BI or Databricks SQL for end-users.

