/* =====================================================
   DATA CLEANING & EXPLORATORY DATA ANALYSIS OF IPL

   Skills Demonstrated:
   ✔ Data Import
   ✔ Data Cleaning
   ✔ Duplicate Removal
   ✔ Data Standardization
   ✔ Missing Value Handling
   ✔ Data Type Conversion
   ✔ Business Logic Validation
   ✔ Exploratory Data Analysis
   ✔ CTEs
   ✔ Window Functions
   ✔ Ranking Functions

===================================================== */
select *
from deliveries;

select *
from matches;

# Cleaning a matches table first
# first needs to duplicate the table
CREATE TABLE `matches_staging` (
  `id` int DEFAULT NULL,
  `season` text,
  `city` text,
  `date` text,
  `match_type` text,
  `player_of_match` text,
  `venue` text,
  `team1` text,
  `team2` text,
  `toss_winner` text,
  `toss_decision` text,
  `winner` text,
  `result` text,
  `result_margin` int DEFAULT NULL,
  `target_runs` int DEFAULT NULL,
  `target_overs` int DEFAULT NULL,
  `super_over` text,
  `method` text,
  `umpire1` text,
  `umpire2` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# insert data from matches table to matches_staging column
insert into matches_staging
select *
from matches;

#Remove Duplicates-->
with cte as(
select *,
row_number() over(partition by id, season, city, `date`,
 match_type, player_of_match, venue, team1, team2, toss_winner, 
 toss_decision, winner, result, result_margin, target_runs, 
 target_overs, super_over, method, umpire1, umpire2) row_num
from matches_staging)
select *
from cte
where row_num>1;  #there is no duplicate data is there

# Check Data Types
describe matches_staging;

# standardizing the data--->


select distinct season
from matches_staging;

select *
from matches_staging
where season= "2020/21";

update matches_staging
set season="2020"
where season="2020/21";

# now the all seasons are in int format
alter table matches_staging
modify column season int;

# lets cross verify the datatypes
describe matches_staging;

select *
from matches_staging;

#city 
update matches_staging
set city=trim(city);
select distinct city
from matches_staging
order by 1;

update matches_staging
set city="Bengaluru"
where city="Bangalore" or city="Bengaluru";

select  distinct city,season, `date`,venue
from matches_staging
where city="Mumbai" or city="Navi Mumbai"
order by 1;  #this conclude that mumbai and navi mumbai both are same

update matches_staging
set city="Navi Mumbai"
where city="Mumbai" or city="Navi Mumbai";

select distinct city
from matches_staging
order by 1;

select distinct city, venue
from matches_staging
order by 2;

# here the NA city is Dubai because the both stadium as the same name
update matches_staging
set city = "Dubai"
where venue="Dubai International Cricket Stadium";

# here the NA city is Dubai because the both stadium as the same name
update matches_staging
set city = "Sharjah"
where venue="Sharjah Cricket Stadium";

select distinct city
from matches_staging
order by 1;

#date-->
# changing the date datatype
alter table matches_staging
modify column `date` date;

select distinct `date`
from matches_staging
order by 1;

#match_type--->
select  match_type,(`date`)
from matches_staging
where year(`date`)=2011
order by 1;
select  match_type,(`date`)
from matches_staging
where year(`date`)=2024
order by 1;
# both eliminator and elimination final both are same lets merge them
update matches_staging
set match_type="Eliminator"
where match_type like "Elimina%";

select distinct match_type
from matches_staging
order by 1;

select distinct match_type, `date`
from matches_staging
where year(`date`)=2010
order by 2;
select distinct match_type
from matches_staging
order by 1;
select match_type, `date`
from matches_staging;

update matches_staging
set match_type="Qualifier 1"
where `date`="2008-05-30";

update matches_staging
set match_type="Qualifier 2"
where `date`="2008-05-31";

update matches_staging
set match_type="Qualifier 1"
where `date`="2009-05-22";

update matches_staging
set match_type="Qualifier 2"
where `date`="2009-05-23";

update matches_staging
set match_type="Qualifier 1"
where `date`="2010-04-21";

update matches_staging
set match_type="Eliminator"
where `date`="2010-04-22";

update matches_staging
set match_type="Qualifier 2"
where `date`="2010-04-24";


select `date`, match_type
from matches_staging;

select distinct match_type
from matches_staging;  #Now the match_type is cleaned now 

# player_of_match--->
select distinct player_of_match
from matches_staging
order by 1;
# player of the match is clean

# venue---->
select distinct venue
from matches_staging
order by 1;

update matches_staging
set venue="Arun Jaitley Stadium, Delhi"
where venue like "%Arun Jaitley%";

update matches_staging
set venue="Brabourne Stadium, Mumbai"
where venue like "%Brabourne Stadium%";

update matches_staging
set venue="Dr DY Patil Sports Academy, Mumbai"
where venue like "%Dr DY Patil Sports%";

update matches_staging
set venue="Dr. Y.S. Rajasekhara Reddy ACA-VDCA Cricket Stadium, Visakhapatnam"
where venue like "%Dr. Y.S. Rajasekhara Reddy ACA-VDCA Cricket Stadium%";

update matches_staging
set venue="Eden Gardens, Kolkata"
where venue like "%Eden Gardens%";

update matches_staging
set venue="Himachal Pradesh Cricket Association Stadium, Dharamsala"
where venue like "%Himachal Pradesh Cricket Association Stadium%";

update matches_staging
set venue="M Chinnaswamy Stadium, Bengaluru"
where venue like "%Chinnaswamy Stadium%";

update matches_staging
set venue="MA Chidambaram Stadium, Chepauk, Chennai"
where venue like "%Chidambaram Stadium%";

update matches_staging
set venue="Maharashtra Cricket Association Stadium, Pune"
where venue like "%Maharashtra Cricket Association Stadium%";

update matches_staging
set venue="Punjab Cricket Association IS Bindra Stadium, Mohali, Chandigarh"
where venue like "%Punjab Cricket Association%";

update matches_staging
set venue="Rajiv Gandhi International Stadium, Uppal, Hyderabad"
where venue like "%Rajiv Gandhi International%";

update matches_staging
set venue="Sawai Mansingh Stadium, Jaipur"
where venue like "%Sawai Mansingh Stadium%";

update matches_staging
set venue="Wankhede Stadium, Mumbai"
where venue like "%Wankhede Stadium%";


select distinct venue
from matches_staging
order by 1; #now the venue is clean now


#team 1--->
select distinct team1
from matches_staging
order by 1;

update matches_staging
set team1="Delhi Capitals"
where team1 like "%Delhi%";

update matches_staging
set team1="Punjab Kings"
where team1 like "%Punjab%";

update matches_staging
set team1="Rising Pune Supergiants"
where team1 like "%Rising Pune%";

update matches_staging
set team1="Royal Challengers Bengaluru"
where team1 like "%Royal Challengers%";

# team2 ---.
select distinct team2
from matches_staging
order by 1;

update matches_staging
set team2="Delhi Capitals"
where team2 like "%Delhi Daredevils%";

update matches_staging
set team2="Punjab Kings"
where team2 like "%Punjab%";

update matches_staging
set team2="Rising Pune Supergiants"
where team2 like "%Rising Pune%";

update matches_staging
set team2="Royal Challengers Bengaluru"
where team2 like "%Royal Challengers%";

# toss_winner--->
select distinct toss_winner
from matches_staging
order by 1;

update matches_staging
set toss_winner="Delhi Capitals"
where toss_winner like "%Delhi Daredevils%";

update matches_staging
set toss_winner="Punjab Kings"
where toss_winner like "%Punjab%";

update matches_staging
set toss_winner="Rising Pune Supergiants"
where toss_winner like "%Rising Pune%";

update matches_staging
set toss_winner="Royal Challengers Bengaluru"
where toss_winner like "%Royal Challengers%";

select distinct toss_decision
from matches_staging
order by 1;  #this is cleaned


select distinct winner
from matches_staging
order by 1;


update matches_staging
set winner="Delhi Capitals"
where winner like "%Delhi Daredevils%";

update matches_staging
set winner="Punjab Kings"
where winner like "%Punjab%";

update matches_staging
set winner="Rising Pune Supergiants"
where winner like "%Rising Pune%";

update matches_staging
set winner="Royal Challengers Bengaluru"
where winner like "%Royal Challengers%";


select distinct result
from matches_staging
order by 1;

select distinct result_margin
from matches_staging
order by 1;

select distinct target_overs
from matches_staging
order by 1;

select distinct target_overs
from matches_staging
order by 1;

select distinct super_over
from matches_staging
order by 1;

select distinct method
from matches_staging
order by 1;

select distinct umpire1
from matches_staging
order by 1;

select distinct umpire2
from matches_staging
order by 1;



select *
from matches_staging;

#This Dataset is cleaned and ready for EDA  `👍👍👍👍👍👍👍👆`

-- ----------------------------------------------------------------------------------------------------------------------
select *
from deliveries;












