# Data Analytics Portfolio

Welcome to my Data Analytics Portfolio! This repository contains projects where I explore, clean, transform, and analyze datasets using **SQL and Python**.

The goal of these projects is to demonstrate my practical understanding of data analytics, including data cleaning, exploratory data analysis (EDA), SQL queries, data manipulation, and visualization.

## 📂 Projects

### 1. COVID-19 Data Exploration (SQL)

**Tools:** Microsoft SQL Server, SQL

**Description:**

An exploratory analysis of COVID-19 data to investigate the spread of the virus, infection rates, mortality rates, and vaccination progress across different countries and continents.

**Key objectives:**
- Analyze total COVID-19 cases and deaths.
- Calculate death percentages by country.
- Compare COVID-19 cases against population size.
- Identify countries with the highest infection rates.
- Compare total death counts across countries and continents.
- Calculate global case and death statistics.
- Analyze vaccination progress using rolling totals.

**SQL techniques used:**
- `JOIN`
- `GROUP BY`
- Aggregate functions (`SUM`, `MAX`)
- Window functions (`PARTITION BY`, `ORDER BY`)
- Common Table Expressions (CTEs)
- Temporary tables
- Views
- Data type conversions

**What I learned:**

This project helped me practice working with multiple related datasets, calculating meaningful metrics, and using advanced SQL techniques to analyze data from a global perspective.

---

### 2. Nashville Housing Data Cleaning (SQL)

**Tools:** Microsoft SQL Server, SQL

**Description:**

A data-cleaning project focused on preparing Nashville housing data for further analysis. The dataset contains property sales information, addresses, land values, building values, and other housing-related attributes.

**Key objectives:**
- Standardize date formats.
- Populate missing property addresses using related records.
- Split addresses into separate columns.
- Standardize categorical values.
- Identify and remove duplicate records.
- Remove unnecessary columns.
- Examine property values and construction years.

**SQL techniques used:**
- `UPDATE`
- `ALTER TABLE`
- `JOIN`
- `ISNULL`
- `SUBSTRING`
- `PARSENAME`
- `CHARINDEX`
- `CASE` statements
- CTEs
- Window functions (`ROW_NUMBER`)
- Temporary data transformations

**What I learned:**

This project improved my ability to identify inconsistencies, handle missing values, standardize information, and prepare raw datasets for reliable analysis.

---

### 3. Movie Dataset Cleaning & Exploration (Python)

**Tools:** Python, Jupyter Notebook, Pandas, NumPy, Matplotlib, Seaborn

**Description:**

A data-cleaning and exploratory analysis project using a movie dataset containing approximately 7,668 records and 15 columns.

The dataset includes information such as movie titles, genres, release years, ratings, directors, budgets, gross revenue, and runtime.

**Key objectives:**
- Inspect the dataset and understand its structure.
- Identify and handle missing values.
- Convert columns into appropriate data types.
- Extract and standardize release-year information.
- Transform categorical columns into numerical representations.
- Explore relationships between numerical variables.
- Visualize correlations and relationships between movie budgets and gross revenue.

**Python techniques and libraries used:**
- Pandas for data manipulation and cleaning.
- NumPy for numerical operations.
- Matplotlib for data visualization.
- Seaborn for statistical visualization.
- Data type conversion.
- Missing-value handling.
- Correlation analysis.
- Scatter plots and heatmaps.

**What I learned:**

This project provided practical experience in cleaning real-world datasets with Python, preparing data for analysis, exploring relationships between variables, and communicating findings through visualizations.

---

## 🛠️ Technologies & Tools

| Category | Technologies |
|---|---|
| Programming Languages | SQL, Python |
| Database | Microsoft SQL Server |
| Python Environment | Jupyter Notebook |
| Data Manipulation | Pandas, NumPy |
| Data Visualization | Matplotlib, Seaborn |
| SQL Concepts | Joins, CTEs, Window Functions, Views, Temporary Tables |
| Data Analytics | Data Cleaning, EDA, Data Transformation, Correlation Analysis |

## 📁 Repository Structure

```text
Data-Analytics-Portfolio/
│
├── SQL/
│   ├── COVID-19-Data-Exploration.sql
│   └── Nashville-Housing-Data-Cleaning.sql
│
├── Python/
│   └── Movie-Dataset-Cleaning-and-Exploration.ipynb
│
└── README.md
```

## 🚀 Getting Started

### SQL Projects

1. Install Microsoft SQL Server and SQL Server Management Studio (SSMS).
2. Obtain the datasets required for each project.
3. Import the datasets into your SQL Server database.
4. Open the corresponding `.sql` file in SSMS.
5. Execute the queries to explore the data and reproduce the analysis.

### Python Project

1. Install Python.
2. Install the required libraries:

```bash
pip install pandas numpy matplotlib seaborn jupyter
```

3. Open the notebook:

```bash
jupyter notebook
```

4. Navigate to the Python project and run the notebook cells.

## 📚 Skills Demonstrated

Through these projects, I have practiced and developed skills in:

- Data cleaning and preprocessing
- Exploratory Data Analysis (EDA)
- SQL querying and data manipulation
- Relational database operations
- Handling missing and duplicate values
- Data transformation and standardization
- Statistical correlation analysis
- Data visualization
- Python-based data analysis

## 📌 About This Portfolio

This repository represents my ongoing journey in data analytics. Each project focuses on applying analytical concepts to datasets and developing practical skills in SQL and Python.

I plan to continue expanding this portfolio with more projects involving data analysis, visualization, and business intelligence.

---

**Thank you for visiting my portfolio!**
