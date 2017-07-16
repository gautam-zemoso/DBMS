
DROP SCHEMA IF EXISTS paytm;
CREATE SCHEMA IF NOT EXISTS paytm ;
USE paytm ;


CREATE TABLE city (
  city_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  city VARCHAR(50) NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (city_id)
);

CREATE TABLE IF NOT EXISTS address (
  address_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  district VARCHAR(20) NOT NULL,
  city_id SMALLINT UNSIGNED NOT NULL,
  postal_code VARCHAR(10) DEFAULT NULL,
  phone VARCHAR(20) NOT NULL,
  created_by_id INT NOT NULL, 
  created_timestamp DATETIME NOT NULL,
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (address_id),
  KEY idx_fk_city_id (city_id),
  CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS customer (
  customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  email VARCHAR(50) DEFAULT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_by_id INT NOT NULL, 
  created_timestamp DATETIME NOT NULL,
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (customer_id),
  KEY idx_fk_address_id (address_id),
  KEY idx_last_name (last_name),
  CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS branch (
  branch_name VARCHAR(255) NOT NULL,
  city_id SMALLINT UNSIGNED NOT NULL,
  IFSC VARCHAR(20) NOT NULL,
  asserts INT UNSIGNED NOT NULL,
  created_by_id INT NOT NULL, 
  created_timestamp DATETIME NOT NULL,
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (branch_name) ,
  KEY idx_fk_city_id (city_id),
  KEY idx_fk_ifsc (IFSC),
  CONSTRAINT fk_branch_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE  IF NOT EXISTS account(
  account_no INT UNSIGNED NOT NULL,
  type ENUM('saving','current','over-draft') DEFAULT 'saving',
  currency VARCHAR(45) NOT NULL ,
  opening_date DATETIME NOT NULL,
  balance INT NOT NULL,
  created_by_id INT NOT NULL, 
  created_timestamp DATETIME NOT NULL,
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (account_no)
);

CREATE TABLE IF NOT EXISTS account_branch(
  account_no INT UNSIGNED NOT NULL ,
  branch_name VARCHAR(255) NOT NULL ,
  created_by_id INT NOT NULL, 
  created_timestamp DATETIME NOT NULL,
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (account_no),
  CONSTRAINT uk_account_branch_account_no UNIQUE (account_no),
  KEY fk_account_no (account_no),
  KEY fk_branch_name(branch_name),
  CONSTRAINT fk_account_branch_branch_name FOREIGN KEY (branch_name) REFERENCES branch (branch_name) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_account_branch_account_no FOREIGN KEY (account_no) REFERENCES account (account_no) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS customer_account_branch(
  account_no INT UNSIGNED NOT NULL ,
  branch_name VARCHAR(255) NOT NULL ,
  customer_id SMALLINT UNSIGNED NOT NULL,
  created_by_id INT NOT NULL, 
  created_timestamp DATETIME NOT NULL,
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY fk_account_no (account_no),
  KEY fk_branch_name(branch_name),
  KEY fk_customer_name(customer_id),
  CONSTRAINT fk_customer_account_branch_branch FOREIGN KEY (branch_name) REFERENCES branch (branch_name) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_customer_account_branch_account FOREIGN KEY (account_no) REFERENCES account (account_no) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_customer_account_branch_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

