/* =====================================================
   DATA CLEANING & EXPLORATORY DATA ANALYSIS
   HOTEL BOOKING DATASET
   =====================================================

   Skills Demonstrated:
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
from hotel_bookings;

#Creating a duplicate table to protect from the loss of data in original dataset
create table hotel_staging
like hotel_bookings;
insert into hotel_staging
select *
from hotel_bookings;

#duplicate data
select *
from hotel_staging;
#removing the duplicate rows-->
with cte as(
select *,
row_number() over(partition by hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children, babies, meal, country, market_segment, distribution_channel, is_repeated_guest, previous_cancellations, previous_bookings_not_canceled, reserved_room_type, assigned_room_type, booking_changes, deposit_type, agent, company, days_in_waiting_list, customer_type, 
adr, required_car_parking_spaces, total_of_special_requests, reservation_status, reservation_status_date) as row_num
from hotel_staging)
select *
from cte
where row_num>1;

# creating a dataset by removing the duplicate data
CREATE TABLE `hotel_staging2` (
  `hotel` text,
  `is_canceled` int DEFAULT NULL,
  `lead_time` int DEFAULT NULL,
  `arrival_date_year` int DEFAULT NULL,
  `arrival_date_month` text,
  `arrival_date_week_number` int DEFAULT NULL,
  `arrival_date_day_of_month` int DEFAULT NULL,
  `stays_in_weekend_nights` int DEFAULT NULL,
  `stays_in_week_nights` int DEFAULT NULL,
  `adults` int DEFAULT NULL,
  `children` int DEFAULT NULL,
  `babies` int DEFAULT NULL,
  `meal` text,
  `country` text,
  `market_segment` text,
  `distribution_channel` text,
  `is_repeated_guest` int DEFAULT NULL,
  `previous_cancellations` int DEFAULT NULL,
  `previous_bookings_not_canceled` int DEFAULT NULL,
  `reserved_room_type` text,
  `assigned_room_type` text,
  `booking_changes` int DEFAULT NULL,
  `deposit_type` text,
  `agent` text,
  `company` text,
  `days_in_waiting_list` int DEFAULT NULL,
  `customer_type` text,
  `adr` int DEFAULT NULL,
  `required_car_parking_spaces` int DEFAULT NULL,
  `total_of_special_requests` int DEFAULT NULL,
  `reservation_status` text,
  `reservation_status_date` text,
  `row_num` int
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into hotel_staging2
select *,
row_number() over(partition by hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children, babies, meal, country, market_segment, distribution_channel, is_repeated_guest, previous_cancellations, previous_bookings_not_canceled, reserved_room_type, assigned_room_type, booking_changes, deposit_type, agent, company, days_in_waiting_list, customer_type, 
adr, required_car_parking_spaces, total_of_special_requests, reservation_status, reservation_status_date) as row_num
from hotel_staging
;
select *
from hotel_staging2; #now row num is inserted and now delete the duplicate values

# creating a dataset by removing the duplicate data
delete 
from hotel_staging2
where row_num > 1;

select *
from hotel_staging2
where row_num>1;  # empty now

select *
from hotel_staging2;

select distinct hotel
from hotel_staging2; #there is no fault in the hotel doesnt need trim or nothing

select distinct reservation_status # i checked all of these fields, in a one query , you need to check all fields to see is there any duplicate value is there
 # hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children, babies, meal, country, market_segment, distribution_channel, is_repeated_guest, previous_cancellations, previous_bookings_not_canceled, reserved_room_type, assigned_room_type, booking_changes, deposit_type, agent, company, days_in_waiting_list, customer_type, adr, required_car_parking_spaces, total_of_special_requests, reservation_status, reservation_status_date, row_num
from hotel_staging2
order by 1; 

# when i have a arrival date, month and year, then i dont want arrival_date_week_number
alter table hotel_staging2
drop column arrival_date_week_number;

select *
from hotel_staging2;

select is_repeated_guest
from hotel_staging2
where is_repeated_guest!=0;  #i just checked is there all zero or not , if all have 0 ill delete a complete column


select count(*) babies
from hotel_staging2
where babies!=0;

alter table  hotel_staging2
drop column row_num;

select *
from hotel_staging2;  # i think the data is clean , i think i want to merge the day, year and month but i dont want to change the existing data


SELECT COUNT(*)
FROM hotel_staging2
WHERE country IS NULL;

SELECT *
FROM hotel_staging2
WHERE adults = 0
AND children = 0
AND babies = 0;

delete 
from hotel_staging2
where adults=0
and children=0
and babies=0;

SELECT *
FROM hotel_staging2
WHERE adults = 0
AND children = 0
AND babies = 0;

SELECT COUNT(*)
FROM hotel_staging2
WHERE adults = 0
AND children = 0
AND babies = 0;



