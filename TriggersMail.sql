DELETE from Customer where customerID IN ('C1001')

INSERT INTO Customer (CustomerID, [Full Name], Gender, Age, Location, [ContactNumber], Email, Spendings)
VALUES ('C1001', 'Anya', 'F',  4, 'Delhi', 2345465768, 'Anya.C1001@vac.com', 34567);

select * from Customer 

--	Welcome message
CREATE TRIGGER trgCustomerAcquired  
ON Customer  
AFTER INSERT   
AS print 'Congratulations!! A New Customer is Acquired';
-- DROP TRIGGER trgCustomerAcquired

-- Trigger to maintain log
CREATE TABLE CustLog(
	LogID int IDENTITY(1,1) NOT NULL,
	CustomerID varchar(10) NOT NULL,
	Operation nvarchar(10) NOT NULL,
	UpdatedDate Datetime NOT NULL	
)

CREATE TRIGGER dbo.trgCustomerInsert
ON Customer
FOR INSERT	
AS
    INSERT INTO CustLog(CustomerID, Operation, UpdatedDate)
    SELECT CustomerID ,'INSERT',GETDATE() FROM INSERTED;
CREATE TRIGGER trgCustomerUpdate
ON Customer
AFTER UPDATE
AS
    INSERT INTO CustLog(CustomerID, Operation, UpdatedDate)
    SELECT CustomerID,'UPDATE', GETDATE() FROM DELETED;

CREATE TRIGGER trgCustomerDelete 
ON Customer
INSTEAD OF DELETE
AS
    INSERT INTO CustLog(CustomerID, Operation, UpdatedDate)
    SELECT CustomerID,'DELETE', GETDATE() FROM DELETED;
-- DROP TRIGGER trgCustomerDelete


CREATE TRIGGER trgCustomerMail  
ON Customer
AFTER INSERT   
AS  
DECLARE @ID AS NVARCHAR(10) = (SELECT TOP 1 CustomerID FROM Customer ORDER BY CustomerID DESC)
DECLARE @NEW AS NVARCHAR(50) = (SELECT TOP 1 [Full Name] FROM Customer ORDER BY CustomerID DESC)
DECLARE @BODY AS NVARCHAR(MAX) =  CONCAT('Welcome ', CONVERT(NVARCHAR(MAX),@NEW),'!! Congratulations. You are eligible for a 20% off on your first spending. To avail the offer log in using your ID(',@ID,'). Hope you will have fun with us.')
DECLARE @MailID AS NVARCHAR(50) = (SELECT TOP 1 Email FROM Customer ORDER BY CustomerID DESC)
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Subham',  
    @recipients = @MailID,  
    @body = @BODY,  
    @subject = 'Alert: New Customer';


CREATE TRIGGER trgCustomerMailUpdate 
ON Customer
AFTER UPDATE   
AS  
DECLARE @NEW AS NVARCHAR(50) = (SELECT TOP 1 [Full Name] FROM Customer ORDER BY CustomerID DESC)
DECLARE @BODY AS NVARCHAR(MAX) =  CONCAT('Hey ', CONVERT(NVARCHAR(MAX),@NEW),'!!. Your information are updated successfully. If not done by you kindly reach out to us as soon as possible')
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Subham',  
    @recipients = 'subham2799@outlook.com',  
    @body = @BODY,  
    @subject = 'Alert: Customer Data Update';


---- To Test
-- DROP TRIGGER trgCustomerMailUpdate
INSERT INTO Customer(CustomerID,[Full Name],Email) VALUES ('C1600','Subham','subham2799@outlook.com');
UPDATE Customer SET Age = 26 WHERE CustomerID='C1600';
DELETE FROM Customer WHERE CustomerID = 'C1600';

SELECT * FROM CustLog
-- TRUNCATE TABLE CustLog