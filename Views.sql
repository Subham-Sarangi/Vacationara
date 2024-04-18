CREATE TRIGGER CustomerAcquired  
ON Customer  
AFTER INSERT   
AS print 'Congratulations!! A New Customer is Acquired'
GO  

drop trigger CustomerAcquired

insert into Customer(CustomerID) values ('C1600')
delete from Customer where CustomerID = 'C1600'
select * from Customer where CustomerID = 'C1600'

