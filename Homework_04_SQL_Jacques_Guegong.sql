
-- Homework_04_SQL
-- Name: JACQUES DUVAL GUEGONG
-- Section: 001
-- Hours spent: 30 HOURS

DELIMITER //

CREATE TRIGGER after_item_stock_delete
AFTER DELETE ON item_stock
FOR EACH ROW
BEGIN
    UPDATE items 
    SET deleted = TRUE 
    WHERE id = OLD.item_id;
END //

DELIMITER ;