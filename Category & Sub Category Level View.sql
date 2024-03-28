#-------------- Second Question Solution ------------------------------------#
#------------  Category and sub category level   ----------------------------#

use rahul_project;


select p.category,p.sub_category,

    
    #  --------------- Start Yday  -------------#
      
      count(case when o.order_date = date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.order_id end) as Y_order,
      sum(case when o.order_date = date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.selling_price end) as Y_GMV,
      round((sum(case when o.order_date = date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.selling_price end)/1.18),2) as Y_Revenue,
      count(distinct(case when o.order_date = date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.customer_id end)) as Y_Customer,
      count(distinct(case when o.order_date = date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.product_id end)) as Y_live_prod,

   #------------------ end Yday -----------------------#
   
   
   
   #------------------ Start MTD    ---------------------------#
     
       count(case when o.order_date  between date_format(current_date(),"%Y-%m-01")  and date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.order_id end) as MTD_order,
       sum(case when o.order_date  between date_format(current_date(),"%Y-%m-01")  and date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.selling_price end) as MTD_GMV,
       round((sum(case when o.order_date  between date_format(current_date(),"%Y-%m-01")  and date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.selling_price end)/1.18),2) as MTD_Revenue,
       count(distinct(case when o.order_date  between date_format(current_date(),"%Y-%m-01")  and date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.customer_id end)) as MTD_Customer,
       count(distinct(case when o.order_date  between date_format(current_date(),"%Y-%m-01")  and date_format(current_date()-interval 1 day,"%Y-%m-%d") then o.product_id end)) as MTD_live_prod,
   
   #------------------ End   MTD    ---------------------------#
   
   
   
   #------------------------  Start LMTD  ---------------------#
   
   
	   count(case when o.order_date  between date_format(current_date()-interval 1 month,"%Y-%m-01")  and date_format(current_date()-interval 1 month,"%Y-%m-%d") then o.order_id end) as LMTD_order,
       sum(case when o.order_date  between date_format(current_date()-interval 1 month,"%Y-%m-01")  and date_format(current_date()-interval 1 month,"%Y-%m-%d") then o.selling_price end) as LMTD_GMV,
       round((sum(case when o.order_date  between date_format(current_date()-interval 1 month,"%Y-%m-01")  and date_format(current_date()-interval 1 month,"%Y-%m-%d") then o.selling_price end)/1.18),2) as LMTD_Revenue,
       count(distinct(case when o.order_date  between date_format(current_date()-interval 1 month,"%Y-%m-01")  and date_format(current_date()-interval 1 month,"%Y-%m-%d") then o.customer_id end)) as LMTD_Customer,
       count(distinct(case when o.order_date  between date_format(current_date()-interval 1 month,"%Y-%m-01")  and date_format(current_date()-interval 1 month,"%Y-%m-%d") then o.product_id end)) as LMTD_live_prod,           
   
   
   #------------------------  End   LMTD  ---------------------#
   
   
   #----------------  Start LM ---------------------------------#
   
		count(case when o.order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then o.order_id end) as LM_order,
        sum(case when o.order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then o.selling_price end) as LM_GMV,
        round((sum(case when o.order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then o.selling_price end)/1.18),2) as LM_Revenue,
        count(distinct(case when o.order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then o.customer_id end)) as LM_Customer,
        count(distinct(case when o.order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d") then o.product_id end)) as LM_live_prod

   
   
   #----------------  End   LM ---------------------------------#
   
   
from product_hierarchy as p inner join order_details_v1 as o
on p.product_id  = o.product_id 
group by p.category,p.sub_category;






























select category,sub_category,
row_number() over(partition by category) as rn

from product_hierarchy;