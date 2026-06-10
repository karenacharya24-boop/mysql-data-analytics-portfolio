# Global Company Layoffs End-to-End Pipeline (MySQL)

## 📌 Project Overview
This project delivers a complete, end-to-end data pipeline on a global tech layoffs dataset using MySQL Workbench. The workflow is divided into two major phases: **Phase 1: Data Cleaning**, where raw, messy source data is systematically sanitized and standardized, and **Phase 2: Exploratory Data Analysis (EDA)**, where advanced SQL queries are executed to extract actionable business insights from the pristine data layer.

---

## 🛠️ Tech Stack & SQL Concepts Used
- **Database Engine:** MySQL Workbench
- **Data Pipeline Phase 1 (Cleaning):** Staging Tables (`LIKE`), Window Functions (`ROW_NUMBER()` & `PARTITION BY`), String Manipulation (`TRIM()`, `TRAILING`), Date Conversion (`STR_TO_DATE()`), and Missing Value Imputation via Multi-Table **Self-Joins**.
- **Data Pipeline Phase 2 (Analysis):** Aggregate Groupings (`GROUP BY`, `SUM`, `AVG`), Multi-Variable Order Tracing, Substrings, CTEs, and Chronological **Rolling Sum Window Functions** (`OVER(ORDER BY)`).

---

## 🗂️ Project Structure
- `layoffs.csv` - The original uncleaned data source.
- `Data Cleaning.sql` - Phase 1 script focused on data architecture sanitation.
- `Clean Data.csv` - The final pristine target table ready for visualization dashboards.
- `Exploratory Data Analysis.sql` - Phase 2 script focused on business trend extraction.

---

## 🧼 Project 1: Data Cleaning Workflow

1. **Staging Architecture:** Created a secondary staging environment (`layoffs_staging2`) to preserve raw data assets and safely test mutations.
2. **Duplicate Removal:** Implemented a Common Table Expression (CTE) using `ROW_NUMBER() OVER(PARTITION BY...)` across all columns to isolate and drop duplicate rows.
3. **Text Standardization:** Applied `TRIM()` to remove blank spaces, unified inconsistent names (like collapsing variants into a clean "Crypto" tag), and stripped trailing punctuation from location entries.
4. **Data Type Correction:** Converted string dates into proper database formats using `STR_TO_DATE()` and permanently altered the column schema to a native `DATE` type.
5. **Null Imputation:** Structured an inner **Self-Join** on matching company profiles to automatically identify and fill blank fields in the `industry` column.
6. **Data Purging:** Removed entirely uninformative rows containing double-null metrics and dropped helper columns to finalize the pristine table layer.

---

## 📈 Project 2: Exploratory Data Analysis (EDA)

With a completely sanitized database layer, I designed a series of high-impact queries to investigate global layoff behaviors, analyzing trends across companies, industries, timelines, and business funding structures:

1. **Volume Extremes:** Isolated the maximum single-day layoffs and targeted companies that shut down completely (100% layoffs) to benchmark the scale of industry events.
2. **Impact Groupings:** Aggregated total workforce reductions grouped by Company, Industry, Country, and Stage to discover exactly which market segments bore the largest losses.
3. **Chronological Spikes:** Extracted and grouped database timelines by months and calendar years to map exactly when job changes peaked globally.
4. **Multi-Year Rolling Totals:** Built a complex query using a CTE and a **Rolling Sum Window Function** to generate a continuous month-by-month cumulative timeline tracking global layoff speed over time.
5. **Top Corporate Redundancies:** Developed dense ranking logic to identify the top companies per individual year based on their aggregate employee cuts.
