-- ============================================================
-- PAINTDB DATABASE
-- MICROSOFT SQL SERVER
-- ============================================================

-- CREATE DATABASE PaintDB;
-- GOGO

 USE workDB;
-- GO
create schema hra

-- ============================================================
-- 1. PRODUCTS
-- ============================================================
use schema hra
CREATE TABLE hra.products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,

    product_name VARCHAR(100) NOT NULL,

    category VARCHAR(20) NOT NULL
        CHECK (category IN ('Exterior', 'Interior', 'Dual')),

    finish_type VARCHAR(50) NOT NULL,

    binder_type VARCHAR(50) NOT NULL,

    voc_level_g_l DECIMAL(5,2) NOT NULL,

    created_at DATETIME DEFAULT GETDATE()
);
GO


-- ============================================================
-- 2. PRODUCT VARIANTS
-- ============================================================

CREATE TABLE hra.product_variants (
    variant_id INT IDENTITY(1,1) PRIMARY KEY,

    product_id INT NOT NULL,

    base_type VARCHAR(20) NOT NULL,

    pack_size_liters DECIMAL(5,2) NOT NULL,

    sku_code VARCHAR(30) NOT NULL UNIQUE,

    unit_cost DECIMAL(10,2) NOT NULL,

    mrp DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_product_variants_products
        FOREIGN KEY (product_id)
        REFERENCES hra.products(product_id)
);
GO


-- ============================================================
-- 3. RAW MATERIALS
-- ============================================================

CREATE TABLE hra.raw_materials (
    material_id INT IDENTITY(1,1) PRIMARY KEY,

    material_name VARCHAR(100) NOT NULL,

    type VARCHAR(20) NOT NULL
        CHECK (type IN ('Pigment', 'Binder', 'Solvent', 'Additive')),

    unit_of_measure VARCHAR(10) NOT NULL,

    reorder_level DECIMAL(10,2) NOT NULL,

    hazardous_flag BIT DEFAULT 0
);
GO


-- ============================================================
-- 4. FORMULAS
-- ============================================================

CREATE TABLE hra.formulas (
    formula_id INT IDENTITY PRIMARY KEY,

    product_id INT NOT NULL,

    base_type VARCHAR(20) NOT NULL,

    yield_liters DECIMAL(10,2) NOT NULL,

    version VARCHAR(10) NOT NULL,

    CONSTRAINT FK_formulas_products
        FOREIGN KEY (product_id)
        REFERENCES hra.products(product_id)
);
GO


-- ============================================================
-- 5. FORMULA ITEMS
-- ============================================================

CREATE TABLE hra.formula_items (
    formula_item_id INT IDENTITY(1,1) PRIMARY KEY,

    formula_id INT NOT NULL,

    material_id INT NOT NULL,

    quantity DECIMAL(10,4) NOT NULL,

    addition_stage VARCHAR(50) NOT NULL,

    CONSTRAINT FK_formula_items_formulas
        FOREIGN KEY (formula_id)
        REFERENCES hra.formulas(formula_id),

    CONSTRAINT FK_formula_items_raw_materials
        FOREIGN KEY (material_id)
        REFERENCES hra.raw_materials(material_id)
);
GO


-- ============================================================
-- 6. COLOR SHADES
-- ============================================================

CREATE TABLE hra.color_shades (
    shade_id INT IDENTITY(1,1) PRIMARY KEY,

    shade_code VARCHAR(20) NOT NULL UNIQUE,

    shade_name VARCHAR(100) NOT NULL,

    hex_value VARCHAR(7) NOT NULL,

    is_exterior_durable BIT NOT NULL
);
GO


-- ============================================================
-- 7. SHADE RECIPES
-- ============================================================

CREATE TABLE hra.shade_recipes (
    recipe_id INT IDENTITY(1,1) PRIMARY KEY,

    shade_id INT NOT NULL,

    product_id INT NOT NULL,

    colorant_id INT NOT NULL,

    shots_per_liter DECIMAL(8,4) NOT NULL,

    CONSTRAINT FK_shade_recipes_color_shades
        FOREIGN KEY (shade_id)
        REFERENCES hra.color_shades(shade_id),

    CONSTRAINT FK_shade_recipes_products
        FOREIGN KEY (product_id)
        REFERENCES hra.products(product_id),

    CONSTRAINT FK_shade_recipes_colorant
        FOREIGN KEY (colorant_id)
        REFERENCES hra.raw_materials(material_id)
);
GO


