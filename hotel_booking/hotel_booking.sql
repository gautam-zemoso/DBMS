DROP SCHEMA IF EXISTS hotel_booking;
CREATE SCHEMA IF NOT EXISTS hotel_booking ;
USE hotel_booking ;

CREATE TABLE IF NOT EXISTS loyal_customer(
  registration_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (registration_id)
);
CREATE TABLE IF NOT EXISTS customer (
  customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  email VARCHAR(50) DEFAULT NULL,
  address VARCHAR(200)  NULL,
  registration_id SMALLINT UNSIGNED NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (customer_id),
  KEY idx_fk_last_name (registration_id),
  CONSTRAINT fk_customer_registration FOREIGN KEY (registration_id) REFERENCES loyal_customer (registration_id) ON DELETE RESTRICT ON UPDATE CASCADE

);

CREATE TABLE IF NOT EXISTS hotels(
  hotel_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  rating ENUM('G','VG','A','E') DEFAULT 'G',
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (hotel_id),
  KEY idx_address_id (name)
);


CREATE TABLE IF NOT EXISTS booking(
  booking_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id SMALLINT UNSIGNED NOT NULL,
  hotel_id SMALLINT UNSIGNED NOT NULL,
  booking_date DATETIME NOT NULL ,
  arrival_date DATETIME NOT NULL ,
  departure_date DATETIME NOT NULL ,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (booking_id),
  KEY idx_fk_hotel_id (hotel_id),
  CONSTRAINT UNIQUE uk_customer_id(customer_id),
  CONSTRAINT fk_hotel_customer_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_hotel_customer_hotels FOREIGN KEY (hotel_id) REFERENCES hotels (hotel_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
