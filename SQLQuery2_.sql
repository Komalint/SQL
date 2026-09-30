create schema hr



CREATE TABLE hr.candidates
(
    id INT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL
);
drop table hr.employees
CREATE TABLE hr.employees
(
    id INT ,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO hr.candidates (id, fullname)
VALUES
(1, 'John Smith'),
(2, 'Alice Brown'),
(3, 'David Miller'),
(4, 'Emma Wilson'),
(5, 'Michael Scott');

INSERT INTO hr.employees (id, fullname)
VALUES
(null, 'John Smith'),
(102, 'Emma Wilson'),
(103, 'Robert King');

SELECT
    c.id AS candidate_id,
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c
LEFT JOIN hr.employees e
    ON e.fullname = c.fullname and e.id IS NULL;

select p.product_name as productName, pv.sku_code as sku_code , pv.varient_id as varient 
from hra.product p 
	inner join hra.product_Varient pv 
on p.product_id = pv.product_id ;

select p.product_name as productName, count(pv.varient_id) as varient_id 
from hra.product p 
	inner join hra.product_Varient pv 
on p.product_id = pv.product_id
group by p.product_name
having count(pv.varient_id) >=1;

select p.product_name as productName, pv.sku_code as sku_code , pv.varient_id as varient 
from hra.product p 
	left join hra.product_Varient pv 
on p.product_id = pv.product_id ;

select p.product_name as productName, pv.sku_code as sku_code , pv.varient_id as varient 
from hra.product p 
	left join hra.product_Varient pv 
on p.product_id = pv.product_id 
where pv.varient_id is null;

select p.product_name as productName, pv.sku_code as sku_code , pv.varient_id as varient 
from hra.product p 
	right join hra.product_Varient pv 
on p.product_id = pv.product_id 

create table [hr].[raw_materials](
[material_id] int primary key identity,
[material_name] varchar(100) not null,
[type] varchar(15) not null constraint chech_type check ([type] in ('Pigment' ,'Binder', 'Solvent', 'Addictive')),
[unit_of_measurement] varchar(10) not null,
[reorder_level] decimal(10,2) not null,
[hazardous_flag] bit default 0,
[parent_material_id] int
);

INSERT INTO [hr].[raw_materials]
(
    material_name,
    [type],
    unit_of_measurement,
    reorder_level,
    hazardous_flag,
    parent_material_id
)
VALUES
('Titanium Dioxide',      'Pigment',  'KG', 500.00, 0, 2),
('Iron Oxide Red',        'Pigment',  'KG', 250.00, 0, 4),
('Carbon Black',          'Pigment',  'KG', 150.00, 0, 3),
('Acrylic Resin',         'Binder',   'KG', 400.00, 0, NULL),
('Epoxy Resin',           'Binder',   'KG', 300.00, 0, 5),
('Polyurethane Resin',    'Binder',   'KG', 250.00, 0, 4),
('Xylene',                'Solvent',  'LTR',500.00, 1, 7),
('Mineral Turpentine',    'Solvent',  'LTR',350.00, 1, 8),
('Butyl Acetate',         'Solvent',  'LTR',250.00, 1, 9),
('Defoamer',              'Addictive','KG', 50.00, 0, 6),
('Wettting Agent',        'Addictive','KG', 40.00, 0, 9),
('Dispersing Agent',      'Addictive','KG', 60.00, 0, 2),
('Rheology Modifier',     'Addictive','KG', 80.00, 0, 10),
('Yellow Oxide',          'Pigment',  'KG', 200.00, 0, 2),
('Blue Pigment Paste',    'Pigment',  'KG', 180.00, 0, 1);

select r.material_name+' '+r.type material_type, r.material_id, r.parent_material_id 
from hr.raw_materials r inner join  hr.raw_materials pr
on r.material_id = pr.parent_material_id


select *from hr.product_Varient

create table [hr].[product_Varient](
	[varient_id] int primary key identity,
	[product_id] int not null,
	[baseType] varchar(20) not null,
	[packSize] decimal(5,2) not null,
	[sku_code] varchar(30) unique not null,
	[unit_cost] decimal(10,2) not null,
	[mrp] decimal(10,2) not null
);

INSERT INTO hr.product_Varient
(product_id, baseType, packSize, sku_code, unit_cost, mrp)
VALUES
(1,  'White Base', 1.00,  'WG-INT-W-1',   250.00,  400.00),
(1,  'White Base', 4.00,  'WG-INT-W-4',   950.00, 1450.00),

(2,  'Deep Base', 1.00,   'SSW-INT-D-1',  300.00,  480.00),
(2,  'Deep Base', 4.00,   'SSW-INT-D-4', 1100.00, 1700.00),

(4,  'White Base', 10.00, 'WGP-EXT-W-10',2800.00, 4200.00),

(5,  'White Base', 20.00, 'EBM-INT-W-20',4000.00, 6200.00),

(6,  'Primer Base', 1.00, 'UPU-DUAL-P-1', 450.00,  700.00),
(6,  'Primer Base', 4.00, 'UPU-DUAL-P-4',1700.00, 2600.00),

(12, 'White Base', 1.00,  'TE-EXT-W-1',   380.00,  600.00),
(12, 'White Base', 20.00, 'TE-EXT-W-20', 7000.00, 9800.00),

(13, 'Silk Base', 1.00,   'SSW-INT-S-1',  350.00,  550.00),
(13, 'Silk Base', 10.00,  'SSW-INT-S-10',3200.00, 4700.00),

(14, 'Deep Base', 1.00,   'WGP-EXT-D-1',  400.00,  650.00),
(14, 'Deep Base', 20.00,  'WGP-EXT-D-20',7600.00,10500.00),

(15, 'Bio Base', 1.00,    'EBM-BIO-B-1',  280.00,  450.00),
(15, 'Bio Base', 10.00,   'EBM-BIO-B-10',2600.00, 3900.00);

select pr.product_id,pr.sku_code
from hr.product_Varient p inner join hr.product_Varient pr 
on p.sku_code = pr.sku_code

select *
from hr.raw_materials r cross join hra.product p

select *
from hr.raw_materials r left join hra.raw_materials hraw on r.material_id= hraw.material_id cross join hra.product 






-- -------------------------------------------------------------------------------------------------
create schema labTest
CREATE TABLE labTest.orders
(
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL
);


INSERT INTO labTest.orders (customer_id, order_date, order_amount)
VALUES
-- Customer 1
(1, '2022-01-15', 1200.00),
(1, '2022-03-10', 800.00),
(1, '2023-07-21', 1500.00),

-- Customer 2
(2, '2022-02-05', 600.00),
(2, '2023-04-12', 950.00),
(2, '2023-11-18', 400.00),
(2, '2024-01-20', 700.00),

-- Other customers (should not appear)
(3, '2022-06-18', 1200.00),
(4, '2023-08-25', 900.00);



SELECT
    customer_id,
    YEAR(order_date) AS order_year,
    COUNT(order_id) AS order_placed
FROM labTest.orders
WHERE customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR(order_date)
ORDER BY customer_id;


SELECT customer_id,
       total_orders
FROM
(
    SELECT customer_id,
           COUNT(order_id) AS total_orders
    FROM labTest.orders
    GROUP BY customer_id
) AS order_summary
---WHERE total_orders > 3
group by total_orders,customer_id
having total_orders = 4

-- -------------------- set operations -------------
-- T1 Sales Department
CREATE TABLE employee_sales (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
);

-- T2 Marketing Department

CREATE TABLE employee_marketing (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
);

-- Insert sample data into Sales
INSERT INTO employee_sales (emp_id, emp_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

-- Insert sample data into Marketing
INSERT INTO employee_marketing (emp_id, emp_name) VALUES
(2, 'Oggy'), -- Present in both departments
(4, 'David'),   -- Present in both departments
(5, 'Emma'),
(6, 'Frank');

-- 1
SELECT emp_id, emp_name FROM employee_sales
UNION
SELECT emp_id, emp_name FROM employee_marketing;

-- 2
SELECT emp_id, emp_name FROM employee_sales
UNION ALL
SELECT emp_id, emp_name FROM employee_marketing;

-- 3
SELECT emp_id, emp_name FROM employee_sales
INTERSECT
SELECT emp_id, emp_name FROM employee_marketing;

-- 4
-- Employees in Sales who are NOT in Marketing
SELECT emp_id, emp_name FROM employee_sales
EXCEPT
SELECT emp_id, emp_name FROM employee_marketing;



-- -------------------------------------- Q1 -----------------------------------------------


CREATE TABLE [labTest].[raw_material](
    [material_id] INT PRIMARY KEY,
    [material_name] VARCHAR(50),
    [unit_cost] INT,
    [quantity_in_stock] INT,
    [reorder_level] INT,               -- Minimum stock before reordering
    [is_hazardous] BIT,                 -- 1 = Hazardous, 0 = Non-Hazardous
    [parent_material_id] INT NULL,      -- Self-referencing link (base/raw form)
    FOREIGN KEY (parent_material_id) REFERENCES [labTest].[raw_material](material_id)
);

-- Insert sample data with new parameters
INSERT INTO [labTest].[raw_material] 
    ([material_id], [material_name], [unit_cost], [quantity_in_stock], [reorder_level], [is_hazardous], [parent_material_id]) 
VALUES
    (101, 'Sodium Chloride (Salt)', 15, 500,  100, 0, NULL),
    (102, 'Ethanol 99% Pure',       45, 200,  50,  1, NULL),
    (103, 'Hydrochloric Acid 37%',  30, 40,   100, 1, NULL),
    (104, 'Sulfuric Acid 98%',      50, 80,   100, 1, NULL),
    (105, 'Distilled Water',        5,  1200, 200, 0, NULL),
    (106, 'Acetone Technical',      40, 0,    50,  1, NULL),      -- Out of stock
    (107, 'Sodium Hydroxide',       25, 350,  100, 1, NULL),
    (108, 'Ethanol 70% Diluted',    30, 150,  50,  1, 102);     -- Child material derived from 102 

select  sum(quantity_in_stock * unit_cost) as current_inventory_value
from [labTest].[raw_material]


-- -------------------------------------- Q2 -----------------------------------------------

-- Create Table
CREATE TABLE [labTest].[products](
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    weights INT,
    product_varient VARCHAR(10)
);

-- Insert 20 Sample Records
INSERT INTO [labTest].[products] (product_id, product_name, weights, product_varient) 
VALUES
    (1,  'Ethanol Solution',       500,  '500ml'),
    (2,  'Ethanol Solution',       1000, '1000ml'),
    (3,  'Acetone Solvent',        500,  '500ml'),
    (4,  'Acetone Solvent',        1000, '1000ml'),
    (5,  'Sodium Chloride Powder', 250,  '250g'),
    (6,  'Sodium Chloride Powder', 500,  '500g'),
    (7,  'Hydrochloric Acid',      500,  '500ml'),
    (8,  'Hydrochloric Acid',      1000, '1000ml'),
    (9,  'Sulfuric Acid Concentrated', 500, '500ml'),
    (10, 'Sulfuric Acid Concentrated', 1000, '1000ml'),
    (11, 'Potassium Chloride',     250,  '250g'),
    (12, 'Potassium Chloride',     500,  '500g'),
    (13, 'Methanol Reagent',       500,  '500ml'),
    (14, 'Methanol Reagent',       1000, '1000ml'),
    (15, 'Calcium Carbonate',      250,  '250g'),
    (16, 'Calcium Carbonate',      500,  '500g'),
    (17, 'Distilled Water',        1000, '1000ml'),
    (18, 'Glycerol Solution',      500,  '500ml'),
    (19, 'Sodium Bicarbonate',     250,  '250g'),
    (20, 'Sodium Bicarbonate',     500,  '500g');

select [product_varient] , sum([weights]) as total_weights
from [labTest].[products]
group by products.product_varient
order by [product_varient]

-- -------------------------------------- Q3 -----------------------------------------------

-- Create the product_varient table
CREATE TABLE [labTest].[product_varient](
    variant_id INT PRIMARY KEY,
    product_id INT, -- Foreign key referencing [labTest].[products]
    product_varient VARCHAR(10),
    selling_price DECIMAL(10, 2),
    discount_percent DECIMAL(5, 2),
    FOREIGN KEY (product_id) REFERENCES [labTest].[products](product_id)
);

INSERT INTO [labTest].[product_varient] (variant_id, product_id, product_varient, selling_price, discount_percent)
VALUES
    (101, 1,  '500ml',  18.50, 5.00),
    (102, 2,  '1000ml', 32.00, 10.00),
    (103, 3,  '500ml',  22.00, 0.00),
    (104, 4,  '1000ml', 40.00, 8.00),
    (105, 5,  '250g',   8.00,  0.00),
    (106, 6,  '500g',   14.00, 5.00),
    (107, 7,  '500ml',  25.00, 12.00),
    (108, 8,  '1000ml', 45.00, 15.00),
    (109, 9,  '500ml',  30.00, 10.00),
    (110, 10, '1000ml', 55.00, 20.00),
    (111, 11, '250g',   12.50, 0.00),
    (112, 12, '500g',   22.00, 5.00),
    (113, 13, '500ml',  20.00, 5.00),
    (114, 14, '1000ml', 36.00, 10.00),
    (115, 15, '250g',   7.50,  0.00),
    (116, 16, '500g',   13.00, 0.00),
    (117, 17, '1000ml', 6.00,  0.00),
    (118, 18, '500ml',  28.00, 8.00),
    (119, 19, '250g',   9.00,  0.00),
    (120, 20, '500g',   16.00, 5.00);

select cast(round(avg(selling_price),2) as decimal(10,2)) as AVGselling, product_varient
from [labTest].[product_varient]
group by product_varient


-- -------------------------------------- Q4 -----------------------------------------------

select avg(reorder_level) as reorder_level , material_id 
from [labTest].[raw_material]
where is_hazardous =1
group by material_id


-- -------------------------------------- Q5 -----------------------------------------------

select pv.product_id,
COUNT(pv.variant_id) as countOfVariants
from [labTest].[product_varient] as pv
group by pv.product_id
having count(pv.variant_id) >=1


-- -------------------------------------- Q6 -----------------------------------------------
-- Create Staging Table
CREATE TABLE [labTest].[stg_raw_material](
    [material_id] INT PRIMARY KEY,
    [material_name] VARCHAR(50),
    [unit_cost] INT,
    [quantity_in_stock] INT,
    [reorder_level] INT,
    [is_hazardous] BIT,
    [parent_material_id] INT NULL
);

-- Insert sample staging data (10 records: includes original 8 + 2 new incoming items)
INSERT INTO [labTest].[stg_raw_material] 
    ([material_id], [material_name], [unit_cost], [quantity_in_stock], [reorder_level], [is_hazardous], [parent_material_id]) 
VALUES
    (101, 'Sodium Chloride (Salt)', 15, 500,  100, 0, NULL),
    (102, 'Ethanol 99% Pure',       45, 200,  50,  1, NULL),
    (103, 'Hydrochloric Acid 37%',  30, 40,   100, 1, NULL),
    (104, 'Sulfuric Acid 98%',      50, 80,   100, 1, NULL),
    (105, 'Distilled Water',        5,  1200, 200, 0, NULL),
    (106, 'Acetone Technical',      40, 0,    50,  1, NULL),
    (107, 'Sodium Hydroxide',       25, 350,  100, 1, NULL),
    (108, 'Ethanol 70% Diluted',    30, 150,  50,  1, 102),
    -- 2 New materials present in staging but not in raw_material
    (109, 'Nitric Acid 65%',        38, 120,  50,  1, NULL),
    (110, 'Acetic Acid Glacial',    22, 450,  100, 0, NULL);


select count(distinct(material_id)) 
from [labTest].[stg_raw_material]

except

select count(distinct(material_id)) 
from [labTest].[raw_material]

SELECT 
    (SELECT COUNT(DISTINCT material_id) FROM [labTest].[stg_raw_material]) AS stg_count,
    (SELECT COUNT(DISTINCT material_id) FROM [labTest].[raw_material]) AS main_count;

-- -------------------------------------- Q7 -----------------------------------------------
select product_id, max(selling_price) as max_selling_price
from [labTest].[product_varient]
group by product_id

-- -------------------------------------- Q8 -----------------------------------------------

select material_id, min(reorder_level) as reorder_level 
from [labTest].[stg_raw_material]
group by material_id

-- -------------------------------------- Q9 -----------------------------------------------
select material_id from [labTest].[raw_material]
union
select material_id from [labTest].[stg_raw_material]
order by material_id


-- -------------------------------------- Q10 -----------------------------------------------
select material_name from [labTest].[raw_material]
union
select product_name from [labTest].[products]

-- -------------------------------------- Q11 -----------------------------------------------

select sku_code as item_identifier from hr.product_Varient
union all
select cast(material_id as varchar(30)) as material from hr.raw_materials


-- -------------------------------------- Q12 -----------------------------------------------
select rm.reorder_level as commonVal from [labTest].[raw_material] as rm
intersect
select  srm.reorder_level  from [labTest].[stg_raw_material] as srm


-- -------------------------------------- Q13 -----------------------------------------------                                                                     

select  srm.material_id as common_material_id from [labTest].[stg_raw_material] as srm
except
select rm.material_id as commonVal from [labTest].[raw_material] as rm

-- -------------------------------------- Q14 -----------------------------------------------

select rm.material_id as diffval from [labTest].[raw_material] as rm
except
select  srm.material_id as diffval from [labTest].[stg_raw_material] as srm