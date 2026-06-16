-- exploratory data analysis for hotel booking dataset---->
select *
from hotel_staging2;

select distinct hotel
from hotel_staging2;  #there is only one type of hotel in the dataset

select count(*)
from hotel_staging2
where is_canceled>0;  #'7940' are cancelled

select count(is_canceled)
from hotel_staging2
where is_canceled=0; # '9772' are not cancelled

select count(is_canceled), arrival_date_year
from hotel_staging2
where is_canceled>0
group by arrival_date_year
order by count(is_canceled) desc; #year wise no.of cancellation in each year, 2016 has the highest cancelletion with the count of 3399

select count(is_canceled), arrival_date_year
from hotel_staging2
where is_canceled=0
group by arrival_date_year
order by count(is_canceled) desc; #year wise no.of not cancelled in each year, 2015 has the highest not cancelletion with the count of '5474'

# most confirmed booking in a month(excluding the cancelled bookings)
select arrival_date_month, count(is_canceled)
from hotel_staging2
where is_canceled=0
group by arrival_date_month
order by count(is_canceled) desc; #'October' is the maximum confirmed bookings with the count of ''1151''

select arrival_date_month, count(is_canceled)
from hotel_staging2
where is_canceled=0
group by arrival_date_month
order by count(is_canceled) desc
limit 5;  #top 5 months with the most confirmed bookings

# most cancelleation in a month
select arrival_date_month, count(is_canceled)
from hotel_staging2
where is_canceled>0
group by arrival_date_month
order by count(is_canceled) desc;	 #october has maximum cancellation is a month with '1151' counts,

# top5 months with most cancelleation in a month
select arrival_date_month, count(is_canceled)
from hotel_staging2
where is_canceled>0
group by arrival_date_month
order by count(is_canceled) desc
limit 5;

#weekend days booking and cancelleation-->
select is_canceled,sum(stays_in_weekend_nights) total_weekends
from hotel_staging2
where stays_in_weekend_nights>0 
group by is_canceled
order by total_weekends desc;  #confirmed booking with the weekend='11160' and canceled bookings with weekends='10308'
;

#week days booking and cancelleation-->
select is_canceled,sum(stays_in_week_nights) total_weekends
from hotel_staging2
where stays_in_week_nights>0 
group by is_canceled
order by total_weekends desc;  #confirmed booking with the week days=''28776'' and canceled bookings with week days=''28474''

select *
from hotel_staging2;

#most lead time in the hotel in the year
select sum(lead_time), arrival_date_year
from hotel_staging2
group by arrival_date_year
order by sum(lead_time) desc; #2016 has the maximum lead time in the year with lead time of 627674

#most lead time in the hotel in the year with excluding the cancelled bookings
select sum(lead_time), arrival_date_year
from hotel_staging2
where is_canceled=0
group by arrival_date_year
order by sum(lead_time) desc; #2015 has the maximum lead time in the year with lead time of ''346958''

#most lead time in the hotel in the month
select sum(lead_time), arrival_date_month
from hotel_staging2
group by arrival_date_month
order by sum(lead_time) desc;
#august has the most time lead in the month wiht 275526 lead time



#most lead time in the hotel in the month with excluding the canceled booking
select sum(lead_time), arrival_date_month
from hotel_staging2
where is_canceled=0
group by arrival_date_month
order by sum(lead_time) desc;
#'September' has the most time lead in the month wiht ''147186'' lead time


#most adults booking a hotel in a month
select arrival_date_month, sum(adults)
from hotel_staging2
where is_canceled=0
group by arrival_date_month
order by sum(adults) desc;  #adults are confirm book in the month of 'July' with sum of '2241' adults

select arrival_date_month, sum(adults)
from hotel_staging2
where is_canceled=0
group by arrival_date_month
order by sum(adults) asc;  #in january adults will book the hotel minimum with 493,, same thing can be done in year also 


# and also can do the weekend stays from adult,children and babies , and week days also, for learning same , i am not gonna do that
select *
from hotel_staging2;

select count(is_canceled), country
from hotel_staging2
where country is not null
group by country
order by count(is_canceled) desc
limit 10; #top 10 countries with most booking including cancelled and confirmed 


select count(is_canceled), country
from hotel_staging2
where country is not null
and is_canceled=0
group by country
order by count(is_canceled) desc;  # prt has the most confirmed bookings with 4401 bookings


select count(is_canceled), country
from hotel_staging2
where country is not null
and is_canceled=0
group by country
order by count(is_canceled) desc
limit 10;  # top 10 countries with confirm bookings

select count(is_canceled), country
from hotel_staging2
where country is not null
and is_canceled=1
group by country
order by count(is_canceled) desc
limit 10; #top 10 countries with most cancelled 


select count(is_canceled), country
from hotel_staging2
where country is not null
and is_canceled=1
group by country
order by count(is_canceled) desc
limit 1;  #prt has the maximum cancellation with '4881' cancells



# market segment
select distinct market_segment
from hotel_staging2
order by 1;

#let see which market segment is have a most cancellation
select market_segment, count(market_segment)
from hotel_staging2
where is_canceled>0
group by market_segment
order by 2 desc;  # Online TA has the most cancellation with 5619 cancellation


select market_segment, count(market_segment)
from hotel_staging2
where is_canceled=0
group by market_segment
order by 2 desc;  # Online TA has the most confirmed bookings  with 3318 bookings

select *
from hotel_staging2;



#which meal is got more orders
select meal, count(meal)
from hotel_staging2
group by meal
order by 2 desc;  #BB is the most ordered meal with 13983 orders



# top 5 meal with country wise most ordered meal 
select country, meal, count(meal)
from hotel_staging2
group by country, meal
order by count(meal) desc
limit 5;


#how many guests are booked again
select count(is_canceled) old_customers
from hotel_staging2
where is_canceled=0
and is_repeated_guest>0
order by 1 desc;    # 973 repeated customers are booked again



#customer cancellation with previous cancellation
select count(is_canceled)
from hotel_staging2
where is_canceled>0
and previous_cancellations>0  #319 are cancelled again and again 
;
#customer cancellation with previous not cancellation
select count(is_canceled)
from hotel_staging2
where is_canceled>0
and previous_bookings_not_canceled>0 ; # 54 customers canceled only this time



# which type costemer canceled again and again
select customer_type, count(is_canceled)
from hotel_staging2
where is_canceled>0
and previous_cancellations>0 
group by customer_type
order by 2 desc;  # tansient type customers canceled most with 249 cancellation


select country, customer_type, count(is_canceled)
from hotel_staging2
where country is not null
and  is_canceled>0
and previous_cancellations>0 
group by customer_type, country
order by 3 desc;  # tansient type and prt country customers canceled most with 224 cancellation

select *
from hotel_staging2; 


















