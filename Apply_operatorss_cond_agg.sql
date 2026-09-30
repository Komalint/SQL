use workDB


-- Q1
SELECT
    p.product_name,
    v.sku,
    v.price
FROM hra.products AS p
OUTER APPLY
(
    SELECT TOP 1
        pv.sku_code AS sku,
        pv.mrp AS price
    FROM hra.product_variants AS pv
    WHERE pv.product_id = p.product_id
    ORDER BY pv.mrp ASC
) AS v;

-- Q2

ALTER TABLE hra.stg_raw_materials
ADD tags VARCHAR(500) NULL;

UPDATE hra.stg_raw_materials
SET tags = CASE material_id
    WHEN 1 THEN 'Metal,Hazardous,Imported'
    WHEN 2 THEN 'Mineral,Domestic'
    WHEN 3 THEN 'Hazardous,Imported'
    WHEN 4 THEN 'Pigment,Domestic'
    WHEN 5 THEN 'Hazardous,Industrial'
    ELSE 'General,Domestic'
END;

SELECT
    srm.material_id,
    LTRIM(RTRIM(tag.value)) AS tag
FROM hra.stg_raw_materials AS srm
CROSS APPLY STRING_SPLIT(srm.tags, ',') AS tag;


--Q3
ALTER TABLE hra.product_variants
ADD
    status VARCHAR(20) NOT NULL
        CONSTRAINT DF_product_variants_status DEFAULT 'Active',
    stock_quantity INT NOT NULL
        CONSTRAINT DF_product_variants_stock DEFAULT 0;


UPDATE hra.product_variants
SET
    status = CASE
        WHEN variant_id IN (3, 7, 12) THEN 'Inactive'
        ELSE 'Active'
    END,
    stock_quantity = CASE
        WHEN variant_id IN (5, 10, 15) THEN 0
        ELSE 100
    END;


SELECT
    p.product_id,
    p.product_name,

    COUNT(pv.variant_id) AS total_variants,

    COUNT(
        CASE
            WHEN pv.status = 'Active'
            THEN pv.variant_id
        END
    ) AS active_variants,

    COUNT(
        CASE
            WHEN pv.stock_quantity = 0
            THEN pv.variant_id
        END
    ) AS out_of_stock_variants

FROM hra.products AS p

LEFT OUTER JOIN hra.product_variants AS pv
    ON p.product_id = pv.product_id

GROUP BY
    p.product_id,
    p.product_name;


