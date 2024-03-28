use rahul_project;

select GMV_Range,MTD_customer,MTD_order,MTD_GMV,LM_customer,LM_order,LM_GMV
from
(
select 
   case 
        when selling_price between 1 and 100 then "1-100"
        when selling_price between 101 and 200 then "101-200"
        when selling_price between 201 and 300 then "201-300"
        when selling_price between 301 and 400 then "301-400"
        when selling_price between 401 and 500 then "401-500"
        when selling_price between 501 and 1000 then "501-1000"
        when selling_price between 1001 and 1500 then "1001-1500"
        when selling_price between 1501 and 2000 then "1501-2000"
        when selling_price between 2001 and 5000 then "2001-5000"
        
        else "GTR-5000" end as GMV_Range,
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
    ) p group by GMV_range
    ) x ;
