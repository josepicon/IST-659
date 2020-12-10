-- Creating a new table 
CREATE TABLE lab_Test(
	lab_TestID int identity primary key, 
	lab_testText varchar(20) unique not null, 
) 

/* 
	This will be a table to keep a log of 
	created lab_Test records. 
	We don't want to add a row to this if the insert into 
	lab_test fails.
*/ 
CREATE TABLE lab_log ( 
	lab_LogID int identity primary key, 
	lab_loInt int unique not null
) 


INSERT INTO lab_Test (lab_testText) VALUES ('One'), ('Two'), ('Three') 
INSERT INTO lab_Log (lab_loInt) SELECT lab_TestID FROM lab_Test 




--Step 1: Begin the transaction
BEGIN TRANSACTION 
	--Step 2: Access the state of things 
	DECLARE @rc int 
	SET @rc = @@ROWCOUNT --Initially 0 

	--Step 3: Make the change 
	--On success, @@ROWCOUNT is incremental by 1 
	--On failure, @@ROWCOUNT does not change 
	INSERT INTO lab_test (lab_testText) VALUES ('Picon') 

	--Step 4: Check the new state of things 
	IF(@rc = @@ROWCOUNT)--If @@ROWCOUNT was not changed, fail 
	BEGIN 
		--Step 5, if failed 
		SELECT 'Bail out! It Failed!' 
		ROLLBACK 
	END 
	ELSE -- Success! Continue. 
	BEGIN 
		-- Step 5 if succeeded 
	SELECT 'Yay! It worked!' 
	INSERT INTO lab_Log (lab_loInt) VALUES (@@identity) 
	COMMIT 
	END 
SELECT * FROM lab_Log
SELECT * FROM lab_Test