-- ============================================================
-- 8. BATCH PRODUCTION
-- ============================================================

CREATE TABLE hra.batch_production (
    batch_id INT IDENTITY(1,1) PRIMARY KEY,

    batch_number VARCHAR(30) NOT NULL UNIQUE,

    formula_id INT NOT NULL,

    quantity_produced DECIMAL(10,2) NOT NULL,

    manufacture_date DATE NOT NULL,

    qc_status VARCHAR(20) DEFAULT 'Pending'
        CHECK (qc_status IN ('Pending', 'Approved', 'Rejected')),

    CONSTRAINT FK_batch_production_formulas
        FOREIGN KEY (formula_id)
        REFERENCES hra.formulas(formula_id)
);
GO


-- ============================================================
-- 9. QC TEST LOGS
-- ============================================================

CREATE TABLE hra.qc_test_logs (
    log_id INT IDENTITY(1,1) PRIMARY KEY,

    batch_id INT NOT NULL,

    test_parameter VARCHAR(50) NOT NULL,

    measured_value VARCHAR(50) NOT NULL,

    passed BIT NOT NULL,

    tested_by INT NOT NULL,

    CONSTRAINT FK_qc_test_logs_batch_production
        FOREIGN KEY (batch_id)
        REFERENCES hra.batch_production(batch_id)
);



INSERT INTO hra.products
(product_name, category, finish_type, binder_type, voc_level_g_l)
VALUES
('Apex Shield', 'Exterior', 'Matte', 'Pure Acrylic', 35.00),
('Apex Shield Plus', 'Exterior', 'Satin', 'Pure Acrylic', 32.00),
('Weather Guard', 'Exterior', 'Gloss', 'Styrene Acrylic', 40.00),
('Weather Guard Pro', 'Exterior', 'Semi-Gloss', 'Pure Acrylic', 38.00),
('Rain Defence', 'Exterior', 'Matte', 'Styrene Acrylic', 42.00),
('Sun Protect', 'Exterior', 'Satin', 'Pure Acrylic', 30.00),
('Velvet Interior Pure', 'Interior', 'Matte', 'Pure Acrylic', 25.00),
('Velvet Interior Soft', 'Interior', 'Eggshell', 'Vinyl Acetate', 28.00),
('Silk Touch', 'Interior', 'Satin', 'Pure Acrylic', 30.00),
('Royal Interior', 'Interior', 'Gloss', 'Vinyl Acetate', 35.00),
('Classic Interior', 'Interior', 'Matte', 'Vinyl Acetate', 32.00),
('Elegant Walls', 'Interior', 'Eggshell', 'Pure Acrylic', 27.00),
('Universal Coat', 'Dual', 'Matte', 'Pure Acrylic', 34.00),
('Universal Shield', 'Dual', 'Satin', 'Styrene Acrylic', 36.00),
('Premium Dual Coat', 'Dual', 'Semi-Gloss', 'Pure Acrylic', 33.00),
('Pro Finish Dual', 'Dual', 'Gloss', 'Pure Acrylic', 39.00),
('Eco Paint', 'Interior', 'Matte', 'Vinyl Acetate', 20.00),
('Eco Exterior', 'Exterior', 'Matte', 'Pure Acrylic', 22.00),
('Designer Coat', 'Interior', 'Satin', 'Pure Acrylic', 26.00),
('Master Shield', 'Dual', 'Semi-Gloss', 'Pure Acrylic', 31.00);
GO


/* ============================================================
   2. product_variants — 20 rows
   ============================================================ */

