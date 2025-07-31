# 🐘 Hive Big Data Project

## 📌 Problem Statement

As a project team member, I want to understand the **design, features, and usage** of the Hive Big Data project through this README so that I can easily review the architecture, objectives, and key deliverables.

## 👨‍💻 Proposed Work

This project aims to explore Hive as a data warehouse solution on top of Hadoop. By simulating large-scale analytical queries, we evaluate how to optimize data processing using:
- External tables
- OpenCSVSerde for correct parsing
- Hive partitions for query pruning
- Columnar formats (Parquet) for performance

Through this, we learned how to build scalable, efficient data pipelines using HiveQL on a real Hadoop cluster.

---

## 🧭 Table of Contents
- [Introduction](#introduction)
- [Hadoop Cluster](#hadoop-cluster)
- [Hive Project](#hive-project)
- [Improvements](#improvements)
- [Success Criteria](#✅success-criteria)

---

## 🧩 Introduction

This project is part of our Big Data training program at Jarvis. We learned to work with distributed computing tools and Hive as a data warehouse engine on top of HDFS. 

### Goals:
- Understand Hadoop ecosystem and data storage layers
- Perform data ingestion and transformation in Hive
- Optimize queries for real-world performance
- Use Zeppelin notebooks for exploratory HiveQL

We used the **World Development Indicators (WDI)** dataset stored in Google Cloud Storage (GCS), which we processed and exported into HDFS.

---

## 🏗️ Hadoop Cluster

### 🖥️ Cluster Architecture


- **1 Master Node**
  - Hosts: HiveServer2, Hive Metastore, Zeppelin, YARN RM
- **2 Worker Nodes**
  - Hosts: HDFS Datanodes, YARN NodeManagers

### 🧰 Tools Used

- **HDFS** – Distributed file storage system
- **YARN** – Resource manager for Hadoop jobs
- **Hive** – SQL-like engine for batch querying
- **Zeppelin** – Interactive notebook for Hive/Spark
- **OpenCSVSerde** – Used for proper CSV parsing

### 🧮 Hardware Specs

- CPU: 2 cores (per node)
- RAM: 4 GB (per node)
- Storage: ~10 GB available per node

---

## 🐝 Hive Project

We performed the following:

### ✅ Data Pipeline
- Load raw CSV from GCS to Hive external table
- Identify parsing issues due to commas in quoted strings
- Recreate tables using `OpenCSVSerde` to fix parsing
- Export data from GCS to HDFS using `INSERT OVERWRITE`

### ✅ Optimization Techniques

| Optimization       | Purpose                                      |
|--------------------|----------------------------------------------|
| OpenCSVSerde       | Correctly parse complex CSV lines            |
| Partition by Year  | Reduce scan time for year-specific queries   |
| Parquet Format     | Improve performance using columnar storage   |

### 🧪 Example Queries

- Canada’s 2015 GDP Growth
- Top GDP growth by country
- Compare performance between:
  - Raw CSV
  - Partitioned data
  - Parquet tables
  - Hive vs Bash vs SparkSQL

### 📸 Zeppelin Screenshot



## 🔧 Improvements

1. **Add Data Validation Pipeline** – Check for nulls, type mismatches during ingestion.
2. **Implement Compression** – Use Snappy compression with Parquet for smaller storage.
3. **Incremental Data Load** – Automate daily ingestion instead of full reloads.
4. **Join Analysis** – Include additional datasets (e.g., Population or CO₂) for richer queries.

---

## ✅ Success Criteria

| Goal                                | Achieved |
|-------------------------------------|----------|
| Hive table creation and ingestion   | ✅       |
| Proper parsing with OpenCSVSerde    | ✅       |
| Partitioned queries by year         | ✅       |
| Use of Parquet format for queries   | ✅       |
| Zeppelin notebook with clean output | ✅       |
| Performance comparisons             | ✅       |
