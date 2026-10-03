use jasmine_restaurant; 


insert into  customer (first_name, last_name , Date_of_Birth , phone, email , password , gender) values 
('Ahmad', 'Al-Sayed', '1995-04-12', '0791234567', 'ahmad.sayed@gmail.com', 'CustPass123', 'M'),
('Sarah', 'Mansour', '1998-09-23', '0782345678', 'sarah.mansour@yahoo.com', 'CustPass123', 'F'),
('Omar', 'Khatib', '2001-01-15', '0773456789', 'omar.khatib@outlook.com', 'CustPass123', 'M'),
('Noor', 'Haddad', '1992-11-05', '0794567890', 'noor.haddad@gmail.com', 'CustPass123', 'F'),
('Sami', 'solami', null, '0794567660', 'Sami.solami@gmail.com', 'CustPass123', 'M'),
('Nora', null, '1992-11-05', null, null, 'CustPass123', null);
 desc customer ; 
 select*  from customer ; 


INSERT INTO Customer_Addresses (CustomerID, AddressType, CityAddress, StreetAddress) VALUES
(1, 'Home', 'Amman', 'Al-Madina Al-Monawara St, Bldg 14'),
(1, 'Work', 'Amman', 'King Hussein Business Park, Bldg 8'),
(2, 'Home', 'Amman', 'Abdoun Circle, Villa 5'),
(3, 'Home', 'Zarqa', '36th Street, Apt 3'),
(4, 'Work', 'Amman', 'Mecca Street, Floor 2'),
(5, 'Home', 'Amman', 'Al-Jubaiha, St 10');
 desc Customer_Addresses ; 
  select*  from Customer_Addresses ; 
  
  INSERT INTO Drivers (First_Name, Last_Name, Date_of_Birth, Phone, Email, Password, Gender) VALUES
('Tariq', 'Qasim', '1994-03-10', '0795551122', 'tariq.driver@jasmine.com', 'DriverPass123', 'M'),
('Khaled', 'Najjar', '1996-07-18', '0786662233', 'khaled.driver@jasmine.com', 'DriverPass123', 'M'),
('Zaid', 'Othman', '1999-12-01', '0777773344', 'zaid.driver@jasmine.com', 'DriverPass123', 'M'),
('Mustafa', NULL, NULL, '0798889900', 'mustafa.driver@jasmine.com', 'DriverPass123', 'M'),
('Hassan', 'Ali', '1997-05-20', NULL, NULL, 'DriverPass123', NULL);
 desc Drivers ; 
  select*  from Drivers ; 
 
INSERT INTO Menu_Items (ItemName, ItemCategory, UnitPrice) VALUES
('Mansaf Platter', 'Main Dish', 12.50),
('Chicken Shawarma Meal', 'Main Dish', 6.00),
('Arabic Salad', 'Side Dish', 2.50),
('French Fries', 'Side Dish', 1.50),
('Fresh Orange Juice', 'Drink', 2.00),
('Mineral Water', 'Drink', 0.75),
('Knafeh Plate', 'Dessert', 3.50);
 desc Menu_Items ; 
  select*  from Menu_Items ; 
  
INSERT INTO Orders (OrderCustomerID, OrderDriverID, PredictableTime, OrderPrice) VALUES
(1, 1, '2026-09-01 13:45:00', 17.00),
(1, 2, '2026-09-02 19:30:00', 8.50),
(2, 1, '2026-09-02 20:15:00', 14.50),
(3, 2, '2026-09-03 14:00:00', 6.75),
(5, NULL, NULL, 12.50);
 desc Orders ; 
  select*  from Orders ; 
  
  INSERT INTO Order_Items (ItemName, OrderID, Quantity) VALUES
