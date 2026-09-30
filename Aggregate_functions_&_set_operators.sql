USE workDB;
GO

-- Q1
SELECT
    SUM(unit_cost * quantity_in_stock) AS total_inventory_value
FROM hra.raw_materials;
GO


-- Q2
SELECT
    p.product_id,
    p.product_name,
    SUM(pv.pack_size_liters) AS total_volume_liters
FROM hra.products AS p
INNER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id
GROUP BY
    p.product_id,
    p.product_name;
GO


-- Q3
SELECT
    product_id,
    AVG(mrp) AS average_selling_price
FROM hra.product_variants
GROUP BY product_id;
GO


-- Q4
SELECT
    AVG(reorder_level) AS average_hazardous_reorder_level
FROM hra.raw_materials
WHERE hazardous_flag = 1;
GO


-- Q5
SELECT
    p.product_id,
    p.product_name,
    COUNT(pv.variant_id) AS active_variant_count
FROM hra.products AS p
INNER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id
WHERE pv.is_active = 1
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(pv.variant_id) > 3;
GO


-- Q6
SELECT
    'Main raw_materials' AS source_table,
    COUNT(DISTINCT material_id) AS distinct_material_count
FROM hra.raw_materials

UNION ALL

SELECT
    'Staging stg_raw_materials' AS source_table,
    COUNT(DISTINCT material_id) AS distinct_material_count
FROM hra.stg_raw_materials;
GO


-- Q7
SELECT
    product_id,
    MAX(mrp) AS maximum_price
FROM hra.product_variants
GROUP BY product_id;
GO


-- Q8
SELECT
    MIN(reorder_level) AS minimum_reorder_level
FROM hra.stg_raw_materials;
GO


-- Q9
SELECT material_id
FROM hra.raw_materials

UNION

SELECT material_id
FROM hra.stg_raw_materials;
GO


-- Q10
SELECT product_name AS item_name
FROM hra.products

UNION

SELECT material_name AS item_name
FROM hra.raw_materials;
GO


-- Q11
SELECT
    sku_code AS item_identifier
FROM hra.product_variants

UNION ALL

SELECT
    CAST(material_id AS VARCHAR(30)) AS item_identifier
FROM hra.raw_materials;
GO


-- Q12
SELECT reorder_level
FROM hra.raw_materials
WHERE reorder_level IS NOT NULL

INTERSECT

SELECT reorder_level
FROM hra.stg_raw_materials
WHERE reorder_level IS NOT NULL;
GO


-- Q13
SELECT material_id
FROM hra.stg_raw_materials

EXCEPT

SELECT material_id
FROM hra.raw_materials;
GO


-- Q14
SELECT material_id
FROM hra.raw_materials

EXCEPT

SELECT material_id
FROM hra.stg_raw_materials;
GO