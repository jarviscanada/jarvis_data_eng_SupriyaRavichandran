# 🛍️ Retail Data Analytics for LGS

## 📘 Introduction

LGS (Let's Get Shopping) is a retail business aiming to unlock the power of its historical transactional data. This project focuses on exploring that data to reveal insights into customer behavior, order trends, and key business metrics. The goal is to empower decision-makers with data-driven strategies that can improve customer retention, reduce cancellations, and ultimately boost revenue.

By identifying patterns in sales, user activity, and customer value through RFM segmentation, LGS can better understand who their customers are, when they buy, and how much they spend. These insights are crucial for refining marketing efforts, product placement, and operations.

> 🧰 **Technologies Used**  
> - Python  
> - Jupyter Notebook  
> - Pandas, NumPy, Matplotlib, Seaborn  
> - SQL (for validation and schema checks)  
> - Docker (for environment and notebook hosting)  
> - Git & GitHub (for version control)

---

## 🛠️ Implementation

### 📐 Project Architecture

This project follows a modular pipeline that integrates seamlessly with LGS's ecosystem. The architecture is divided into three main layers:

1. **Data Layer**: Source data comes from LGS’s data warehouse or operational databases.
2. **Processing Layer**: Performed in Jupyter using Python, where data is cleaned, transformed, and analyzed.
3. **Output Layer**: Insights and visuals are shared through reports or integrated into LGS dashboards.

#### 🗂️ Architecture Diagram

![Architecture Diagram](./assets/retail_architecture_diagram.png)  
*Diagram placeholder: Replace with your actual diagram image.*
+----------------+ +-----------------------+ +---------------------+
| Retail Database| ----> | Python Data Wrangling | ----> | Charts, Insights, |
| / Warehouse | | (Jupyter Notebook) | | and RFM Segments |
+----------------+ +-----------------------+ +---------------------+
|
v
+------------------+
| LGS Web Dashboard |
+------------------+

---

### 📊 Data Analytics & Wrangling

All data processing and analytics are performed in the following notebook:

🔗 [`./retail_data_analytics_wrangling.ipynb`](./retail_data_analytics_wrangling.ipynb)

#### ✅ Key Analytics Performed

- **Data Cleaning**: Handled missing `CustomerID`s, removed duplicates, and converted timestamps.
- **Sales KPIs**: Monthly total sales, % growth rate, and cancellation ratios.
- **Customer Behavior**:
  - Active users per month
  - New vs. existing users over time
- **RFM Analysis**: Scored customers on:
  - 🕒 **Recency** (last purchase date)
  - 🔁 **Frequency** (number of purchases)
  - 💸 **Monetary** (total spend)

> 📈 These metrics help LGS:
> - Launch targeted promotions for high-value segments.
> - Re-engage customers with low recency scores.
> - Reduce revenue loss from high cancellation rates.

#### 📷 Example Visualizations

- **Monthly Sales Growth**  
  ![Monthly Sales Growth](./assets/monthly_sales_growth.png)

- **New vs. Existing Users Chart**  
  ![User Segmentation](./assets/user_segmentation_chart.png)

- **RFM Distribution**  
  ![RFM Segments](./assets/rfm_segments.png)

---

## 🔧 Improvements

With more time, we would aim to:

1. **Deploy ETL Workflow**  
   Use Airflow or Prefect to automate data cleaning and transformation.

2. **Advanced Customer Segmentation**  
   Apply K-Means clustering or decision trees to refine targeting beyond RFM.

3. **Interactive Dashboard**  
   Build a dashboard using Streamlit or Power BI for real-time business insights.

---

> ✨ *This project serves as a foundational step for LGS to move from descriptive analytics to predictive and prescriptive analytics, turning data into a true business asset.*

