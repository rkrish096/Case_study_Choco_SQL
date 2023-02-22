-- 1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?

Select * from sales
where Amount > 2000 and Boxes <100 ;

-- 2. How many shipments (sales) each of the sales persons had in the month of January 2022?

select count(SaleDate) as Total_sales, people.Salesperson from sales
join people on sales.SPID = people.SPID
 where SaleDate between '2022-01-01' and '2022-01-31'
group by Salesperson;

-- 3. Which product sells more boxes? Milk Bars or Eclairs?

select sum(Boxes) as Total_Boxes, products.product from sales 
join products on sales.PID = products.PID
where products.Product in ('Milk Bars','Eclairs')
group by products.Product;

-- 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?


select  SaleDate, sum(Boxes) as Total_boxes , p.Product  
from sales
join products p on p.PID = sales.PID 
where p.product in ('Milk Bars','Eclairs') and SaleDate between '2022-02-01' and '2022-02-7'
group by p.Product;


-- 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?


select *, weekday(SaleDate) as Wednesday_shipment 
from sales 
where Customers <=100 AND Boxes <= 100 AND weekday(SaleDate) = 2 ;
-- group by SPID 
-- order by Customers desc;

-- 6. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022
 
 select * from sales ;
 
select  distinct Salesperson, count(SaleDate) as Total_scale 
from sales 
join people p on p.SPID = sales.SPID
where SaleDate between '2022-01-01' and '2022-01-7'
group by Salesperson ;

-- 7. Which salespersons did not make any shipments in the first 7 days of January 2022?

select Salesperson from people
where SPID not in (select SPID from sales 
where SaleDate between '2022-01-01' and '2022-01-7');


-- 8. How many times we shipped more than 1,000 boxes in each month?

Select year(SaleDate), month(SaleDate), count(Boxes) as more_than_1000k
from sales
where Boxes>1000
group by  year(SaleDate), month(SaleDate)
order by  year(SaleDate), month(SaleDate) ;


-- 9. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select * from products

select count(Boxes),SPID , geo.Region
 from sales 
 join geo on geo.GeoID= sales.GeoID
 where Region = 'New Zealand' and Boxes>90
 group by SPID;

-- 10. India or Australia? Who buys more chocolate boxes on a monthly basis?

-- select * from geo ;
-- select * from sales;

select  year(SaleDate),month(SaleDate),
sum(case when g.Geo = 'Australia'= true then Boxes else 0 end)'Australia_boxes',  
sum(case when g.geo = 'India'= true then Boxes else 0 end)'India_boxes'
from sales 
join geo g on g.GeoID = sales.GeoID 
group by year(SaleDate),month(SaleDate);


Select GeoID, Boxes ,month(SaleDate),year(SaleDate) from sales
where GeoID = 'G1'
group by month(SaleDate),year(SaleDate) ;



select *, 
case when Geo = 'India'= true then Region 
	else 0
	end as Country
from geo ;




