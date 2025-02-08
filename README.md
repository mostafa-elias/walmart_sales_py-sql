# Walmart Data Analysis: End-to-End SQL + Python Project 

## 📌 Project Overview
This project is an end-to-end data analysis solution designed to extract critical business insights from Walmart sales data. We utilize Python for data processing and analysis, SQL for advanced querying, and structured problem-solving techniques to solve key business questions. This project is ideal for data analysts looking to develop skills in data manipulation, SQL querying, and data pipeline creation.

## 📂 Project Pipeline
### 1️⃣ Set Up the Environment
**Tools Used:** Visual Studio Code (VS Code), Python, SQL (MySQL and PostgreSQL)
- Create a structured workspace within VS Code and organize project folders for smooth development and data handling.

### 2️⃣ Set Up Kaggle API
- Obtain your Kaggle API token from Kaggle profile settings.
- Configure Kaggle:
  ```sh
  mkdir ~/.kaggle
  mv kaggle.json ~/.kaggle/
  chmod 600 ~/.kaggle/kaggle.json
  ```
- Download dataset:
  ```sh
  kaggle datasets download -d <dataset-path>
  ```

### 3️⃣ Download Walmart Sales Data
- Use the Kaggle API to download the Walmart sales datasets.
- Store the data in the `data/` folder for easy reference and access.

### 4️⃣ Install Required Libraries and Load Data
```sh
pip install pandas numpy sqlalchemy mysql-connector-python psycopg2
```
- Load data into a Pandas DataFrame for analysis.

### 5️⃣ Data Exploration
- Understand data distribution, column names, types, and identify potential issues.
- Key methods:
  ```python
  df.info()
  df.describe()
  df.head()
  ```

### 6️⃣ Data Cleaning
- Remove duplicates, handle missing values, fix data types, and format currency values.
- Example:
  ```python
  df['unit_price'] = df['unit_price'].str.replace('$', '').astype(float)
  ```

### 7️⃣ Feature Engineering
- Compute total transaction amounts:
  ```python
  df['total_amount'] = df['unit_price'] * df['quantity']
  ```

### 8️⃣ Load Data into MySQL and PostgreSQL
- Connect to databases using SQLAlchemy.
- Create tables and insert data:
  ```python
  from sqlalchemy import create_engine
  engine = create_engine("postgresql://user:password@localhost:5432/walmart_db")
  df.to_sql('walmart', engine, if_exists='replace', index=False)
  ```

### 9️⃣ SQL Analysis: Complex Queries
- **Analyze Payment Methods and Sales:**
  ```sql
  SELECT payment_method, COUNT(*) AS transaction_count, SUM(quantity) AS total_items_sold
  FROM walmart
  GROUP BY payment_method;
  ```
- **Highest-Rated Category per Branch:**
  ```sql
  WITH CategoryRatings AS (
      SELECT branch, category, AVG(rating) AS avg_rating,
             RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
      FROM walmart
      GROUP BY branch, category
  )
  SELECT branch, category, avg_rating FROM CategoryRatings WHERE rank = 1;
  ```

### 🔥 Project Publishing & Documentation
- Keep detailed notes in Markdown or Jupyter Notebooks.
- Upload project files to GitHub:
  - `README.md` (this document)
  - Jupyter Notebooks
  - SQL scripts
  - Steps to access datasets

## 📌 Requirements
- Python 3.8+
- SQL Databases: MySQL, PostgreSQL
- Python Libraries: pandas, numpy, sqlalchemy, mysql-connector-python, psycopg2
- Kaggle API Key

## 🚀 Getting Started
```sh
git clone <repo-url>
pip install -r requirements.txt
```
- Set up Kaggle API, download the data, and follow the steps.

## 📂 Project Structure
```
|-- data/                     # Raw and cleaned data files
|-- sql_queries/              # SQL scripts for analysis
|-- notebooks/                # Jupyter notebooks for Python analysis
|-- README.md                 # Project documentation
|-- requirements.txt          # List of required Python libraries
|-- main.py                   # Main script for data processing
```

## 📊 Results and Insights
- **Sales Insights:** Key categories, branches with highest sales, preferred payment methods.
- **Profitability Analysis:** Most profitable product categories and locations.
- **Customer Behavior:** Trends in ratings, payment preferences, peak shopping hours.

## 🔮 Future Enhancements
- Integrate Power BI/Tableau for interactive visualizations.
- Automate data pipeline for real-time analysis.

## 📜 License
This project is licensed under the MIT License.

## 🎖️ Acknowledgments
- **Data Source:** Kaggle’s Walmart Sales Dataset
- **Inspiration:** Walmart’s business case studies on sales and supply chain optimization.
