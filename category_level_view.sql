#------------------------------------------------------------------------#
        #--------  First Question Solution ------------#
#------------------------------------------------------------------------#

    
select p.category,

    
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
group by p.category;
















































#------------  create solution step by step        --------------#

select * from product_hierarchy;

select count(distinct(category)) from product_hierarchy;

select * from order_details_v1;

select count(customer_id) as cust,count(distinct(customer_id)) as unique_cust
from order_details_v1;

select count(customer_id) as cust,count(distinct(customer_id)) as unique_cust
from order_details_v1 where order_date = date_format(current_date()-interval 1 day,"%Y-%m-%d") ; 


select * from product_hierarchy as p inner join order_details_v1 as o
on p.product_id  = o.product_id;

select p.category,count(o.order_id) as yest_order,sum(o.selling_price) as yest_GMV,
round((sum(o.selling_price)/1.18),2) as yest_revenue,
count(distinct(o.customer_id)) as Yest_cust,
count(distinct(p.product_id)) as yest_live_product
from product_hierarchy as p inner join order_details_v1 as o
on p.product_id  = o.product_id 
#where o.order_date between date_format(current_date(),"%Y-%m-01")  and date_format(current_date()-interval 1 day,"%Y-%m-%d")#
#where o.order_date between date_format(current_date()-interval 1 month,"%Y-%m-01")  and date_format(current_date()-interval 1 month,"%Y-%m-%d")#
where o.order_date between date_format(current_date()-interval 1 month,"%Y-%m-01") and  date_format(last_day(current_date()-interval 1 month),"%Y-%m-%d")

 group by p.category;

select date_format(current_date(),"%Y-%m-01"),date_format(current_date()-interval 1 day,"%Y-%m-%d");
select current_date()-interval 1 day;
select date_format(current_date()-interval 1 month,"%Y-%m-01");
select date_format(current_date()-interval 1 month,"%Y-%m-%d");



select p.category,

    
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
 group by p.category;

