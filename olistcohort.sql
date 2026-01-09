use olist_dump;

-- COHORT ANALYSIS --

create or replace view customer_cohorts as
select customer_unique_id,
min(date_format(o.order_purchase_timestamp, '%Y-%m')) as cohort_month
from customers c join orders o on c.customer_id = o.customer_id
where o.order_status = 'Delivered'
group by customer_unique_id;

select * from customer_cohorts;


create or replace view orders_with_month as
select o.customer_id, c.customer_unique_id, o.order_id,
date_format(o.order_purchase_timestamp, '%Y-%m') as order_month
from orders o join customers c on o.customer_id = c.customer_id
where o.order_status = 'Delivered';

select * from orders_with_month;



create or replace view cohort_analysis as
select cc.cohort_month, owm.order_month, owm.customer_unique_id,
timestampdiff(month, str_to_date(concat(cc.cohort_month, '-01'), '%Y-%m-%d'),
str_to_date(concat(owm.order_month, '-01'), '%Y-%m-%d')) as cohort_index
from customer_cohorts cc join orders_with_month owm 
on cc.customer_unique_id = owm.customer_unique_id;

select * from cohort_analysis;


-- Count active customers per cohort per month:

select cohort_month, cohort_index,
count(distinct customer_unique_id) as active_customers
from cohort_analysis
group by cohort_month, cohort_index
order by cohort_month, cohort_index;


-- calculate retention rate:

select cohort_month, cohort_index, count(distinct customer_unique_id) as active_customers,
round(count(distinct customer_unique_id)*100.0/
first_value(count(distinct customer_unique_id)) 
over( partition by cohort_month order by cohort_index),2) as retention_rate_pct
from cohort_analysis
group by cohort_month, cohort_index
order by cohort_month, cohort_index;

