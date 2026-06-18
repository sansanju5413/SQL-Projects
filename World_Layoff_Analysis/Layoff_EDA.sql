# EXPLORATORY DATA ANALYSIS----->

SELECT *
from layoffs_staging2;

select max(percentage_laid_off), max(total_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc;

SELECT company, sum(total_laid_off), sum(funds_raised)
from layoffs_staging2
group by company 
order by sum(total_laid_off) desc, sum(funds_raised) ;

select min(`date`), max(`date`)
from layoffs_staging2;

select sum(total_laid_off)
from layoffs_staging2;

# within the 6 years totally 756836 employees are laid off 

select sum(total_laid_off)
from layoffs_staging2
where `date` between '2020-03-11'and '2023-06-30' # totally '400409' employes are laid of in this time period.
;

select industry, sum(total_laid_off)
from layoffs_staging2
group by  industry
order by sum(total_laid_off) desc
;

select sum(total_laid_off)
from layoffs_staging2
where company ="Amazon"
;

select *
from layoffs_staging2
where industry="Legal"  and company="CS Disco"
;
#country wise layoff
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

# date wise layoff
select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;

#year wise
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

# stage wise layoff
#year wise
select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

#percentage-->
select company, sum(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select month(`date`), sum(total_laid_off)
from layoffs_staging2
group by month(`date`)
order by 1 desc;

select substring(`date`, 6, 2) as `month`, sum(total_laid_off)
from layoffs_staging2
group by `month`
order by 1;
#both above 2 codes are same...

# but if we want both month and year 1st code is not works
select substring(`date`, 1, 7) as `month`, sum(total_laid_off)
from layoffs_staging2
group by `month`
order by 1 asc;

#rolling total
with cte as(
select substring(`date`, 1, 7) as `month`, sum(total_laid_off) sum_tot
from layoffs_staging2
group by `month`
order by 1 asc)
select `month`, sum_tot,
sum(sum_tot) over ( order by `month` asc) as rolling_total
from cte;

#year wise layoff from each company
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

# top 5 companies layoff in each year
With cte(company, `year`, total_laid_off) as (
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc),
company_ranking as(
select *,
dense_rank() over(partition by `year` order by total_laid_off desc) dense_ranks
from cte
where `year` is not null
)
select *
from company_ranking
where  dense_ranks <=5 ;

# average layoff per company
select company, avg(total_laid_off)
from layoffs_staging2
group by company
order by avg(total_laid_off)desc;

# top 5 average layoff per company 
select company, avg(total_laid_off)
from layoffs_staging2
group by company
order by avg(total_laid_off)desc
limit 5;

# top 5 industries layoffs in each year;
with cte(industry, years, sum_total) as
(
select industry, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by industry, year(`date`)
order by 3 desc),
total_lay as(
select *,
dense_rank() over(partition by years order by sum_total desc) ranking
from cte)
select *
from total_lay
where ranking<= 5;

# ranking on the country wise layoff with each year
with cte(country , years, total_layoff) as 
(
select country ,year(`date`), sum(total_laid_off)
from layoffs_staging2

group by country, year(`date`)
order by sum(total_laid_off) desc),
top_country as (
select *,
dense_rank() over(partition by years order by total_layoff desc) as ranking
from cte)
select *
from top_country
where ranking <= 5;


