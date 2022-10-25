--
-- This SQL script implements sample queries on the Peets4Knights database.
--
-- @author tanis33
-- @version Fall, 2022
--

-- Get the list of items on menu.
SELECT *
  FROM itemInfo
  ;

-- Get the item costs.
SELECT * 
  FROM itemCost
  ;

-- Get all the cold drinks.
SELECT *
  FROM itemInfo
 WHERE itemName LIKE '%cold%'
 ;

-- Get the most expensive drinks.
  SELECT lgCost
    FROM itemCost
ORDER BY lgCost DESC
   LIMIT 1
   ;

-- Get the cross-product of all the tables.
SELECT *
  FROM itemInfo, itemCost, customize, customizeType
  ;