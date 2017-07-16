
DROP SCHEMA IF EXISTS imdb ;
CREATE SCHEMA imdb;
USE imdb;

CREATE TABLE language (
  language_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name CHAR(20) NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (language_id)
);

CREATE TABLE actor (
  actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (actor_id),
  KEY idx_actor_last_name (last_name)
);

CREATE TABLE movie (
  movie_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  release_year YEAR DEFAULT NULL,
  language_id TINYINT UNSIGNED NOT NULL,
  length SMALLINT UNSIGNED  NULL,
  rating ENUM('A','G','VG','E') DEFAULT 'G',
  special_features SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (movie_id),
  KEY idx_title (title),
  KEY idx_fk_language_id (language_id),
  CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE movie_actor (
  actor_id SMALLINT UNSIGNED NOT NULL,
  movie_id SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (actor_id,movie_id),
  KEY idx_fk_movie_id (movie_id),
  CONSTRAINT fk_movie_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_movie_actor_film FOREIGN KEY (movie_id) REFERENCES movie (movie_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE tv_series (
  tv_series_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT  NULL,
  release_year YEAR  NULL,
  language_id TINYINT UNSIGNED NOT NULL,
  status ENUM('completed','not completed') DEFAULT 'not completed',
  rating ENUM('A','G','VG','E') DEFAULT 'G',
  special_features SET('Thriller','supernatural','science','mature','history') DEFAULT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (tv_series_id),
  KEY idx_title (title),
  KEY idx_fk_language_id (language_id),
  CONSTRAINT fk_tv_series_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE episode(
    episode_no SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    tv_series_id SMALLINT UNSIGNED NOT NULL ,
    title VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL,
    created_timestamp DATETIME NOT NULL, 
    created_by_id INT NOT NULL, 
    modified_by_id INT DEFAULT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (episode_no,tv_series_id),
    KEY idx_title (title),
    CONSTRAINT fk_season_tv_series FOREIGN KEY (tv_series_id) REFERENCES tv_series (tv_series_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE tv_series_actor (
  actor_id SMALLINT UNSIGNED NOT NULL,
  tv_series_id SMALLINT UNSIGNED NOT NULL,
  created_timestamp DATETIME NOT NULL, 
  created_by_id INT NOT NULL, 
  modified_by_id INT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (actor_id,tv_series_id),
  KEY idx_fk_tv_series_id (tv_series_id),
  CONSTRAINT fk_tv_series_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_tv_series_actor_tv_series FOREIGN KEY (tv_series_id) REFERENCES tv_series (tv_series_id) ON DELETE RESTRICT ON UPDATE CASCADE
);