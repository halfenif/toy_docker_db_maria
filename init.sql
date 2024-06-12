/* char-set */
SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

/* create db and user */
CREATE DATABASE database;
CREATE USER 'user'@'%' IDENTIFIED BY 'user';
GRANT ALL PRIVILEGES ON database.* TO 'user'@'%';
FLUSH PRIVILEGES;
USE database;



/* Function uuidv7 */
DELIMITER $$
CREATE DEFINER = CURRENT_USER FUNCTION `uuidv7` () RETURNS UUID LANGUAGE SQL NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER
COMMENT 'Generate a UUID7 according to https://www.ietf.org/archive/id/draft-peabody-dispatch-new-uuid-format-04.html#variant_and_version_fields'
 BEGIN
    -- Obtain date with 4 milliseconds precision
    SET @now = sysdate(4);
    /*
    UNIX_TIMESTAMP returns a 32bits number, so this function will not work after the Epochalypse, I am crossing my fingers and I hope that MySQL/MariaDB teams will move to 64bits timestamps before than 2038.
    */
    SET @time_sec = LPAD(HEX(TRUNCATE(UNIX_TIMESTAMP(@now), 0)), 9, '0');
    SET @time_mil = LPAD(HEX(MICROSECOND(@now)), 3, '0');
    SET @rand_62 = LPAD(HEX(RANDOM_BYTES(8)), 15, '0');
    SET @rand_12 = LPAD(HEX(RANDOM_BYTES(4)), 3, '0') ;
    
    -- Calculate most significant bit of the 8th octet
    SET @msb = HEX(FLOOR(LOG2(CONV(SUBSTR(@time_sec, -2), 16, 10)) + 1));

    return CAST(CONCAT(SUBSTR(@time_sec, 1, 8), '-', SUBSTR(@time_sec, -1), SUBSTR(@time_mil, 1, 3), '-7', SUBSTR(@rand_12, -3), '-', @msb, SUBSTR(@rand_62, 1, 3), '-', SUBSTR(@rand_62, -12)) AS UUID);
END $$


/* set global log_bin_trust_function_creators='ON'; */


/* Sample Table*/
DROP TABLE IF EXISTS `tb_test_auto`;

CREATE TABLE `database`.tb_test_auto (
	id INT auto_increment NOT NULL COMMENT 'PK입니다',
	col1 varchar(100) NOT NULL COMMENT '문자열입니다',
	col2 TIMESTAMP NOT NULL COMMENT 'Timestamp입니다',
	CONSTRAINT tb_test_auto_pk PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COMMENT='테스트테이블입니다'
AUTO_INCREMENT=1;

INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());
INSERT INTO `database`.tb_test_auto (col1, col2) VALUES('한글입니다.', now());


/* uuidv7() Look a_uuidv7.sql*/
CREATE TABLE `database`.tb_test_uuid (
	id uuid NOT NULL COMMENT 'https://mariadb.com/kb/en/uuid-data-type/',
	col1 varchar(100) NOT NULL COMMENT '문자열입니다',
	col2 TIMESTAMP NOT NULL COMMENT 'Timestamp입니다',
	CONSTRAINT tb_test_uuid_pk PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COMMENT='UUID PK Table입니다';

INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
INSERT INTO `database`.tb_test_uuid (id, col1, col2) VALUES(uuidv7(), '한글입니다.', now());
