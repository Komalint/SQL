SELECT  [BookId]
      ,[ISBN]
      ,[Title]
      ,[AuthorName]
      ,[Category]
      ,[PublicationYear]
      ,[Price]
      ,[StockQuantity]
      ,[Publisher]
  FROM [AssignmentDB].[dbo].[Bookss]


  -- sp_helpindex 'Bookss'

  drop index  ix_BookssData_Title on Bookss

  select * from Bookss where AuthorName = 'Author 1';

  select * from Bookss where Title ='Book Title 2';

  create nonclustered index ix_NC_titleandAuthorName
  on Bookss(Title,AuthorName)

   select * from Bookss where Category = 'Fiction'; 

  create clustered index ix_NC_BookssId
  on Bookss(BookId)


  -- Working on bikestore sales schema

  -- Q1
  drop index ix_OrderAndItems on sales.order_items
  create clustered index ix_OrderAndItems 
  on sales.order_items(order_id,item_id)

  -- composite cluster indexing 

  select * from sales.order_items where order_id = 42 -- index seek
  select * from sales.order_items where item_id = 42 -- index scan

  -- Q2
  drop index CI_OrderItems_OrderId on sales.order_items
 CREATE CLUSTERED INDEX CI_OrderItems_OrderId
ON sales.order_items(order_id);
 --  cluster indexing 
select * from sales.order_items where order_id between 10 and 100  -- this to index seek
select * from sales.order_items where item_id between 1000000 and 1005000   -- index scan


-- Q3
drop index IX_OrderItems_ProductId on sales.order_items
CREATE NONCLUSTERED INDEX IX_OrderItems_ProductId
ON sales.order_items(product_id);
 select * from sales.order_items where product_id = 505

-- Q4
drop index ix_productIdonOItems on sales.order_items
  create nonclustered index ix_productIdonOItems
  on sales.order_items(product_id) include(order_id,item_id,quantity, list_price, discount)

 select * from sales.order_items where product_id = 505


 -- Q5

CREATE NONCLUSTERED INDEX IX_OrderItems_Discount_Filtered
ON sales.order_items(discount)
WHERE discount > 0;

select * from sales.order_items where discount= 0.5