/* =====================================================
   DATA CLEANING & EXPLORATORY DATA ANALYSIS
   HOTEL BOOKING DATASET
   =====================================================

   • Data Cleaning
   • Duplicate Removal
   • Data Standardization
   • Null Handling
   • Exploratory Data Analysis
   • CTEs
   • Window Functions
   • Ranking Functions

===================================================== */
select *
from amazon_sales;
CREATE TABLE `amazon_sales_staging` (
  `index` int DEFAULT NULL,
  `Order ID` text,
  `Date` date DEFAULT NULL,
  `Status` text,
  `Fulfilment` text,
  `Sales Channel` text,
  `ship-service-level` text,
  `Style` text,
  `SKU` text,
  `Category` text,
  `Size` text,
  `ASIN` text,
  `Courier Status` text,
  `Qty` int DEFAULT NULL,
  `currency` text,
  `Amount` text,
  `ship-city` text,
  `ship-state` text,
  `ship-postal-code` text,
  `ship-country` text,
  `promotion-ids` text,
  `B2B` text,
  `fulfilled-by` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from amazon_sales_staging;
insert into amazon_sales_staging
select *
from amazon_sales;

select *
from amazon_sales_staging;
# remove duplicates
select *,
row_number() over(partition by `index`, `Order ID`, `Date`, `Status`, `Fulfilment`, 
`Sales Channel`, `ship-service-level`, Style, SKU, Category, Size, `ASIN`, `Courier Status`, Qty, 
currency, Amount, `ship-city`, `ship-state`, `ship-postal-code`, `ship-country`, `promotion-ids`, B2B, `fulfilled-by`) as row_num
from amazon_sales_staging;

with cte as(
select *,
row_number() over(partition by `index`, `Order ID`, `Date`, `Status`, `Fulfilment`, 
`Sales Channel`, `ship-service-level`, Style, SKU, Category, Size, `ASIN`, `Courier Status`, Qty, 
currency, Amount, `ship-city`, `ship-state`, `ship-postal-code`, `ship-country`, `promotion-ids`, B2B, `fulfilled-by`) as row_num
from amazon_sales_staging)
select *
from cte
where row_num>1; # 0 rows returns , means there is no duplicate in the dataset , move on to standardization

# Data Standardization--->


select count(*)
from amazon_sales_staging
where `date` is null;   # there is no null in the date column


#status
select distinct `status`
from amazon_sales_staging
order by 1;  #there is no duplicate value in the amazon_sales


select distinct Fulfilment
from amazon_sales_staging
order by 1; #there is no duplicate


# sales channel
select distinct `sales channel`
from amazon_sales_staging
order by 1; #there is no duplicate

# ship service level
select distinct  `ship-service-level`
from amazon_sales_staging
order by 1; #there is no duplicate



# ship service level
select distinct Style
from amazon_sales_staging
order by 1; #there is no duplicate

select count(Style)
from amazon_sales_staging
where Style is null; 

#  SKU, 
select distinct SKU
from amazon_sales_staging
order by 1;

select count(SKU)
from amazon_sales_staging
where SKU is null; 

# Category, 
select distinct category
from amazon_sales_staging
order by 1;

select count(Category)
from amazon_sales_staging
where SKU is null; 


# Size,
select distinct size
from amazon_sales_staging
order by 1;

select count(size)
from amazon_sales_staging
where size is null; 

# ASIN,
select distinct `asin`
from amazon_sales_staging;

select count(`asin`)
from amazon_sales_staging
where `asin` is null; 


 #Courier Status, 
 select distinct `Courier Status`
from amazon_sales_staging;

 
# Qty,
select distinct qty
from amazon_sales_staging
order by 1;

 #currency, 
 select distinct currency
 from amazon_sales_staging
 order by 1;
 
 update amazon_sales_staging
 set currency=null
 where currency='';
 
 select count(*)
 from amazon_sales_staging
 where currency is null; # '7795' nulls
 
 
 update amazon_sales_staging
 set `ship-city`=trim(`ship-city`);
 
  update amazon_sales_staging
 set `ship-city`=trim(leading '(' from `ship-city`);

 
 update amazon_sales_staging
 set `ship-city`=null
 where `ship-city`='';

select *
from amazon_sales_staging;

#ship-city---------->
select distinct`ship-city`, `ship-state`, `ship-postal-code`
from amazon_sales_staging
order by 2;

update amazon_sales_staging
set `ship-city`="Kakinada"
where `ship-city` = "Kakimada" ;#or `ship-city` like 'Banaganapall%';

update amazon_sales_staging
set `ship-city`="Bangalore"
where `ship-city` like "banga%" and `ship-state`="Karnataka";

update amazon_sales_staging
set `ship-city`="Naidupet-Nellore District"
where `ship-city` like "Naidupeta%" ;

select *
from amazon_sales_staging;

select count(*)
from amazon_sales_staging
where `ship-city` is null;  # '33' nulls

select  distinct `ship-postal-code`
from amazon_sales_staging
order by 1;




select distinct  `ship-country`
from amazon_sales_staging
order by 1;
update amazon_sales_staging
set `ship-country`=null
where `ship-country`='';

select count(*)
from amazon_sales_staging
where `ship-country`is null; #33 nulls


 select distinct `promotion-ids`
 from amazon_sales
 order by 1;
 
 
 
 
 select distinct`B2B`
 from amazon_sales_staging
 order by 1;
 
 
select   `fulfilled-by`
from amazon_sales_staging
order by 1;

# first need to convert into null from this ' '-----> nul handling

update amazon_sales_staging
set `status`=null
where `status` ='';
# fulfilment
update amazon_sales_staging
set fulfilment=null
where fulfilment ='';

update amazon_sales_staging
set fulfilment=null
where fulfilment ='';


update amazon_sales_staging
set `ship-service-level`=null
where `ship-service-level` ='';


select count(*)
from amazon_sales_staging
where `status` is null; #0 nulls

select count(Fulfilment)
from amazon_sales_staging
where Fulfilment is null; #0 nulls



select count(`sales channel`)
from amazon_sales_staging
where `sales channel` is null; # 0 nulls


select count(`ship-service-level`)
from amazon_sales_staging
where `ship-service-level` is null; # 0 nulls



update amazon_sales_staging
set `courier status`=null
where `courier status`=''; 

 select `courier status`
 from amazon_sales_staging;
 
 
select count(*)
from amazon_sales_staging
where `Courier Status` is NULL; # '6872' nulls


 update amazon_sales_staging
 set currency=null
 where currency='';
 
 select count(*)
 from amazon_sales_staging
 where currency is null; # '7795' nulls
 
 select distinct `amount`
from amazon_sales_staging
order by 1;

update amazon_sales_staging
set `amount`=null
where `amount`='';

select count(*)
from amazon_sales_staging
where `ship-city` is null;  # '33' nulls

update amazon_sales_staging
set `ship-postal-code`= null
where `ship-postal-code`='';

select count(*)
from amazon_sales_staging
where `ship-postal-code` is null; #33 null

select count(*)
from amazon_sales_staging
where `ship-country`is null; #33 nulls

update amazon_sales_staging
 set `promotion-ids`=null
 where `promotion-ids`='';
 
 select count(*)
 from amazon_sales_staging
 where `promotion-ids`is null; # '49153' is null

UPDATE amazon_sales_staging
SET `fulfilled-by` = NULL
WHERE HEX(`fulfilled-by`) = '0D';

select count(*)
from amazon_sales_staging
where `fulfilled-by` is null; #'89698' nulls


select *
from amazon_sales_staging;

select `status`, `courier status`
from amazon_sales_staging; # there is a logic here, when the status is cancelled , in that order courier status is null, 

#changing to its own default before import
alter table amazon_sales_staging
modify column `date` date;

alter table amazon_sales_staging
modify column `amount` double DEFAULT NULL;

alter table amazon_sales_staging
modify column `ship-postal-code`double DEFAULT NULL;


# remove the unwanted column
alter table amazon_sales_staging
drop column  `index`;

alter table amazon_sales_staging
drop column  `promotion-ids`;

