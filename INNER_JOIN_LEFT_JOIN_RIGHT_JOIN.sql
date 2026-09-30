
-- Q1
SELECT
    p.product_name,
    pv.sku_code AS sku,
    pv.mrp AS price
FROM hra.products AS p
INNER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id
WHERE pv.is_active = 1;


-- Q2
CREATE TABLE hra.product_variant_materials
(
    mapping_id INT IDENTITY(1,1) PRIMARY KEY,
    variant_id INT NOT NULL,
    material_id INT NOT NULL,

    CONSTRAINT FK_pvm_variant
        FOREIGN KEY (variant_id)
        REFERENCES hra.product_variants(variant_id),

    CONSTRAINT FK_pvm_material
        FOREIGN KEY (material_id)
        REFERENCES hra.raw_materials(material_id)
);


INSERT INTO hra.product_variant_materials
(variant_id, material_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10);


SELECT DISTINCT
    pv.sku_code AS sku
FROM hra.product_variants AS pv
INNER JOIN hra.product_variant_materials AS pvm
    ON pv.variant_id = pvm.variant_id
INNER JOIN hra.raw_materials AS rm
    ON pvm.material_id = rm.material_id
WHERE rm.hazardous_flag = 1;

-- Q3
SELECT
    p.product_name,
    pv.sku_code AS sku
FROM hra.products AS p
LEFT OUTER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id
WHERE pv.variant_id IS NULL;


-- Q4
SELECT
    rm.material_name,
    rm.reorder_level AS current_reorder_level,
    srm.reorder_level AS updated_reorder_level
FROM hra.raw_materials AS rm
LEFT OUTER JOIN hra.stg_raw_materials AS srm
    ON rm.material_id = srm.material_id;


-- Q5
SELECT
    pv.sku_code AS sku,
    pv.mrp AS price,
    p.product_name
FROM hra.products AS p
RIGHT OUTER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id;


-- Q6
SELECT
    srm.material_id,
    rm.material_name,
    srm.reorder_level
FROM hra.raw_materials AS rm
RIGHT OUTER JOIN hra.stg_raw_materials AS srm
    ON rm.material_id = srm.material_id;
