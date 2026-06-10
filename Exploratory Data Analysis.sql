select *
from layoffs_staging2;


select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;


select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select min(`date`),max(`date`)
from layoffs_staging2;


select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;


select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;


select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;


select substring(`date`,1,7) as `Month`, sum(total_laid_off) Total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 ASC;


WITH Rolling_Total as
(
select substring(`date`,1,7) as `Month`, sum(total_laid_off) Total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 ASC
)
select `Month`, Total_off, 
Sum(Total_off) over(order by `Month`) As rolling_total
from Rolling_Total; 


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;


with Company_Year (Company, Years, Total_Laid_Off) AS
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
),
Company_Year_Rank as
(select *,
dense_rank() OVER(PARTITION BY Years order by Total_Laid_Off DESC) AS Ranking
from Company_Year
where Years is not null
)
select *
from Company_Year_Rank
where Ranking <= 5;











