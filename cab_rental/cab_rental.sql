DROP SCHEMA IF EXISTS cab_rental;
CREATE SCHEMA IF NOT EXISTS cab_rental ;
USE cab_rental ;

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
  KEY idx_last_name (last_name),
  CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS driver (
  driver_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  salary INT NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (driver_id),
  KEY idx_fk_address_id (address_id),
  CONSTRAINT fk_driver_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS cab (
  cab_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  cab_name VARCHAR(50) NOT NULL,
  no_of_seats SMALLINT NOT NULL,
  rate SMALLINT NOT NULL,
  minimum_km SMALLINT NULL ,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (cab_id)
);
CREATE TABLE IF NOT EXISTS cab_driver(
  cab_id SMALLINT UNSIGNED NOT NULL,
  driver_id SMALLINT UNSIGNED NOT NULL,
  KEY idx_fk_driver_id (driver_id),
  KEY idx_fk_cab_id (cab_id),
  CONSTRAINT fk_cab_driver_driver_id FOREIGN KEY (driver_id) REFERENCES driver (driver_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_cab_driver_cab_id FOREIGN KEY (cab_id) REFERENCES cab (cab_id) ON DELETE RESTRICT ON UPDATE CASCADE
  );
CREATE TABLE booking(
	book_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  cab_id SMALLINT UNSIGNED NOT NULL,
  customer_id SMALLINT UNSIGNED NOT NULL,
	book_from VARCHAR(45) NOT NULL,
	book_to VARCHAR(45) NOT NULL,
	book_date DATETIME NOT NULL,
  PRIMARY KEY  (book_id),
  KEY idx_fk_customer_id (customer_id),
  KEY idx_fk_cab_id (cab_id),
  CONSTRAINT fk_booking_driver_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_booking_cab_id FOREIGN KEY (cab_id) REFERENCES cab (cab_id) ON DELETE RESTRICT ON UPDATE CASCADE
 
)