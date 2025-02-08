# Walmart Data Analysis: End-to-End SQL + Python Project P-9

## Project Overview
This project is an end-to-end data analysis solution designed to extract critical business insights from Walmart sales data. We utilize **Python** for data processing and analysis, **SQL** for advanced querying, and structured problem-solving techniques to solve key business questions. This project is ideal for data analysts looking to develop skills in **data manipulation, SQL querying, and data pipeline creation**.

## Project Pipeline
### 1. Set Up the Environment
- **Tools Used:** Visual Studio Code (VS Code), Python, SQL (MySQL and PostgreSQL)
- **Goal:** Create a structured workspace within VS Code and organize project folders for smooth development and data handling.

### 2. Set Up Kaggle API
- **API Setup:** Obtain your Kaggle API token from Kaggle by navigating to your profile settings and downloading the JSON file.
- **Configure Kaggle:**
  ```bash
  mkdir ~/.kaggle
  mv kaggle.json ~/.kaggle/
  chmod 600 ~/.kaggle/kaggle.json
  ```
- **Download Dataset:** Use the command to pull datasets directly into your project:
  ```bash
  kaggle datasets download -d <dataset-path>
  ```

### 3. Download Walmart Sales Data
- **Data Source:** Use the Kaggle API to download the Walmart sales datasets.
- **Dataset Link:** [Walmart Sales Dataset](https://www.kaggle.com/)
- **Storage:** Save the data in the `data/` folder for easy reference and access.

### 4. Install Required Libraries and Load Data
- **Install Libraries:**
  ```bash
  pip install pandas numpy sqlalchemy mysql-connector-python psycopg2
  ```
- **Load Data:** Read the dataset into a Pandas DataFrame for initial analysis and transformations.

### 5. Explore the Data
- **Goal:** Conduct an initial data exploration to understand data distribution, check column names, types, and identify potential issues.
- **Analysis Tools:**
  ```python
  df.info()
  df.describe()
  df.head()
  ```

### 6. Data Cleaning
- **Remove Duplicates:** Identify and remove duplicate entries.
- **Handle Missing Values:** Drop or fill missing values where necessary.
- **Fix Data Types:** Ensure all columns have appropriate data types (e.g., dates as `datetime`, prices as `float`).
- **Format Currency Values:** Convert price columns to numerical format using:
  ```python
  df['unit_price'] = df['unit_price'].str.replace('$', '').astype(float)
  ```
- **Validation:** Check for inconsistencies and verify the cleaned data.

### 7. Feature Engineering
- **Create New Columns:** Compute total transaction amounts using:
  ```python
  df['total_amount'] = df['unit_price'] * df['quantity']
  ```

### 8. Load Data into MySQL and PostgreSQL
- **Set Up Database Connections:** Connect to MySQL and PostgreSQL using SQLAlchemy.
- **Create Tables and Insert Data:**
  ```python
  from sqlalchemy import create_engine
  engine = create_engine("postgresql://user:password@localhost:5432/walmart_db")
  df.to_sql('walmart', engine, if_exists='replace', index=False)
  ```
- **Verification:** Run queries to confirm successful data loading.

### 9. SQL Analysis: Complex Queries and Business Problem Solving
#### Example Business Questions:
1. **Analyze Payment Methods and Sales**
   ```sql
   SELECT payment_method, COUNT(*) AS transaction_count, SUM(quantity) AS total_items_sold
   FROM walmart
   GROUP BY payment_method;
   ```

2. **Identify the Highest-Rated Category in Each Branch**
   ```sql
   WITH CategoryRatings AS (
       SELECT branch, category, AVG(rating) AS avg_rating,
              RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
       FROM walmart
       GROUP BY branch, category
   )
   SELECT branch, category, avg_rating FROM CategoryRatings WHERE rank = 1;
   ```

- **Documentation:** Maintain clear notes of each query's objective, approach, and results.

### 10. Project Publishing and Documentation
- **Documentation:** Keep detailed documentation in Markdown or a Jupyter Notebook.
- **Publishing:** Upload the project to GitHub, including:
  - `README.md` (this document)
  - Jupyter Notebooks (if applicable)
  - SQL scripts
  - Steps to access datasets

## Requirements
- **Python 3.8+**
- **SQL Databases:** MySQL, PostgreSQL
- **Python Libraries:** `pandas, numpy, sqlalchemy, mysql-connector-python, psycopg2`
- **Kaggle API Key** (for data downloading)

## Getting Started
1. Clone the repository:
   ```bash
   git clone <repo-url>
   ```
2. Install Python libraries:
   ```bash
   pip install -r requirements.txt
   ```
3. Set up your Kaggle API, download the data, and follow the steps to load and analyze.

## Project Structure
```
|-- data/                     # Raw and cleaned data files
|-- sql_queries/              # SQL scripts for analysis
|-- notebooks/                # Jupyter notebooks for Python analysis
|-- README.md                 # Project documentation
|-- requirements.txt          # List of required Python libraries
|-- main.py                   # Main script for data processing
```

## Results and Insights
- **Sales Insights:** Key categories, branches with the highest sales, and preferred payment methods.
- **Profitability Analysis:** Most profitable product categories and locations.
- **Customer Behavior:** Trends in ratings, payment preferences, and peak shopping hours.

## Future Enhancements
- **Integration with Power BI or Tableau** for interactive visualizations.
- **Adding more data sources** for deeper insights.
- **Automating the data pipeline** for real-time data ingestion and analysis.

## License
This project is licensed under the **MIT License**.

## Acknowledgments
- **Data Source:** [Kaggle’s Walmart Sales Dataset](https://www.kaggle.com/)
- **Inspiration:** Walmart’s business case studies on sales and supply chain optimization.