INSERT INTO hra.product_variants
(product_id, base_type, pack_size_liters, sku_code, unit_cost, mrp)
VALUES
(1, 'White Base', 1.00, 'APX-001-W1', 180.00, 260.00),
(2, 'White Base', 4.00, 'APX-002-W4', 620.00, 900.00),
(3, 'Deep Base', 10.00, 'WGR-003-D10', 1450.00, 2100.00),
(4, 'Clear Base', 20.00, 'WGP-004-C20', 2700.00, 3900.00),
(5, 'White Base', 1.00, 'RDF-005-W1', 190.00, 275.00),
(6, 'Deep Base', 4.00, 'SUN-006-D4', 650.00, 950.00),
(7, 'White Base', 10.00, 'VIP-007-W10', 1250.00, 1850.00),
(8, 'White Base', 20.00, 'VIS-008-W20', 2300.00, 3300.00),
(9, 'Deep Base', 1.00, 'SLK-009-D1', 210.00, 310.00),
(10, 'Clear Base', 4.00, 'RYL-010-C4', 700.00, 1020.00),
(11, 'White Base', 10.00, 'CLS-011-W10', 1100.00, 1650.00),
(12, 'White Base', 20.00, 'ELG-012-W20', 2200.00, 3200.00),
(13, 'Deep Base', 1.00, 'UNC-013-D1', 200.00, 290.00),
(14, 'Clear Base', 4.00, 'UNS-014-C4', 680.00, 990.00),
(15, 'White Base', 10.00, 'PDC-015-W10', 1500.00, 2200.00),
(16, 'Deep Base', 20.00, 'PFD-016-D20', 3100.00, 4500.00),
(17, 'White Base', 1.00, 'ECO-017-W1', 150.00, 220.00),
(18, 'White Base', 4.00, 'ECO-018-W4', 560.00, 820.00),
(19, 'Deep Base', 10.00, 'DSG-019-D10', 1400.00, 2050.00),
(20, 'Clear Base', 20.00, 'MSH-020-C20', 2900.00, 4200.00);
GO


/* ============================================================
   3. raw_materials — 20 rows
   ============================================================ */

INSERT INTO hra.raw_materials
(material_name, type, unit_of_measure, reorder_level, hazardous_flag)
VALUES
('Titanium Dioxide', 'Pigment', 'KG', 100.00, 0),
('Calcium Carbonate', 'Pigment', 'KG', 200.00, 0),
('Yellow Iron Oxide', 'Pigment', 'KG', 50.00, 0),
('Red Iron Oxide', 'Pigment', 'KG', 50.00, 0),
('Carbon Black', 'Pigment', 'KG', 30.00, 0),
('Ultramarine Blue', 'Pigment', 'KG', 40.00, 0),
('Phthalo Blue', 'Pigment', 'KG', 35.00, 0),
('Phthalo Green', 'Pigment', 'KG', 35.00, 0),
('Pure Acrylic Resin', 'Binder', 'KG', 150.00, 0),
('Styrene Acrylic Resin', 'Binder', 'KG', 120.00, 0),
('Vinyl Acetate Resin', 'Binder', 'KG', 100.00, 0),
('Mineral Spirits', 'Solvent', 'L', 100.00, 1),
('Propylene Glycol', 'Solvent', 'L', 80.00, 0),
('Dispersing Agent', 'Additive', 'KG', 40.00, 0),
('Defoamer', 'Additive', 'KG', 25.00, 0),
('Biocide', 'Additive', 'KG', 20.00, 1),
('Thickener', 'Additive', 'KG', 35.00, 0),
('Wetting Agent', 'Additive', 'KG', 30.00, 0),
('Silicone Additive', 'Additive', 'KG', 20.00, 0),
('Preservative', 'Additive', 'KG', 25.00, 1);
GO


/* ============================================================
   4. formulas — 20 rows
   ============================================================ */

