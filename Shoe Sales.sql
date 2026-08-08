select * from shoe_sales;

alter table shoe_sales
drop column MyUnknownColumn;

alter table store_info
drop column MyUnknownColumn;

select * from store_info;

with merged_tables as
(select distinct
s.transaction_id,s.store_id,i.store_name,i.city,i.state,
i.region,i.store_type,product_name,
brand,category,
case
when(left(gender,1)='M')
then 'Men'
when(left(gender,1)='W')
then 'Women'
when(gender in('Child','Youth'))
then 'Kids'
else gender
end as gender,
quantity,unit_price,
case
when(discount_pct<1)
then discount_pct*100
else discount_pct
end as discount,
payment_method,channel
from shoe_sales s
join store_info i 
on i.store_id=s.store_id)

select *,
round(unit_price*quantity*(1-(discount/100)),2) as revenue
from merged_tables;