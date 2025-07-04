# Power BI Dashboards & Reports

This repository contains three comprehensive Power BI projects designed to showcase business intelligence skills through real-world datasets. The dashboards focus on three key domains:

1. **Beverages Sales Performance**
2. **Data Professionals Career Survey**
3. **Stock Market Analytics using Alpha Vantage API**

Each dashboard/report demonstrates a unique use case, incorporating data transformation, visualization, dynamic filtering, and real-time data integration. The README provides a detailed overview of the objective, dataset, features, limitations, and enhancement opportunities for each project.

---

## 📊 1. Beverages Dashboard

### 🔍 Overview
The Beverages Dashboard provides an interactive view of Coca-Cola’s sales and operational performance across different US states. It is built to support regional performance monitoring and financial tracking for business stakeholders.

### 🎯 Objectives
- Present sales distribution across US states using map visuals.
- Analyze operating profit over time.
- Display financial KPIs in a summarized format.
- Enable dynamic filtering by date.
- Provide executive-level insights for regional strategy and decision-making.

### 📁 Dataset Used
- **Source:** [Coca-Cola Sales.xlsx](https://prod-files-secure.s3.us-west-2.amazonaws.com/4bb008e8-7ec5-4576-a6da-d22513aa22fa/5ef29f35-9572-43e3-a243-057847d12a50/Coca-Cola_Sales.xlsx)
- **Contents:**
  - State-wise sales data
  - Operating profit
  - Financial metrics by year

### 🧩 Key Features
- **Map Visual**: Interactive US map to explore state-wise sales.
- **Time Series Charts**: Profit trends over time.
- **KPIs and Cards**: Quick insights on revenue, cost, and profit.
- **Slicer**: Filter by year/month to view time-specific data.
- **Custom Tooltips**: Show additional insights on hover.

### ⚠️ Constraints
- Data limited to Coca-Cola; lacks competitor benchmarking.
- Static dataset; no automatic data refresh or real-time updates.
- Geographical granularity is at the state level.

### 🚀 Future Improvements
- Integrate live data updates through APIs or data gateways.
- Add city-level or region-level granularity.
- Introduce benchmarking visuals (e.g., Coca-Cola vs Pepsi).
- Add forecasting for sales and profit trends using Power BI’s AI visuals.

---

## 📈 2. Data Professionals Survey Report

### 🔍 Overview
The Data Professionals Survey Report visualizes responses from a 2022 survey of 630 professionals working in the data industry. It focuses on demographics, job satisfaction, salaries, and career trajectories, helping HR and business leaders understand workforce trends.

### 🎯 Objectives
- Clean and transform survey data for analysis.
- Visualize distributions across key variables (job title, ethnicity, satisfaction).
- Support filtering and drill-down for detailed insights.
- Communicate workforce and DEI (Diversity, Equity, and Inclusion) metrics.

### 📁 Dataset Used
- **Source:** [Data Professionals Survey 2022.xlsx](https://prod-files-secure.s3.us-west-2.amazonaws.com/4bb008e8-7ec5-4576-a6da-d22513aa22fa/b927667c-6c89-4343-bea2-c11af180dc10/Data_Professionals_Survey_2022.xlsx)
- **Contents:**
  - Unique IDs
  - Job Titles
  - Ethnicity
  - Salary Ranges
  - Satisfaction Ratings
  - Country, Education Level

### 🧩 Key Features
- **Bar Charts & Donuts**: Job titles, ethnic groups, education levels.
- **Satisfaction Index**: Average rating visualized with gauge charts.
- **Multi-row Cards**: Key stats (average salary, most common title, etc.).
- **Slicers**: Filter by country, role, satisfaction level, or gender.
- **Cleaned Table View**: Null entries removed and data types assigned.

### ⚠️ Constraints
- One-time survey data; no trend analysis across years.
- Self-reported data; potential for bias or inconsistencies.
- No free-text responses included in visualization.

### 🚀 Future Improvements
- Incorporate longitudinal data from multiple years.
- Segment the report into HR-specific and executive summary views.
- Use natural language processing for open-ended responses (if available).
- Add region-based analysis and benchmarking by country/industry.
- Integrate external job market data (e.g., from Glassdoor or LinkedIn APIs).

---

## 📉 3. Stocks Dashboard using Alpha Vantage API

### 🔍 Overview
The Stocks Dashboard offers a dynamic, API-powered solution to monitor stock market performance for major public companies. It connects with the **Alpha Vantage API** to pull real-time and historical data, including daily stock prices, company fundamentals, and earnings estimates.

### 🎯 Objectives
- Load dynamic stock data using M queries.
- Visualize closing price trends and trading volume.
- Display key financial ratios and company information.
- Provide interactive tools for time range selection and ticker change.

### 🔌 APIs Used
- [Alpha Vantage TIME_SERIES_DAILY](https://www.alphavantage.co/documentation/#daily)
- [Alpha Vantage OVERVIEW](https://www.alphavantage.co/documentation/#company-overview)
- [Alpha Vantage EARNINGS](https://www.alphavantage.co/documentation/#earnings)

### 📁 Data Sources
- Daily stock prices (`Open`, `High`, `Low`, `Close`, `Volume`)
- Company Overview: Market Cap, PE Ratio, Dividend Yield, etc.
- Earnings Calendar: Analyst Estimates

### 🧩 Key Features
- **Dynamic Parameters**: Ticker and date range selection using slicers and query parameters.
- **Card Visuals**: Today's close, market cap, PE ratio, dividend yield.
- **Multi-row Cards**: 52-week high/low, analyst price target, forward PE.
- **Line and Column Charts**: Dual chart for price and volume.
- **Clustered Bar Chart**: Compare analyst earnings estimates for major stocks (AAPL, MSFT, META, GOOG, AMZN).
- **Date Range Slicer**: Choose between 1 month, 3 months, 6 months, 1 year, and 5 years using a custom DATATABLE and calculated StartDate logic.

### ⚠️ Constraints
- **API Call Limits**: 5 calls per minute / 500 per day (free tier).
- **API Downtime or Latency**: Can cause refresh failures or delays.
- **Ticker Specific**: Only one stock can be viewed at a time with current setup.
- **Real-time Limitations**: Updates depend on scheduled refresh or manual trigger.

### 🚀 Future Improvements
- Add ability to compare multiple tickers simultaneously.
- Implement local caching or incremental data loads to optimize refreshes.
- Integrate additional APIs for news, sentiment analysis, or insider trades.
- Create mobile-optimized layout for dashboard accessibility.
- Introduce alerting features based on thresholds (e.g., price drop > 5%).

---

## 📂 Branch Structure

Each dashboard/project has been developed in its own feature branch:

| Dashboard / Report         | Branch Name           |
|---------------------------|------------------------|
| Beverages Dashboard        | `beverage_dashboard`   |
| Data Professionals Report  | `data_report`          |
| Stocks Dashboard (API)     | `stocks_dashboard`     |

---

## 🛠️ Tools & Technologies

- **Power BI Desktop (June 2025)**  
- **DAX** for measures and KPIs  
- **Power Query (M language)** for data ingestion and API integration  
- **Alpha Vantage API** for real-time financial data  
- **Excel** as source format for static datasets  

---

## 📌 Summary

This repository showcases how Power BI can be used to:

- Integrate with external APIs for real-time insights  
- Clean and visualize survey and business data effectively  
- Build dashboards tailored for different stakeholder needs (executives, analysts, HR)  
- Enable dynamic interaction with slicers, parameters, and measures  

Each dashboard is functional, customizable, and designed for future extension. Your feedback and contributions are welcome!

---