INSERT INTO hra.formulas
(product_id, base_type, yield_liters, version)
VALUES
(1, 'White Base', 1000.00, 'v1.0'),
(2, 'White Base', 1000.00, 'v1.1'),
(3, 'Deep Base', 1000.00, 'v1.0'),
(4, 'Clear Base', 1000.00, 'v2.0'),
(5, 'White Base', 500.00, 'v1.2'),
(6, 'Deep Base', 500.00, 'v1.0'),
(7, 'White Base', 1000.00, 'v2.1'),
(8, 'White Base', 1000.00, 'v1.5'),
(9, 'Deep Base', 500.00, 'v1.0'),
(10, 'Clear Base', 500.00, 'v1.2'),
(11, 'White Base', 1000.00, 'v2.0'),
(12, 'White Base', 1000.00, 'v1.1'),
(13, 'Deep Base', 500.00, 'v1.0'),
(14, 'Clear Base', 500.00, 'v1.3'),
(15, 'White Base', 1000.00, 'v2.0'),
(16, 'Deep Base', 1000.00, 'v1.0'),
(17, 'White Base', 500.00, 'v1.0'),
(18, 'White Base', 500.00, 'v1.1'),
(19, 'Deep Base', 1000.00, 'v2.0'),
(20, 'Clear Base', 1000.00, 'v1.0');
GO


/* ============================================================
   5. formula_items — 20 rows
   ============================================================ */

INSERT INTO hra.formula_items
(formula_id, material_id, quantity, addition_stage)
VALUES
(1, 1, 250.0000, 'Grinding'),
(2, 2, 300.0000, 'Grinding'),
(3, 9, 180.0000, 'Letting Down'),
(4, 10, 160.0000, 'Letting Down'),
(5, 3, 25.0000, 'Grinding'),
(6, 4, 20.0000, 'Grinding'),
(7, 5, 10.0000, 'Post-Addition'),
(8, 6, 15.0000, 'Grinding'),
(9, 7, 12.0000, 'Grinding'),
(10, 8, 10.0000, 'Post-Addition'),
(11, 9, 220.0000, 'Letting Down'),
(12, 10, 200.0000, 'Letting Down'),
(13, 11, 190.0000, 'Letting Down'),
(14, 12, 80.0000, 'Post-Addition'),
(15, 13, 75.0000, 'Post-Addition'),
(16, 14, 15.0000, 'Post-Addition'),
(17, 15, 8.0000, 'Post-Addition'),
(18, 16, 5.0000, 'Post-Addition'),
(19, 17, 12.0000, 'Post-Addition'),
(20, 18, 10.0000, 'Post-Addition');
GO


/* ============================================================
   6. color_shades — 20 rows
   ============================================================ */

INSERT INTO hra.color_shades
(shade_code, shade_name, hex_value, is_exterior_durable)
VALUES
('RAL-9001', 'Cream White', '#FDF4E3', 1),
('RAL-9010', 'Pure White', '#FDFDFD', 1),
('RAL-7016', 'Anthracite Grey', '#383E42', 1),
('RAL-5002', 'Ultramarine Blue', '#20214F', 1),
('RAL-5015', 'Sky Blue', '#2874B2', 1),
('RAL-3000', 'Flame Red', '#AF2B1E', 1),
('RAL-3020', 'Traffic Red', '#CC0605', 1),
('RAL-1014', 'Ivory', '#E1CC4F', 1),
('RAL-1015', 'Light Ivory', '#E6D690', 1),
('RAL-6005', 'Moss Green', '#2F4538', 1),
('RAL-6002', 'Leaf Green', '#276235', 1),
('RAL-8017', 'Chocolate Brown', '#45322E', 1),
('RAL-8011', 'Nut Brown', '#5A3A29', 1),
('RAL-7035', 'Light Grey', '#CBD0CC', 1),
('RAL-7040', 'Window Grey', '#9DA3A6', 1),
('RAL-3011', 'Brown Red', '#781F19', 1),
('RAL-5010', 'Gentian Blue', '#0E294B', 1),
('RAL-9005', 'Jet Black', '#0A0A0A', 1),
('RAL-1023', 'Traffic Yellow', '#FAD201', 1),
('RAL-4005', 'Blue Lilac', '#6C4675', 0);
GO


/* ============================================================
   7. shade_recipes — 20 rows
   ============================================================ */

