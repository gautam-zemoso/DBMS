DROP SCHEMA IF EXISTS e_commerce;
CREATE SCHEMA e_commerce;
USE e_commerce;

CREATE TABLE IF NOT EXISTS country (
  country_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  country VARCHAR(50) NOT NULL,
  created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (country_id)
);

CREATE TABLE IF NOT EXISTS city (
  city_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  city VARCHAR(50) NOT NULL,
  country_id SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (city_id),
  KEY idx_fk_country_id (country_id),
  CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS address (
  address_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  district VARCHAR(20) NOT NULL,
  city_id SMALLINT UNSIGNED NOT NULL,
  postal_code VARCHAR(10) DEFAULT NULL,
  phone VARCHAR(20) NOT NULL,
    created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (address_id),
  KEY idx_fk_city_id (city_id),
  CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS suppliers(
	supplier_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	company_name VARCHAR(45) NULL,
	contact_first_name VARCHAR(45) NULL,
	contact_last_name VARCHAR(45) NULL,
	address_id SMALLINT UNSIGNED NOT NULL,
	mobile_no VARCHAR(45) NULL,
  created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY  (supplier_id),
	KEY idx_fk_address_id (address_id),
  CONSTRAINT fk_supplier_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE

);
CREATE TABLE IF NOT EXISTS customer (
  customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  email VARCHAR(50) DEFAULT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (customer_id),
  KEY idx_fk_address_id (address_id),
  CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS orders(
  order_id SMALLINT UNSIGNED NOT NULL,
  order_date DATETIME NOT NULL,
  order_status ENUM('dispatched', 'shipped', 'delivered') NOT NULL,
  delivered_date DATETIME  NULL,
  order_no SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id)
);
CREATE TABLE IF NOT EXISTS customer_order(
  customer_id SMALLINT UNSIGNED NOT NULL,
  order_id SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT uk_customer_id UNIQUE(customer_id),
  CONSTRAINT UNIQUE uk_order_id (order_id),
  
  CONSTRAINT fk_customer_order_orders FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_customer_order_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE

);
CREATE TABLE IF NOT EXISTS items(
	item_id VARCHAR(45) NOT NULL,
	supplier_id SMALLINT UNSIGNED NOT NULL,
	name VARCHAR(45) NOT NULL,
	description TEXT NULL,
  count SMALLINT UNSIGNED NULL ,
	price DECIMAL(8,2) NOT NULL,
	discount DECIMAL(4,2)  NULL,
	manufactured_date DATE NULL,
	expire_date DATE NULL,
	item_avilable  BOOLEAN NOT NULL DEFAULT TRUE,
	discount_avilable BOOLEAN NOT NULL DEFAULT FALSE,
  created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (item_id,supplier_id),
	KEY idx_fk_supplier_id (supplier_id),
	CONSTRAINT fk_items_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS order_details(
  order_id SMALLINT UNSIGNED NOT NULL,
  item_id VARCHAR(45) NOT NULL,
  quantity SMALLINT NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_fk_order_id (order_id),
  KEY idx_fk_item_id (item_id),
  CONSTRAINT fk_order_details_item FOREIGN KEY (item_id) REFERENCES items (item_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_order_details_orders FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
