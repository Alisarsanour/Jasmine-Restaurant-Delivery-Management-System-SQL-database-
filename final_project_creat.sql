Drop database if exists jasmine_restaurant; 
create database if not exists jasmine_restaurant;
use jasmine_restaurant; 

create table Customer (
customerID int auto_increment primary key, 
first_name varchar(50) not null ,
last_name varchar (50), 
Date_of_Birth Date , 
phone char (10) unique , 
email varchar (50) unique ,
password varchar (255) not null, 
gender char (1) , 
constraint check_customer_gender check (gender in ('F', 'M'))

);
CREATE TABLE Customer_Addresses (
    CustomerID INT,
    AddressType VARCHAR(50),
    CityAddress VARCHAR(50) NOT NULL,
    StreetAddress VARCHAR(50) NOT NULL,
    primary key (AddressType,CustomerID),
    constraint fk_customeradd_customer  foreign key  (CustomerID) references Customer(customerID) 
);

create table Drivers (
driverID int auto_increment primary key, 
first_name varchar(50) not null ,
last_name varchar (50), 
Date_of_Birth Date , 
phone char (10) unique , 
email varchar (50) unique ,
password varchar (255) not null, 
gender char (1) , 
constraint check_driver_gender check (gender in ('F', 'M'))
);


CREATE TABLE Menu_Items (
    ItemName VARCHAR(100) PRIMARY KEY,
    ItemCategory VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(6, 2) NOT NULL,
    CONSTRAINT chk_item_category CHECK (ItemCategory IN ('Main Dish', 'Side Dish', 'Drink', 'Dessert')),
    CONSTRAINT chk_unit_price CHECK (UnitPrice >= 0)
    
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderCustomerID INT NOT NULL,
    OrderDriverID INT,
    PredictableTime DATETIME,
    OrderPrice decimal(10, 2) NOT NULL,
    constraint fK_customer_order foreign key (OrderCustomerID)  references Customer(customerID), 
    constraint fk_driver_order foreign key (OrderDriverID) references Drivers(driverID),
    constraint pos_OrderPrice check (OrderPrice >= 0)
    ); 
    
    CREATE TABLE Order_Items (
    ItemName VARCHAR(100),
    OrderID INT,
    Quantity INT default 1 ,
    primary key (ItemName ,OrderID ),
    constraint fk_Order_Items_order foreign key (OrderID) references Orders(OrderID),
    CONSTRAINT fk_Order_Items_menu FOREIGN KEY (ItemName) REFERENCES Menu_Items(ItemName)
);

CREATE TABLE Payment_Records (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    PaymentMethod VARCHAR(30) DEFAULT 'Cash',
    AmountPaid DECIMAL(10, 2) ,
    PaymentDate DATETIME,
    constraint fk_Payment_Records_orders foreign key (OrderID) references Orders(OrderID),
    constraint pos_AmountPaid check (AmountPaid >=0),
    constraint chk_payment_method check (PaymentMethod in ('Cash', 'Credit Card', 'CliQ')) 
);

CREATE TABLE Delivery_Status (
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    DeliveryStatusName VARCHAR(50),
    UpdatedAt DATETIME,
    Notes VARCHAR(500),
    CONSTRAINT chk_delivery_status CHECK (DeliveryStatusName IN ('preparing', 'out for delivery', 'delivered', 'cancelled')),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) 
       
);

show tables;

-- creating on cascade command 
ALTER TABLE Order_Items 
DROP FOREIGN KEY fk_Order_Items_order;

ALTER TABLE Order_Items 
ADD CONSTRAINT fk_Order_Items_order 
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) 
ON DELETE CASCADE;

select * from orders; 