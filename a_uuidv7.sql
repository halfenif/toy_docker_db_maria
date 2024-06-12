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