INSERT INTO hra.shade_recipes
(shade_id, product_id, colorant_id, shots_per_liter)
VALUES
(1, 1, 3, 0.2500),
(2, 2, 1, 0.1500),
(3, 3, 5, 0.5000),
(4, 4, 6, 0.4500),
(5, 5, 7, 0.3500),
(6, 6, 4, 0.4000),
(7, 7, 4, 0.3000),
(8, 8, 6, 0.2800),
(9, 9, 3, 0.2000),
(10, 10, 8, 0.3200),
(11, 11, 8, 0.3500),
(12, 12, 4, 0.3000),
(13, 13, 4, 0.2500),
(14, 14, 2, 0.1800),
(15, 15, 2, 0.2000),
(16, 16, 4, 0.4500),
(17, 17, 6, 0.5000),
(18, 18, 5, 0.6000),
(19, 19, 3, 0.4000),
(20, 20, 7, 0.5500);
GO


/* ============================================================
   8. batch_production — 20 rows
   ============================================================ */

INSERT INTO hra.batch_production
(batch_number, formula_id, quantity_produced, manufacture_date, qc_status)
VALUES
('BATCH-2026-001', 1, 980.00, '2026-01-05', 'Approved'),
('BATCH-2026-002', 2, 995.00, '2026-01-10', 'Approved'),
('BATCH-2026-003', 3, 970.00, '2026-01-15', 'Pending'),
('BATCH-2026-004', 4, 1000.00, '2026-01-20', 'Approved'),
('BATCH-2026-005', 5, 490.00, '2026-01-25', 'Approved'),
('BATCH-2026-006', 6, 485.00, '2026-02-01', 'Rejected'),
('BATCH-2026-007', 7, 990.00, '2026-02-05', 'Approved'),
('BATCH-2026-008', 8, 980.00, '2026-02-10', 'Pending'),
('BATCH-2026-009', 9, 495.00, '2026-02-15', 'Approved'),
('BATCH-2026-010', 10, 490.00, '2026-02-20', 'Approved'),
('BATCH-2026-011', 11, 1000.00, '2026-02-25', 'Approved'),
('BATCH-2026-012', 12, 985.00, '2026-03-01', 'Pending'),
('BATCH-2026-013', 13, 480.00, '2026-03-05', 'Rejected'),
('BATCH-2026-014', 14, 500.00, '2026-03-10', 'Approved'),
('BATCH-2026-015', 15, 990.00, '2026-03-15', 'Approved'),
('BATCH-2026-016', 16, 975.00, '2026-03-20', 'Pending'),
('BATCH-2026-017', 17, 495.00, '2026-03-25', 'Approved'),
('BATCH-2026-018', 18, 490.00, '2026-04-01', 'Approved'),
('BATCH-2026-019', 19, 995.00, '2026-04-05', 'Approved'),
('BATCH-2026-020', 20, 980.00, '2026-04-10', 'Pending');
GO


/* ============================================================
   9. qc_test_logs — 20 rows
   ============================================================ */

INSERT INTO hra.qc_test_logs
(batch_id, test_parameter, measured_value, passed, tested_by)
VALUES
(1, 'Viscosity (KU)', '95 KU', 1, 101),
(2, 'Scrub Cycles', '12000', 1, 102),
(3, 'Drying Time', '4 Hours', 1, 103),
(4, 'pH', '8.2', 1, 104),
(5, 'Viscosity (KU)', '98 KU', 1, 105),
(6, 'Scrub Cycles', '7000', 0, 106),
(7, 'Drying Time', '3.5 Hours', 1, 107),
(8, 'pH', '8.5', 1, 108),
(9, 'Viscosity (KU)', '96 KU', 1, 109),
(10, 'Scrub Cycles', '11000', 1, 110),
(11, 'Drying Time', '4 Hours', 1, 111),
(12, 'pH', '8.1', 1, 112),
(13, 'Viscosity (KU)', '75 KU', 0, 113),
(14, 'Scrub Cycles', '12500', 1, 114),
(15, 'Drying Time', '3 Hours', 1, 115),
(16, 'pH', '8.3', 1, 116),
(17, 'Viscosity (KU)', '97 KU', 1, 117),
(18, 'Scrub Cycles', '11500', 1, 118),
(19, 'Drying Time', '4.5 Hours', 1, 119),
(20, 'pH', '8.4', 1, 120);

