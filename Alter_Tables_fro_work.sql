USE workDB;
GO

ALTER TABLE hra.raw_materials
ADD
    unit_cost DECIMAL(10,2) NULL,
    quantity_in_stock DECIMAL(10,2) NULL;


ALTER TABLE hra.product_variants
ADD is_active BIT NOT NULL
    CONSTRAINT DF_product_variants_is_active DEFAULT 1;

ALTER TABLE hra.stg_raw_materials
ADD reorder_level DECIMAL(10,2) NULL;

UPDATE hra.raw_materials
SET
    unit_cost = CASE material_id
        WHEN 1 THEN 250.00
        WHEN 2 THEN 45.00
        WHEN 3 THEN 180.00
        WHEN 4 THEN 195.00
        WHEN 5 THEN 220.00
        WHEN 6 THEN 210.00
        WHEN 7 THEN 280.00
        WHEN 8 THEN 275.00
        WHEN 9 THEN 320.00
        WHEN 10 THEN 300.00
        WHEN 11 THEN 290.00
        WHEN 12 THEN 150.00
        WHEN 13 THEN 175.00
        WHEN 14 THEN 95.00
        WHEN 15 THEN 80.00
        WHEN 16 THEN 120.00
        WHEN 17 THEN 110.00
        WHEN 18 THEN 90.00
        WHEN 19 THEN 200.00
        WHEN 20 THEN 130.00
    END,
    quantity_in_stock = CASE material_id
        WHEN 1 THEN 450.00
        WHEN 2 THEN 620.00
        WHEN 3 THEN 125.00
        WHEN 4 THEN 95.00
        WHEN 5 THEN 80.00
        WHEN 6 THEN 140.00
        WHEN 7 THEN 115.00
        WHEN 8 THEN 90.00
        WHEN 9 THEN 300.00
        WHEN 10 THEN 275.00
        WHEN 11 THEN 220.00
        WHEN 12 THEN 180.00
        WHEN 13 THEN 160.00
        WHEN 14 THEN 75.00
        WHEN 15 THEN 65.00
        WHEN 16 THEN 45.00
        WHEN 17 THEN 110.00
        WHEN 18 THEN 85.00
        WHEN 19 THEN 55.00
        WHEN 20 THEN 70.00
    END;


UPDATE hra.stg_raw_materials
SET reorder_level =
    CASE material_id
        WHEN 1 THEN 100.00
        WHEN 2 THEN 150.00
        WHEN 3 THEN 50.00
        WHEN 4 THEN 40.00
        WHEN 5 THEN 30.00
        WHEN 6 THEN 50.00
        WHEN 7 THEN 40.00
        WHEN 8 THEN 35.00
        WHEN 9 THEN 80.00
        WHEN 10 THEN 75.00
        WHEN 11 THEN 70.00
        WHEN 12 THEN 60.00
        WHEN 13 THEN 50.00
        WHEN 14 THEN 25.00
        WHEN 15 THEN 20.00
        WHEN 16 THEN 15.00
        WHEN 17 THEN 35.00
        WHEN 18 THEN 30.00
        WHEN 19 THEN 20.00
        WHEN 20 THEN 25.00
    END;


