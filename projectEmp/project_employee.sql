DROP SCHEMA IF EXISTS Project_Employee;
CREATE SCHEMA Project_Employee;
USE Project_Employee;


CREATE TABLE IF NOT EXISTS city (
  city_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  city VARCHAR(50) NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (city_id),
  KEY idx_city (city)
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


CREATE TABLE IF NOT EXISTS employee (
  employee_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  sex ENUM('male', 'female') DEFAULT 'male',
  age SMALLINT UNSIGNED NOT NULL ,
  email VARCHAR(50)  DEFAULT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  join_date DATETIME NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (employee_id),
  KEY idx_last_name (last_name),
  CONSTRAINT fk_employee_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE

);

CREATE TABLE IF NOT EXISTS supervisor(
  manager_id SMALLINT UNSIGNED NOT NULL,
  employee_id SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_fk_employee_id(employee_id),
  CONSTRAINT fk_superviser_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE  IF NOT EXISTS project (
  project_id INT NOT NULL AUTO_INCREMENT,
  project_name VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  status ENUM('completed', 'partially completed','started') DEFAULT 'started',
  deadline DATETIME NOT NULL,
  start_at DATETIME NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (project_id),
  KEY idx_project_name(project_name)
);

CREATE TABLE IF NOT EXISTS  works_on (
  employee_id SMALLINT UNSIGNED NOT NULL,
  project_id INT NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_fk_project_id(project_id),
  KEY idx_fk_employee_id(employee_id),
  CONSTRAINT fk_works_on_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_work_on_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE RESTRICT ON UPDATE CASCADE
);