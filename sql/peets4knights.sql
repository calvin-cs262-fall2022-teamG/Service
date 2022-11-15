--
-- This SQL script builds a database for PeetsforKnights.
--
-- @author tanis33
-- @version Fall, 2022
--
-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS orderedItem;

DROP TABLE IF EXISTS orderFull;

DROP TABLE IF EXISTS itemInfo;

-- Create the schema.
CREATE TABLE itemInfo (
  ID SERIAL PRIMARY KEY,
  itemName varchar(50),
  uri varchar(150),
  tea varchar(50),
  ice varchar(50),
  milk varchar(50),
  shots integer,
  decaf varchar(50),
  syrup varchar(50),
  syrupAmount varchar(50),
  topping varchar(50),
  toppingAmount varchar(50),
  sweetener varchar(50),
  sweetenerAmount varchar(50),
  smCost money,
  mdCost money,
  lgCost money
);

CREATE TABLE orderFull (
  orderID SERIAL PRIMARY KEY,
  userName varchar(50),
  orderTime time,
  completedTime time,
  totalCost money
);

CREATE TABLE orderedItem (
  groupID integer,
  itemOrdered integer,
  tea varchar(50),
  ice varchar(50),
  milk varchar(50),
  shots integer,
  decaf varchar(50),
  syrup varchar(50),
  syrupAmount varchar(50),
  topping varchar(50),
  toppingAmount varchar(50),
  sweetener varchar(50),
  sweetenerAmount varchar(50),
  itemCost money
);

-- Allow users to select data from the tables.
GRANT
SELECT
  ON itemInfo TO PUBLIC;

GRANT
SELECT
  ON orderFull TO PUBLIC;

GRANT
SELECT
  ON orderedItem TO PUBLIC;

-- Add sample records.
INSERT INTO
  itemInfo(
    ID,
    itemName,
    uri,
    tea,
    ice,
    milk,
    shots,
    decaf,
    syrup,
    syrupAmount,
    topping,
    toppingAmount,
    sweetener,
    sweetenerAmount,
    smCost,
    mdCost,
    lgCost
  )
VALUES
  (
    2,
    'Drip Coffee',
    'https://peets-shop.imgix.net/products/coffee-of-the-day.png?v=1597269387&auto=format,compress&w=360',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    2.55,
    3.00,
    3.35
  );

INSERT INTO
  orderFull(
    orderID,
    userName,
    orderTime,
    completedTime,
    totalCost
  )
VALUES
(
    1,
    'CalvinStudent',
    NULL,
    NULL,
    15.34
  );

INSERT INTO
  orderedItem(
    groupID,
    itemOrdered,
    tea,
    ice,
    milk,
    shots,
    decaf,
    syrup,
    syrupAmount,
    topping,
    toppingAmount,
    sweetener,
    sweetenerAmount,
    itemCost
  )
VALUES
(
    1,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    4.34
  );