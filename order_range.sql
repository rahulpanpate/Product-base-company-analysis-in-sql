use rahul_project;

select * from order_details_v1;

# find out customer and order in mtd--> customer mean unique id 

select order_date,count(distinct(customer_id))
from order_details_v1 
where order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") group by order_date ;




select order_date,count(customer_id)
from order_details_v1 
where order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") group by order_date ;



select order_date,count(distinct(customer_id)),count(order_id) 
from order_details_v1 
where order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d")
 group by order_date;
 
 
 

WITH OrderRangeMetrics AS (
    SELECT
        CASE 
            WHEN EXTRACT(DAY FROM order_date) <= 2 THEN '1-2'
            ELSE '3-5'
        END AS order_range,
        COUNT(DISTINCT customer_id) AS mtd_customer,
        COUNT(order_id) AS mtd_order,
        SUM(selling_price) AS mtd_gmv
    FROM order_details_v1
    WHERE EXTRACT(YEAR FROM order_date) = EXTRACT(YEAR FROM CURRENT_DATE)
      AND EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE)
    GROUP BY order_range
)
SELECT
    order_range,
    mtd_customer,
    mtd_order,
    mtd_gmv
FROM OrderRangeMetrics
ORDER BY order_range;

select extract(month from order_date) from order_details_v1;
 
 
 
 
 
 select 
 count(distinct(case when  order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") then customer_id end)) as MTD_customer,
 count(case when  order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") then order_id end) as MTD_order,
 sum(case when  order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") then selling_price end) as MTD_GMV,
 
 count(distinct(case when  order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then customer_id end)) as LM_customer,
 count(case when  order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then order_id end) as LM_order,
 sum(case when  order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then selling_price end) as LM_GMV
 
 
 
 from order_details_v1;












select order_range,MTD_customer,MTD_order,MTD_GMV,LM_customer,LM_order,LM_GMV
from
(
select 
   case 
        when total_orders between 1 and 2 then "1-2"
        when total_orders between 3 and 5 then "3-5"
        when total_orders between 6 and 10 then "6-10"
        else "10+" end as order_range,
   coalesce(
   count(distinct(case when  order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") then total_customers end))) as MTD_customer,
 count(case when  order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") then total_orders end) as MTD_order,
 coalesce(sum(case when  order_date between date_format(current_date(),"%Y-03-01") and  date_format(current_date()-interval 1 day,"%Y-%m-%d") then selling_price end)) as MTD_GMV,
 
 count(distinct(case when  order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then total_customers end)) as LM_customer,
 count(case when  order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then total_orders end) as LM_order,
coalesce( sum(case when  order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then selling_price end)) as LM_GMV

from 
( 
   
   
            
 select order_date, 
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(*) AS total_orders,
    sum(selling_price) as selling_price
    
FROM
    order_details_v1 
    group by order_date 
    ) p group by order_range
    ) x ;

 
 