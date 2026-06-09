# Company Layoffs Data Cleaning Project (MySQL)

## 📌 Project Overview
This project targets the end-to-end data preparation and sanitation of a messy, raw global tech layoffs dataset using MySQL Workbench. The pipeline handles data structural issues, text inconsistencies, misplaced null fields, incorrect data types, and redundant entries to provide a highly clean data layer ready for exploratory analysis.

## 🛠️ Tech Stack & SQL Concepts Used
- **Database Tool:** MySQL Workbench
- **Core Techniques:**
  - Database Staging Tables (`CREATE TABLE ... LIKE`)
  - Duplicate Excision via Window Functions (`ROW_NUMBER()` & `PARTITION BY`)
  - Target Text Stripping & Normalization (`TRIM()`, `TRAILING '.'`)
  - Date Schema Transformation (`STR_TO_DATE()` & `ALTER TABLE ... MODIFY`)
  - Cross-Record Missing Value Imputation via Multi-Table **Self-Joins**

## 🗂️ Project Structure
- `layoffs.csv` - The original uncleaned data source.
- `Data Cleaning.sql` - Fully documented MySQL workflow script.
- `Clean Data.csv` - The final pristine target table ready for visualization dashboards.

## 🧼 Step-by-Step Data Cleaning Workflow

### 1. Creating a Staging Architecture
To guard against raw data corruption, a secondary staging table structure was instantiated (`layoffs_staging`), which was later converted into a finalized staging table (`layoffs_staging2`) containing an evaluated row count row matrix.

### 2. Identifying and Removing Duplicates
- Wrote a Common Table Expression (CTE) utilizing `ROW_NUMBER() OVER(PARTITION BY...)` evaluating all unique attribute intersections to identify duplicate rows.
- Filtered structural layers where the tracking matrix index exceeded 1 and cleanly removed the target duplicates via `DELETE` statements.

### 3. Standardizing Inconsistent Text fields
- Cleaned leading and trailing blank whitespaces out of company fields via `TRIM()`.
- Used wildcard pattern matching (`LIKE 'Crypto%'`) to collapse multiple naming variants into a unified `"Crypto"` tag.
- Stripped trailing syntax errors from geographical entities (e.g., changing `"United States."` to `"United States"` using `TRIM(TRAILING '.' FROM country)`).

### 4. Correcting Structural Data Types
- Parsed string-based timeline dates into native database standard fields using `STR_TO_DATE(date, '%m/%d/%Y')`.
- Modified table schema definitions permanently by executing `ALTER TABLE ... MODIFY COLUMN date DATE`.

### 5. Populating Null Values via Self-Joins
- Located missing records inside the `industry` column.
- Wrote a cross-referential update statement using an inner **Self-Join** on matching `company` and `location` entries to fill blank data points with valid, adjacent record attributes.

### 6. Purging Irrelevant Data Row Architectures
- Removed obsolete, unusable rows where both `total_laid_off` and `percentage_laid_off` were completely null.
- Dropped the auxiliary `row_num` column using `ALTER TABLE ... DROP COLUMN` to keep the final output optimized.
