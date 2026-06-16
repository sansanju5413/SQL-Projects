# Hotel Booking Analysis

## Project Overview

This project analyzes hotel booking data to identify booking trends, cancellation behavior, customer patterns, and business insights.

## Tools Used

* SQL (MySQL)
* Data Cleaning
* Exploratory Data Analysis (EDA)

## Dataset

The dataset contains hotel booking information including:

* Booking dates
* Customer details
* Reservation status
* Stay duration
* Market segment
* Cancellation information

## Project Workflow

1. Data Cleaning
2. Data Transformation
3. Exploratory Data Analysis
4. Business Insights

## Files

* Data_Cleaning.sql
* EDA.sql
* hotel_booking_raw.csv
* hotel_booking_cleaned.csv

## Key Skills Demonstrated

* Data Cleaning
* SQL Queries
* CTEs
* Window Functions
* Aggregations
* Business Analysis

## Key Insights

### Booking Status Analysis

* Total Confirmed Bookings: 9,772
* Total Cancelled Bookings: 7,940

### Year-wise Trends

* 2016 recorded the highest number of cancellations (3,399).
* 2015 recorded the highest number of confirmed bookings (5,474).

### Monthly Booking Trends

* October had the highest confirmed bookings (1,151).
* October also recorded the highest cancellations.

### Customer Stay Analysis

* Confirmed bookings accounted for:

  * 11,160 weekend nights
  * 28,776 weekday nights
* Customers preferred longer weekday stays compared to weekend stays.

### Lead Time Analysis

* 2016 had the highest overall lead time (627,674).
* August recorded the highest monthly lead time.
* September recorded the highest lead time among confirmed bookings.

### Customer Demographics

* July had the highest number of adult guests (2,241).
* January recorded the lowest adult guest bookings.

### Country Analysis

* Portugal (PRT) generated the highest number of confirmed bookings (4,401).
* Portugal also recorded the highest number of cancellations (4,881).

### Market Segment Analysis

* Online TA generated the highest confirmed bookings (3,318).
* Online TA also generated the highest cancellations (5,619).

### Meal Preference Analysis

* BB (Bed & Breakfast) was the most ordered meal plan with 13,983 orders.

### Customer Retention Analysis

* 973 repeated guests successfully booked again.
* 319 customers had a history of previous cancellations and cancelled again.
* Transient customers were the customer type with the highest repeated cancellations.

