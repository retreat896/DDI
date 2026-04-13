-- 1. Choose a dataset from one of the databases set up for the final project. The
--    following databases are currently available:

-- a. agriculture

-- 2. Write a query to count how many rows are in the dataset. 
SELECT COUNT(*) FROM dairy."DairyData";

-- 3. Write a query to detect null values in one or more columns. 
SELECT * FROM dairy."DairyData" WHERE "watershed_code" IS NULL;

-- 4. Write a query to view the column names and data types.
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'DairyData';

-- 5. Take a screenshot of one of these queries.  */