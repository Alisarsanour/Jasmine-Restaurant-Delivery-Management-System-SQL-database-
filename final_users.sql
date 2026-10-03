
-- identifying admin user 
select user (); 
drop user if exists 'admin'@'localhost'; 
create user if not exists 'admin'@'localhost'
identified by '123@admin'; 
--  give all the provileges to the admin 
GRANT ALL PRIVILEGES ON jasmine_restaurant.* TO 'admin'@'localhost';
show grants for 'admin'@'localhost'; 
FLUSH PRIVILEGES;

-- crearting a user for driver 
select user (); 
drop user if exists 'driver'@'localhost'; 
create user if not exists 'driver'@'localhost'
identified by '456@driver'; 

-- driver Privileges 
grant select on jasmine_restaurant.vw_active_deliveries 
to 'driver'@'localhost';
grant execute on procedure  jasmine_restaurant.p_AssignDriverToOrder 
to 'driver'@'localhost';
grant select, update on jasmine_restaurant.delivery_status 
to 'driver'@'localhost';
show grants for 'driver'@'localhost';


-- crearting a user for customer  
select user (); 
drop user if exists 'customer'@'localhost'; 
create user if not exists 'customer'@'localhost' identified by '789@customer';

grant select on jasmine_restaurant.menu_items 
to 'customer'@'localhost';
grant select on jasmine_restaurant.vw_customer 
to 'customer'@'localhost';
grant select on jasmine_restaurant.vw_Order_Bill_Details 
to 'customer'@'localhost';
grant execute on procedure jasmine_restaurant.p_new_customer_order 
to 'customer'@'localhost';
show grants for 'customer'@'localhost';










-- online sql code to make the php see the admin user 
ALTER USER 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY '123@admin';


GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;


CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED WITH mysql_native_password BY '123@admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';


FLUSH PRIVILEGES;