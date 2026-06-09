
SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

select *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


SELECT *,
row_number() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


WITH duplicate_cte AS
(
SELECT *,
row_number() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,
`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
select*
from duplicate_cte
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
FROM layoffs_staging2
where row_num >1;


insert into layoffs_staging2
SELECT *,
row_number() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,
`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;


delete
FROM layoffs_staging2
where row_num >1;


SELECT *
FROM layoffs_staging2
where company = 'Airbnb';


-- Standardizing Data

SELECT company, trim(company)
FROM layoffs_staging2;

update layoffs_staging2
set company= TRIM(company);


select *
from layoffs_staging2
where industry like "Crypto%";


SELECT distinct industry
FROM layoffs_staging2;


update layoffs_staging2  
set industry = "Crypto"
where industry like "Crypto%";


SELECT distinct country, trim(trailing '.' from country) 
FROM layoffs_staging2
order by 1;


update layoffs_staging2
set country = trim(trailing '.' from country) 
where country like 'United States%';


select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;


update layoffs_staging2
set `date`= str_to_date(`date`, '%m/%d/%Y');


select `date`
from layoffs_staging2;


alter table layoffs_staging2
modify column `date` date;

select *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


update layoffs_staging2
set industry = null
where industry ='';


select *
FROM layoffs_staging2
where industry IS NULL
OR industry = '';


select *
FROM layoffs_staging2
where company like 'Airbnb';


select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
    on t1.company = t2.company
    and t1.location = t2.location
where t1.industry is null 
and t2.industry is not null;


update layoffs_staging2 t1
join layoffs_staging2 t2
    on t1.company = t2.company
set t1.industry=t2.industry
where t1.industry is null 
and t2.industry is not null;


select*
from layoffs_staging2;


select *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


delete
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


select *
FROM layoffs_staging2;


ALTER table layoffs_staging2
DROP COLUMN row_num;








