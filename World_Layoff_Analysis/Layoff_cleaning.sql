# Data Cleaning

select *
from layoffs;

-- 1. Remove duplicates
-- 2. standardize the data
-- 3. Null values or blank values
-- 4. Remove unwanted columns


-- 1. Remove duplicates---> means remove or delete the duplicate columns..
create table layoffs_staging	# this is used for data protect, incase loss of data.
like layoffs;			#it creates the column same as layoffs, 

select *
from layoffs_staging;

insert into layoffs_staging 
select *
from layoffs;

select *
from layoffs_staging;

-- 1. Remove duplicates
#first needs to remove the duplicates-->
with duplicate_cte as(
select *,
row_number() over(partition by company, location, total_laid_off, `date`, percentage_laid_off, industry,
 stage, funds_raised, country) as row_num
from layoffs_staging)
select *
from duplicate_cte
where row_num > 1;
# in the above case we cant able to delete a row where row_num > 1, becouse we need to do like below

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `stage` text,
  `funds_raised` int DEFAULT NULL,
  `country` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(partition by company, location, total_laid_off, `date`, percentage_laid_off, industry,
 stage, funds_raised, country) as row_num
from layoffs_staging;

delete 
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2
where row_num > 1;  # now the duplicate rows are deleted  🤣

select *
from layoffs_staging2;


-- 2. standardizing the data ---> finding issues in the data and fixing out. 
# check the every column is that data is cleaned like , no space, no extra data or no null
select company, trim(company)
from layoffs_staging2;
#there is lot of spacing in the company name(primary key) we need to correct this
update layoffs_staging2
set company= trim(company);


select distinct industry
from layoffs_staging2
order by 1;  #here we need to check whether the same company are there in the different type
# like crypto and cry-to, these needs to update like this-->my dataset is not have, if you have update like this--->
/*
update layoffs_staging2
set industry = "Real Estate"
where industry like "Real%";
*/
select distinct location
from layoffs_staging2
order by 1;

update layoffs_staging2
set location ='Malmo, Non-U.S.'
where location like 'Malm%';

select distinct location
from layoffs_staging2
order by 1;

select distinct country
from layoffs_staging2
order by 1;
# here we need to change country also becouse UAE and uniter arab emirates are same-->
update layoffs_staging2
set country = 'UAE'
WHERE country like 'United Arab Emirates%';

select distinct country
from layoffs_staging2
order by 1;

select *
from layoffs_staging2;


#date setting up
select `date`
from layoffs_netflix_stagingstaging2;

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;
# now update in the table also
update layoffs_staging2
set `date`= str_to_date(`date`, '%m/%d/%Y'); # date is updated correctly now

select *
from layoffs_staging2;

#if we need date column as date format--->
alter table layoffs_staging2
modify column `date` date;

select *
from layoffs_staging2;


select *
from layoffs_staging2
where industry =''
or industry is null;

select *
from layoffs_staging2
where company ='Appsmith' and location='SF Bay Area';
/* if when run the above is there any multiple row and in that one have the industry name and another doesnt
, then it needs to convert to the same industry name.
if the only one single is there it can be there as same, cant able to do anything

it is the code if the multiple column have the same company name and same location then we need to do this

update layoffs_staging2
*/
select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company and t1.location =t2.location
where (t1.industry is null or t1.industry ='')
and t2.industry is not null;

update layoffs_staging2
set industry= null
where industry='';

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
set t1.industry= t2.industry
where t1.industry is null 
and t2.industry is not null;

select *
from layoffs_staging2
where industry is null or industry='';


select *
from layoffs_staging2
where total_laid_off ='' or total_laid_off is null
and percentage_laid_off = '' or percentage_laid_off is null;



update layoffs_staging2
set total_laid_off=null
where total_laid_off='';

update layoffs_staging2
set percentage_laid_off=null
where percentage_laid_off='';

select * # these data are not needed 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null; # now deleted

select *
from layoffs_staging2; 

#after all of these just remove the row_num
alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2; 

























