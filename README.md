# Jasmine-Restaurant-Delivery-Management-System-SQL-database-
MySQL, Relational Database Design (3NF), Stored Procedures, Views, RBAC, PHP


# 🍽️ Jasmine Restaurant — Relational Delivery Management Database System

An enterprise-grade relational database solution engineered to replace manual spreadsheets and paper records with a scalable, transactional, and secure delivery management platform[cite: 15]. Designed and implemented using MySQL Workbench with full normalization up to 3NF, automated procedural logic, role-based access security, and an interactive PHP administrative console[cite: 11, 14, 15].

📄 **[View Full Technical Documentation (PDF)](./Jasmine_Database_Report.pdf)**

---

## 📌 Architecture & Key Specifications
* **Database Engine:** MySQL 8.0+ / MySQL Workbench[cite: 14, 15]
* **Relational Schema:** 8 normalized tables governing core operations[cite: 14, 15].
* **Normalization Level:** Fully compliant with Third Normal Form (3NF)[cite: 15].
* **Automation:** 4 Stored Procedures managing transactional integrity[cite: 12, 15].
* **Abstraction & Reporting:** 4 multi-table JOIN views for dispatching and billing[cite: 13, 15].
* **Security Model:** Role-Based Access Control (RBAC) following the Principle of Least Privilege[cite: 11, 15].
* **Application Interface:** PHP web-based administration console[cite: 11, 15].

---

## 🗄️ Database Schema & Normalization (3NF)
The relational schema resolves complex multi-valued and composite business rules through formal normalization[cite: 15]:
1. **1NF:** Removed repeating attributes and enforced atomicity by decomposing full names into `first_name` and `last_name`, converting complex customer addresses into a dedicated relation (`Customer_Addresses`), and isolating multi-item baskets into `Order_Items`[cite: 15].
2. **2NF:** Eliminated partial functional dependencies within composite-key relations; decoupled item pricing and categories from `Order_Items` into a distinct `Menu_Items` catalog[cite: 15].
3. **3NF:** Removed transitive dependencies across operational tables; decoupled courier and customer contact records from central orders so attributes strictly depend on primary keys[cite: 15].

### Core Relational Tables:
* `Customer` & `Customer_Addresses`: Multi-destination address management with composite PKs[cite: 14, 15].
* `Drivers`: Fleet and courier personnel roster[cite: 14, 15].
* `Menu_Items`: Food catalog with category and price constraints[cite: 14, 15].
* `Orders`: Central transaction ledger linking customers, drivers, and delivery schedules[cite: 14, 15].
* `Order_Items`: Junction table resolving M:N relationship between orders and menu items[cite: 14, 15].
* `Payment_Records`: Enforces strict 1:1 financial reconciliations (Cash, Credit Card, CliQ)[cite: 14, 15].
* `Delivery_Status`: Real-time order tracking (`preparing`, `out for delivery`, `delivered`, `cancelled`)[cite: 14, 15].

---

## ⚙️ Stored Procedures & Business Logic
* **`p_new_customer_order`**: Orchestrates transactional order placements using `LAST_INSERT_ID()` across orders, item rosters, payment ledgers, and tracking timestamps[cite: 12, 15].
* **`p_AssignDriverToOrder`**: Assigns an available driver to an order and transitions status to `'out for delivery'` with dynamic timestamp updates (`NOW()`)[cite: 12, 15].
* **`p_UpdateMenuItemPrice`**: Safely modifies dish prices within the menu catalog with operational scoping[cite: 12, 15].
* **`p_GetCustomerOrderCount`**: Computes customer lifetime order counts using output parameters[cite: 12, 15].

---

## 🔍 Relational Views
* **`vw_Active_Deliveries`**: Real-time dispatch console for couriers filtering only pending transit routes while hiding sensitive credentials[cite: 13, 15].
* **`vw_Admin_Order_Summary`**: Central management dashboard joining customer, courier, and order records[cite: 13, 15].
* **`vw_Order_Bill_Details`**: Itemized invoice breakdown matching item quantities with unit pricing[cite: 13, 15].
* **`vw_customer`**: Real-time customer delivery status tracking with outer join fault tolerance[cite: 13, 15].

---

## 🔒 Security & Role-Based Access Control (RBAC)
Strict implementation of the **Principle of Least Privilege**[cite: 15]:
* **Admin (`admin@localhost`)**: Unrestricted schema and DDL/DML operational access[cite: 11, 15].
* **Driver (`driver@localhost`)**: Restricted read access to `vw_active_deliveries`, execution privilege on `p_AssignDriverToOrder`, and isolated status updates on `delivery_status`[cite: 11, 15].
* **Customer (`customer@localhost`)**: Read access to menu catalogs and bill views, with execution rights strictly isolated to `p_new_customer_order`[cite: 11, 15].

---
