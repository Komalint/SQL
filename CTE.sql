-- Working with CTE

-- Q1
use BikeStores

select * from sales.order_items;

with cte_TotalRevenueOrder 
as
(
select s.order_id, sum(s.quantity *s.list_price * (1-s.discount)) as totalNetRevenue  from sales.order_items s group by s.order_id
),
cte_AvgNetRevenue
as
(
	select  Avg(totalNetRevenue) as AvgNetRevenue 
	from cte_TotalRevenueOrder
	--select  Avg(a.quantity *a.list_price * (1-a.discount)) as AvgNetRevenue from sales.order_items a 
)
select t.order_id, t.totalNetRevenue
from cte_TotalRevenueOrder t 
cross join 
cte_AvgNetRevenue a
where totalNetRevenue > a.AvgNetRevenue


-- Q2
with cte_RevenuePerOrder 
as
(
select 
	s.discount as dis,
	s.order_id as orId,
	s.item_id as itId,
	sum(s.quantity * s.list_price * (1-s.discount)) as revenue
	,DENSE_RANK() over(partition by(s.order_id) order by s.discount desc) as rnk  
	from sales.order_items s 
	group by s.order_id, s.item_id, s.discount
	
)
select * from cte_RevenuePerOrder tr where rnk=1
