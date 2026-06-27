

#no. of orders
select count(`order id`) total_orders
from amazon_sales_staging;  #128975 total orders

#date range of this data
select max(`date`) last_order_date, min(`date`) first_order_date
from amazon_sales_staging; #data is in b/w 4th jan 22 to 6th dec 22 mean almost 1year data , 

#inserted new column as order category
#total cancelled orders
select count(`order_category`) 
from amazon_sales_staging
where `order_category`="cancelled"; # total  18427 cancelled orders 

select count(order_category)
from amazon_sales_staging
where order_category="delivered" ; #total '28769' successfully delivered orders

select count(*)
from amazon_sales_staging
where `order_category`="Returned";  #2109 orders returned

select count(*)
from amazon_sales_staging
where `order_category`="Pending"; # 927 orders pending

select count(*)
from amazon_sales_staging
where `order_category`= "In transit"; #'78737' orders are in transit

select count(*)
from amazon_sales_staging
where `order_category`= "Failed Delivery"; #'6' failed deliveries

select distinct `Fulfilment`
from amazon_sales_staging;


# no.of order fulfilment from the amazon and merchant
select `Fulfilment`, count(`fulfilment`)
from amazon_sales_staging
group by `Fulfilment`; #orders from amazon='89698', and merchant='39277'

select order_category, count(order_category)
from amazon_sales_staging
where `Fulfilment`="amazon"
group by order_category; #in the amazon fulfilment 77729 orders are in transit, 11566 are cancelled and 403 are pending

select order_category, count(order_category)
from amazon_sales_staging
where `Fulfilment`="Merchant"
group by order_category; #in the merchant fulfilment 

#sales channel
select order_category, count(order_category)
from amazon_sales_staging
where `Sales Channel`="amazon.in"
group by order_category
order by 2 desc; #'28769' orders are delivered, 18426 orders are cancelled , 78614 orders are in Transit, 2109 orders are returned, 927 orders are pending and 6 orders or failed to delivery, through the amazon.in channel


select order_category, count(order_category)
from amazon_sales_staging
where `Sales Channel`="non-amazon"
group by order_category
order by 2 desc; #o orders delivered, returned, 123 in transit, and one is cancelled

#orders ship service level
select order_category , count(order_category)
from amazon_sales_staging
where `ship-service-level`="Standard"
group by order_category; #28769 orders delivered and 6909 cancelled , 2041 are in transit and 2109 are returned an 526 in pending

select order_category , count(order_category)
from amazon_sales_staging
where `ship-service-level`="Expedited"
group by order_category; #76696 orders are in transit, 11518 are cancelled and 401 are in pending


# category
select category , count(`Order ID`)
from amazon_sales_staging
group by category
order by 2 desc; #set category has the maximum orders with 50284 orders,
/* Set	50284---->maximum booking
Kurta	49877
Western Dress	15500
Top	10622
Ethnic Dress	1159
Blouse	926
Bottom	440
Saree	164
Dupatta	3---->minimum bookings
*/

#in the set cotegory can we check the categorystatus
select order_category, count(order_category)
from amazon_sales_staging
where Category="set"
group by order_category 
order by 2 desc; #31061 orders in transit, 10644 are delivered, 7378 are cancelled, 845 returned, 354 are pending and 2 orders are failed deliveries.

#what size of kurta are maximum ordered
select count(size), size
from amazon_sales_staging
where category ="Kurta"
group by size
order by 1 desc
limit 1;	# maximum orders for kurta in L size with 8920 orders

# in the kurta total delivered orders
select count(order_category), order_category
from amazon_sales_staging
where category ="Kurta" and order_category="delivered"
group by order_category
order by 1 desc;  #total '10451' kurta orders are delivered

#complete orders details of kurta orders
select count(order_category), order_category
from amazon_sales_staging
where category ="Kurta"
group by order_category;

#set order details
select count(order_category), order_category
from amazon_sales_staging
where category ="set"
group by order_category;

#western dress order details
select count(order_category), order_category
from amazon_sales_staging
where category ="Western Dress"
group by order_category;

#'Top' order details
select count(order_category), order_category
from amazon_sales_staging
where category ="Top"
group by order_category;

#'Ethnic Dress' order details
select count(order_category), order_category
from amazon_sales_staging
where category ="Ethnic Dress"
group by order_category;

#'Bottom' order details
select count(order_category), order_category
from amazon_sales_staging
where category ="Bottom"
group by order_category;

#'Saree' order details
select count(order_category), order_category
from amazon_sales_staging
where category ="Saree"
group by order_category;

#'Blouse' order details
select count(order_category), order_category
from amazon_sales_staging
where category ="Blouse"
group by order_category;

#'Dupatta' order details
select count(order_category), order_category
from amazon_sales_staging
where category ="Dupatta"
group by order_category;

# total quantity ordered for kurta
select category,sum(qty)
from amazon_sales_staging
where category ="Kurta"
group by category; #total 45045 kurtas ordered

# full detailed quantity of category
select category,sum(qty)
from amazon_sales_staging
group by category
order by 2 desc; # 116649 total qty


select count(order_category) 
from amazon_sales_staging
where qty=0; #12807 0 qty means they are cancelled before courier dispatch



#total revenue 
select sum(amount)
from amazon_sales_staging; # totally '78592678.30000007' rupees of revenue genrated

# revenue from each product
select Category, sum(amount)
from amazon_sales_staging
group by Category
order by 2 desc;

#maximum revenue generated from the category 
select Category, sum(amount)
from amazon_sales_staging
group by Category
order by 2 desc
limit 1; #Set	39204124.029999904

#maximum revenue generated from the category 
select Category, sum(amount)
from amazon_sales_staging
group by Category
order by 2 
limit 1; #Dupatta	915

#revenue genearated by month
select substr(`date`, 6,2) as 'month', sum(amount)
from amazon_sales_staging
group by substr(`date`, 6,2)
order by 2; 


select *
from amazon_sales_staging;





