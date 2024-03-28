use rahul_project;

select * from order_details_v1;


      select date_format(r.order_date,"%b-%y") as mnt_name,
         sum(case when  f.first_order_date = r.order_date then 1 else 0 end) as new_user,
         sum(case when  f.first_order_date != r.order_date then 1 else 0 end) as repeat_user
		  from
             (
                select customer_id,min(order_date)  as first_order_date 
                from order_details_v1 where order_date >= "2023-01-01" and order_date <= "2023-12-31"
                group by customer_id
             ) f
            inner join
            (
            
                select customer_id,order_date from order_details_v1
			) r
			on r.customer_id  = f.customer_id
            where order_date>="2023-01-01" and order_date <= "2023-12-31"
		    group by  date_format(r.order_date,"%b-%y"),month(r.order_date)
            order by month(r.order_date) asc;
