DROP SCHEMA IF EXISTS ticket_booking;
CREATE SCHEMA IF NOT EXISTS ticket_booking ;
USE ticket_booking ;

CREATE TABLE IF NOT EXISTS train (
  train_no INT UNSIGNED NOT NULL ,
  train_name VARCHAR(50) NOT NULL,
  train_type VARCHAR(50) NOT NULL,
  class_avilable VARCHAR(40)  NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (train_no)
);

CREATE TABLE IF NOT EXISTS route (
	train_no INT UNSIGNED NOT NULL ,
	station_id INT UNSIGNED NOT NULL,
	station_name VARCHAR(50) NOT NULL,
  	arr_time DATETIME NOT NULL ,
  	depart_name DATETIME NOT NULL,
  	stop_no SMALLINT UNSIGNED NOT NULL,
  	created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
  	last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	PRIMARY KEY  (station_id),
  	KEY idx_fk_train_no (train_no),
  	CONSTRAINT fk_route_train FOREIGN KEY (train_no) REFERENCES train (train_no) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ticket(
	ticket_id INT UNSIGNED NOT NULL,
	pnr_no INT UNSIGNED NOT NULL ,
	status ENUM('reserved','unreserved') NOT NULL,
	class ENUM('AC-1','AC-2','Sleeper') NULL,
	ticket_from VARCHAR(50) NOT NULL,
	ticket_to VARCHAR(50) NOT NULL,
	total_fair INT NULL,
	doj DATETIME NULL,
	created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
	last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ticket_id)
);


CREATE TABLE IF NOT EXISTS customer (
  customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  gender ENUM('male','femal') NULL,
  type ENUM('child','normal','senior citizen','vip') NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL, 
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (customer_id),
  KEY idx_last_name (last_name)
);

CREATE TABLE IF NOT EXISTS customer_unreserved_ticket(
	ticket_id INT UNSIGNED NOT NULL,
	customer_id SMALLINT UNSIGNED NOT NULL,
	created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY idx_fk_customer_id (customer_id),
	KEY idx_fk_ticket_id (ticket_id),
	CONSTRAINT fk_customer_unreserved_ticket_ticket FOREIGN KEY (ticket_id) REFERENCES ticket (ticket_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_customer_unreserved_ticket_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS customer_reserved_train_ticket(
	ticket_id INT UNSIGNED NOT NULL,
	customer_id SMALLINT UNSIGNED NOT NULL,
	train_no INT UNSIGNED NOT NULL,
	created_timestamp DATETIME NOT NULL, 
	created_by_id INT NOT NULL, 
	modified_by_id INT DEFAULT NULL, 
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY idx_fk_customer_id (customer_id),
	KEY idx_fk_ticket_id (ticket_id),
	KEY idx_fk_train_no (train_no),
	CONSTRAINT fk_customer_reserved_train_ticke_ticket FOREIGN KEY (ticket_id) REFERENCES ticket (ticket_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_customer_reserved_train_ticke_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_customer_reserved_train_ticke_train FOREIGN KEY (train_no) REFERENCES train (train_no) ON DELETE RESTRICT ON UPDATE CASCADE
);

