-- =============================================================================
-- Script:    clean_dirty_cafe_sales.sql
-- Author:    Frank Daniel
-- Created:   2025-06-24
-- Purpose:   Load, clean, and standardize café sales data from CSV
-- Prereqs:   LOCAL_INFILE enabled; adjust file path as needed
-- =============================================================================


-- ---------------------------------------------------------------------
-- SECTION 1:  RAW STAGING TABLE DEFINITION
-- ---------------------------------------------------------------------

CREATE TABLE `dirty_cafe_sales_staging` (
    `transaction_id` TEXT,
    `item` TEXT,
    `quantity` INT DEFAULT NULL,
    `price_per_unit` DOUBLE DEFAULT NULL,
    `total_spent` TEXT,
    `payment_method` TEXT,
    `location` TEXT,
    `transaction_date` TEXT
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

CREATE TABLE dirty_cafe_sales_staging2 AS SELECT * FROM
    dirty_cafe_sales_staging;

SHOW VARIABLES LIKE 'local_infile';

-- ---------------------------------------------------------------------
-- SECTION 2:  RAW DATA LOAD
-- ---------------------------------------------------------------------

-- Table Wizard did not load all rows. To combat this, following function was used to load all data properly.
LOAD DATA LOCAL INFILE '/Users/franky/Downloads/dirty_cafe_sales.csv'
INTO TABLE dirty_cafe_sales_staging
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES;

-- ---------------------------------------------------------------------
-- SECTION 3:  STANDARDIZE MISSING / INVALID VALUES
-- ---------------------------------------------------------------------

-- Items showed inconsisent values such as '', unkwnown, or error; changed into null values
UPDATE dirty_cafe_sales_staging2 
SET 
    item = NULL
WHERE
    item LIKE 'unknown' OR item LIKE ''
        OR item LIKE 'error';

-- Items showed inconsisent values such as '', unkwnown, or error. Changed into N/A values
UPDATE dirty_cafe_sales_staging2 
SET 
    location = 'N/A'
WHERE
    location LIKE 'unknown'
        OR location LIKE 'error'
        OR location = ''
;

-- Items showed inconsisent values such as '', unkwnown, or error. Changed into N/A values
UPDATE dirty_cafe_sales_staging2 
SET 
    payment_method = 'N/A'
WHERE
    payment_method LIKE 'unknown'
        OR payment_method LIKE 'error'
        OR payment_method = ''
;

-- Found a solution to find all non date values. 
-- Tested using where, and like functions
-- Assumption: transaction_date = '0' means missing, so backfill with default date
UPDATE dirty_cafe_sales_staging2 
SET 
    transaction_date = '1900-01-01'
WHERE
    transaction_date = 0;


-- ---------------------------------------------------------------------
-- SECTION 4:  RECALCULATE TOTAL_SPENT
-- ---------------------------------------------------------------------

-- Some records had incorrect total_spent; recalc using price × quantity
UPDATE dirty_cafe_sales_staging2 
SET 
    total_spent = price_per_unit * quantity
WHERE
    total_spent != price_per_unit * quantity;

-- ---------------------------------------------------------------------
-- SECTION 5:  BACKUP & SECONDARY STAGING
-- ---------------------------------------------------------------------

-- Dropped the fprice_per_unit, quantity, and total_spent columns by mistake. Created third staging table in result
CREATE TABLE `dirty_cafe_sales_staging3` (
    `transaction_id` TEXT,
    `item` TEXT,
    `quantity` INT DEFAULT NULL,
    `price_per_unit` DOUBLE DEFAULT NULL,
    `total_spent` TEXT,
    `payment_method` TEXT,
    `location` TEXT,
    `transaction_date` TEXT
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;


INSERT INTO dirty_cafe_sales_staging3
SELECT *
FROM   dirty_cafe_sales_staging; 
-- Repeated the following steps to dirty_cafe_sales_staging3

-- ---------------------------------------------------------------------
-- SECTION 6:  TYPE CONVERSION & FINAL CLEANUP
-- ---------------------------------------------------------------------
UPDATE dirty_cafe_sales_staging3
SET 
	total_spent = Cast(total_spent AS DOUBLE); 

DELETE FROM dirty_cafe_sales_staging3 
WHERE
    item IS NULL AND total_spent = 0;

-- Formats away the TXN_ characters from transaction_id 
UPDATE dirty_cafe_sales_staging3 
SET 
    transaction_id = SUBSTRING(transaction_id, 5);

ALTER TABLE dirty_cafe_sales_staging3
  MODIFY transaction_id INT;

ALTER TABLE dirty_cafe_sales_staging3
  MODIFY total_spent DOUBLE;

UPDATE dirty_cafe_sales_staging3 
SET 
    transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y');

ALTER TABLE dirty_cafe_sales_staging3
  MODIFY COLUMN transaction_date DATE NULL;

DROP TABLE dirty_cafe_sales_staging2;

RENAME TABLE dirty_cafe_sales_staging3 TO clean_cafe_data;

RENAME TABLE dirty_cafe_sales_staging TO dirty_cafe_data_backup; 

