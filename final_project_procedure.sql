use  jasmine_restaurant; 

-- first procedure 
--  Assign Driver To Order (it includes updating the dilevery status and update time)
drop procedure if exists p_AssignDriverToOrder; 
DELIMITER $$ 
create  procedure  p_AssignDriverToOrder (in p_orderID int  , in p_driverID int )
begin
update orders
set OrderDriverID = p_driverID 
where p_orderID = OrderID; 

update delivery_status
set DeliveryStatusName = 'out for delivery',
UpdatedAt = now()
where OrderID = p_orderID; 
 

end $$
delimiter ; 

call p_AssignDriverToOrder (3 , 2); 
select o.OrderID , o.OrderDriverID , d.first_name, ds.DeliveryStatusName , ds.UpdatedAt
from orders o 
join delivery_status ds on ds.OrderID = o.OrderID
join drivers d on d.driverID = o.OrderDriverID
 where  OrderDriverID = 2; 
 
 -- the second procdure 
 -- customer order a new order 
 
drop procedure if exists p_new_customer_order; 
delimiter $$
create procedure p_new_customer_order
(in p_customerid int , in P_PredictableTime datetime , in  p_OrderPrice decimal(10,2) , in p_PaymentMethod varchar(30) 
, in p_AmountPaid decimal(10,2) , in p_ItemName varchar(100) )
begin

declare p_newOrderID int ;  -- identefying a variable in a procedure scope 

insert into orders (OrderCustomerID ,OrderDriverID , PredictableTime , OrderPrice) values 
(p_customerid , null , P_PredictableTime , p_OrderPrice ); 

SET p_newOrderID = LAST_INSERT_ID(); 
 insert into payment_records (OrderID ,PaymentMethod  , AmountPaid) values 
 (p_newOrderID , p_PaymentMethod , p_AmountPaid );
 
 insert into order_items (ItemName , OrderID) values
 (p_ItemName , p_newOrderID);
 
 INSERT INTO Delivery_Status (OrderID, DeliveryStatusName, UpdatedAt)
    VALUES (p_newOrderID, 'preparing', NOW()); 
end $$
delimiter ; 

-- try the procedure 
call p_new_customer_order (1, '2026-09-05 17:30:00', 12.50, 'CliQ', 12.50, 'Arabic Salad'); 

-- checking the results 
select  o.OrderID , o.OrderCustomerID , o.PredictableTime , o.OrderPrice , 
p.PaymentID , p.PaymentMethod , p.AmountPaid,
i.ItemName , ds.DeliveryStatusName , ds.UpdatedAt 
from orders o 
join payment_records p  on o.OrderID = p.OrderID
join order_items  i on o.OrderID = i.OrderID
join Delivery_Status ds on o.OrderID = ds.OrderID
where ds.DeliveryStatusName = 'preparing'; 



-- the third procedure 
-- update the price 
drop procedure if exists p_UpdateMenuItemPrice; 
delimiter $$
create procedure p_UpdateMenuItemPrice 
(in p_ItemName VARCHAR(100) , in p_UnitPrice DECIMAL(6, 2) )
begin 
update menu_items 
set UnitPrice = p_UnitPrice 
where ItemName = p_ItemName; 
end $$
delimiter ;

CALL p_UpdateMenuItemPrice('Chicken Shawarma Meal', 6.75);
SELECT ItemName, ItemCategory, UnitPrice 
FROM Menu_Items 
WHERE ItemName = 'Chicken Shawarma Meal';



-- the fourth procedure
-- Count total orders for a specific customer
DROP PROCEDURE IF EXISTS p_GetCustomerOrderCount;

DELIMITER $$
CREATE PROCEDURE p_GetCustomerOrderCount (IN p_CustomerID INT,OUT p_OrderCount INT)
BEGIN
    SELECT COUNT(*)
    INTO p_OrderCount
    FROM Orders
    WHERE OrderCustomerID = p_CustomerID;
END $$
DELIMITER ;

CALL p_GetCustomerOrderCount(1, @total_orders);

SELECT @total_orders AS 'Total Orders Placed';


-- some simple commands 

-- using select with where 
select * from orders where OrderPrice > 10; 

select PaymentMethod , count(PaymentMethod) from payment_records
group by PaymentMethod; 

