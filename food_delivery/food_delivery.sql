DROP SCHEMA IF EXISTS food_delivery;
CREATE SCHEMA food_delivery;
USE food_delivery;

CREATE TABLE IF NOT EXISTS address (
  address_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  district VARCHAR(20) NOT NULL,
  city VARCHAR(50) NOT NULL,
  postal_code VARCHAR(10) DEFAULT NULL,
  phone VARCHAR(20) NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (address_id),
  KEY idx_city (city)
 );

CREATE TABLE IF NOT EXISTS customer (
  customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  email VARCHAR(50) DEFAULT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  create_date DATETIME NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (customer_id),
  KEY idx_fk_address_id (address_id),
  KEY idx_last_name (last_name),
  CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS delivery_person(
  delivery_person_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NULL,
  last_name VARCHAR(45) NULL,
  mobile_no VARCHAR(45) NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (delivery_person_id),
  KEY idx_last_name (last_name)
);
CREATE TABLE IF NOT EXISTS resturants(
  resturant_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  restruant_name VARCHAR(45) NULL,
  rating ENUM('G','VG','A','E') DEFAULT 'G',
  address_id SMALLINT UNSIGNED NOT NULL,
  contact_no VARCHAR(45) NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (resturant_id),
  KEY idx_fk_address_id (address_id),
  CONSTRAINT fk_resturant_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE

);
CREATE TABLE IF NOT EXISTS orders(
  order_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  items VARCHAR(80) NOT NULL,
  order_date DATETIME NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS resturant_customers_orders(
  resturant_id SMALLINT UNSIGNED NOT NULL ,
  customer_id SMALLINT UNSIGNED NOT NULL ,
  order_id SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_fk_customer_id (customer_id),
  KEY idx_fk_order_id (order_id),
  KEY idx_fk_resturant_id (resturant_id),
  CONSTRAINT fk_resturant_customers_orders_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_resturant_customers_orders_resturant FOREIGN KEY (resturant_id) REFERENCES resturants (resturant_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_resturant_customers_orders_order FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS delivery_order(
    order_id SMALLINT UNSIGNED NOT NULL,
    delivery_person_id SMALLINT UNSIGNED NOT NULL,
    created_timestamp DATETIME NOT NULL, 
    created_by_id INT NOT NULL, 
    modified_by_id INT DEFAULT NULL, 
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_fk_order_id (order_id),
    KEY ide_fk_delivery_person_id (delivery_person_id),
    CONSTRAINT fk_delivery_order_order FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_delivery_order_delivery_person FOREIGN KEY (delivery_person_id) REFERENCES delivery_person (delivery_person_id) ON DELETE RESTRICT ON UPDATE CASCADE
);