('Mansaf Platter', 1, 1),
('Arabic Salad', 1, 1),
('Fresh Orange Juice', 1, 1),
('Chicken Shawarma Meal', 2, 1),
('French Fries', 2, 1),
('Fresh Orange Juice', 2, 1),
('Mansaf Platter', 3, 1),
('Fresh Orange Juice', 3, 1),
('Chicken Shawarma Meal', 4, 1),
('Mineral Water', 4, 1),
('Mansaf Platter', 5, 1);

  INSERT INTO Order_Items (ItemName, OrderID, Quantity) VALUES
  ('Mineral Water', 1, 2);
 desc Order_Items ; 
  select*  from Order_Items ; 
  
  INSERT INTO Payment_Records (OrderID, PaymentMethod, AmountPaid, PaymentDate) VALUES
(1, 'Cash', 17.00, '2026-09-01 13:50:00'),
(2, 'CliQ', 8.50, '2026-09-02 19:05:00'),
(3, 'Credit Card', 14.50, '2026-09-02 19:50:00'),
(4, 'Cash', 6.75, '2026-09-03 13:35:00'),
(5, 'Cash', null, '2026-09-03 14:10:00');

 desc Payment_Records ; 
  select*  from Payment_Records ;
  
  INSERT INTO Delivery_Status (OrderID, DeliveryStatusName, UpdatedAt, Notes) VALUES
(1, 'delivered', '2026-09-01 13:55:00', 'Delivered to customer doorstep successfully.'),
(2, 'out for delivery', '2026-09-02 19:20:00', 'Driver is near the destination.'),
(3, 'preparing', '2026-09-02 20:00:00', NULL), -- No specific notes
(4, 'cancelled', '2026-09-03 13:40:00', 'Cancelled upon customer phone request.'),
(5, 'preparing', '2026-09-03 14:15:00', NULL);
desc Delivery_Status ; 
  select*  from Delivery_Status ;
  
  
  
-- creating the viwes 
-- first viwe for admin 
drop view if exists vw_Admin_Order_Summary;
create view vw_Admin_Order_Summary  as 
select o.OrderID, c.customerID , c.first_name  as 'customer first name' , d.driverID , d.first_name as 'driver first name'
from customer c
join orders o on c.customerID = o.OrderCustomerID
join drivers d on o.OrderDriverID = d.driverID;

SELECT * FROM vw_Admin_Order_Summary;


-- second viwe for drivers  
-- will connect order customer customer address pyment recored 
-- for drivers and just shows uncacled or dilivered orders 
drop view if exists vw_Active_Deliveries ; 
create view vw_Active_Deliveries as 
select  d.driverID , d.first_name as 'first name driver' , c.first_name as 'first name customer', 
 c.phone as 'customer phone', o.OrderID , o.OrderPrice , p.PaymentMethod , p.AmountPaid
from customer c
join orders  o on c.customerID = o.OrderCustomerID
left join drivers d on d.driverID = o.OrderDriverID
left join  payment_records p on  p.OrderID = o.OrderID
join  delivery_status ds on ds.OrderID = o.OrderID
where ds.DeliveryStatusName in ('preparing', 'out for delivery'); 
-- 'preparing', 'out for delivery', 'delivered', 'cancelled'
select * from vw_Active_Deliveries; 
desc delivery_status; 


-- Third viwe 

DROP VIEW IF EXISTS vw_Order_Bill_Details;
CREATE VIEW vw_Order_Bill_Details AS
SELECT o.OrderID, i.ItemName , m.ItemCategory, i.Quantity, m.UnitPrice
from orders o 
join order_items i on o.OrderID = i.OrderID 
join menu_items m on m.ItemName = i.ItemName; 

select  * FROM vw_Order_Bill_Details;



-- the forth viwe  


-- coudtomer dilevary status order item order 
DROP VIEW IF EXISTS vw_customer;
CREATE VIEW vw_customer AS
select o.OrderID ,c.first_name , c.last_name , d.first_name as 'driver name' , d.phone as 'driver phone number' , 
ds.DeliveryStatusName  , ds.UpdatedAt , i.ItemName , i.Quantity
from customer c
join orders  o on c.customerID = o.OrderCustomerID
join order_items i  on  o.OrderID = i.OrderID 
join delivery_status ds on  ds.OrderID = o.OrderID
left join drivers d on d.driverID = o.OrderDriverID; 

select * from vw_customer ; 