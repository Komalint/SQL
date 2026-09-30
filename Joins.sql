ALTER TABLE hra.product_variants
ADD variant_name VARCHAR(100);
GO
 
 use work
-- =========== 1 ==================
use schema hra
SELECT
    p.product_name,
    pv.sku_code AS sku,
    pv.variant_name
FROM hra.products AS p
INNER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id;


-- ========= 2 ==========
SELECT
    p.product_name,
    COUNT(pv.variant_id) AS total_variants
FROM hra.products AS p
INNER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id
GROUP BY
    p.product_id,
    p.product_name;


    SELECT
    p.product_name,
    COUNT(pv.variant_id) AS total_variants
FROM hra.products AS p
LEFT JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(pv.variant_id) > 0;


-- ===============3 ==================
SELECT
    p.product_name,
    pv.sku_code AS sku
FROM hra.products AS p
LEFT JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id;


-- =========== 4 ====================
SELECT
    p.product_id,
    p.product_name
FROM hra.products AS p
LEFT JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id
WHERE pv.variant_id IS NULL;


-- =========== 5 ====================
SELECT
    pv.sku_code AS sku,
    p.product_name
FROM hra.products AS p
RIGHT JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id;


-- =========== 6 ====================
SELECT
    child.material_name AS material_name,
    parent.material_name AS parent_material_name
FROM hra.raw_materials AS child
LEFT JOIN hra.raw_materials AS parent
    ON child.parent_material_id = parent.material_id;


-- =========== 7 ====================

SELECT
    pv1.product_id,
    pv1.sku_code AS sku_1,
    pv2.sku_code AS sku_2
FROM hra.product_variants AS pv1
INNER JOIN hra.product_variants AS pv2
    ON pv1.product_id = pv2.product_id
    AND pv1.variant_id < pv2.variant_id;

-- =========== 8 ====================
SELECT
    p.product_name,
    rm.material_name
FROM hra.products AS p
CROSS JOIN hra.raw_materials AS rm;

-- =========== 9 ====================


CREATE TABLE hra.stg_raw_materials
(
    stg_id INT IDENTITY(1,1) PRIMARY KEY,

    material_id INT NOT NULL,

    stock_level DECIMAL(10,2) NOT NULL,

    last_updated DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_stg_raw_materials_raw_materials
        FOREIGN KEY (material_id)
        REFERENCES hra.raw_materials(material_id)
);

INSERT INTO hra.stg_raw_materials
(material_id, stock_level)
VALUES
(1, 450.00),
(2, 620.00),
(3, 125.00),
(4, 95.00),
(5, 80.00),
(6, 140.00),
(7, 115.00),
(8, 90.00),
(9, 300.00),
(10, 275.00),
(11, 220.00),
(12, 180.00),
(13, 160.00),
(14, 75.00),
(15, 65.00),
(16, 45.00),
(17, 110.00),
(18, 85.00),
(19, 55.00),
(20, 70.00);
GO

SELECT
    p.product_name,
    rm.material_id,
    rm.material_name,
    srm.stock_level
FROM hra.raw_materials AS rm
LEFT JOIN hra.stg_raw_materials AS srm
    ON rm.material_id = srm.material_id
CROSS JOIN hra.products AS p;