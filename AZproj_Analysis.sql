select 
	*
from crm.joint;

--ANALYSIS ON THE TABLE
--QUESTION 1: IDENTIFY TOP TEN RATED CUSTOMER BASED ON TOTAL SALES AND TOTAL QTY
select 
	cst_firstname,
	cst_lastname,
	sum(sls_price) as total_revenue
from crm.joint
group by 1,2
order by total_revenue desc
limit 10;

select 
	cst_firstname,
	cst_lastname,
	sum(sls_quantity) as total_qty_ordered
from crm.joint
group by 1,2
order by total_qty_ordered desc
limit 10;

--QUESTION 2: FIND THE SALES REGIONS THAT GENERATE TOP TEN RATED CUSTOMERS
select 
	country,
	sum(sls_price) as total_revenue
from crm.joint
group by 1
order by total_revenue desc;

--QUESTION 3: IDENTIFY THE TOP SELLING PRODUCTS BASED ON TOTAL SALES AND TOTAL QTY
select 
	prd_nm,
	sum(sls_price) as total_revenue,
	sum(sls_quantity) as total_qty_ordered
from crm.joint
group by 1
order by total_revenue desc
limit 20;

--QUESTION 4: FIND THE OVERALL BEST PRODUCT CATEGORY
select
	prod_cat,
	sum(sls_price) as total_revenue
from crm.joint
group by 1
order by total_revenue desc
limit 1;

--QUESTION 5: CALCULATE THE YEAR ON YEAR GROWTH TO MEASURE THE INCREASE AND DECREASE IN SALES PROFIT ACROSS DIFFERENT YEAR
with a as ( 
	select 
date_part('year',sls_order_dt) as year,
sum(sls_price) as total_revenue
from crm.joint
group by year
order by total_revenue
)
select
	year,
	total_revenue,
	lag(total_revenue) over  () as last_year_revenue,
	total_revenue - lag(total_revenue) over () as Year_revenue_growth
from a;
	

