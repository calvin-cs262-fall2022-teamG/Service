--
-- This SQL script builds a database for PeetsforKnights.
--
-- @author tanis33
-- @version Fall, 2022
--
-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS itemInfo;

DROP TABLE IF EXISTS loginInfo;

DROP TABLE IF EXISTS orderItems;

DROP TABLE IF EXISTS pastOrder;


-- Create the schema.
CREATE TABLE itemInfo (
  ID SERIAL PRIMARY KEY,
  itemName varchar(50),
  uri varchar(200),
  ice integer,
  milk integer,
  shots integer,
  decaf integer,
  syrup integer,
  whippedcream integer,
  sugar integer,
  toated integer,
  creamCheese integer,
  smCost float,
  mdCost float,
  lgCost float,
  itemType varchar(50)
);

CREATE TABLE loginInfo (
  userName varchar(50),
  userPassword varchar(50)
);

CREATE TABLE pastOrder (
  ID integer PRIMARY KEY,
  orderTime varchar(50),
  orderCompleted varchar(50),
  totalCost varchar(50)
);

CREATE TABLE orderItems (
  orderID integer PRIMARY KEY,
  orderItemName varchar(50),
  orderItemCost money,
  orderItemURI varchar(200),
  orderItemsSize varchar(50)
);

-- Allow users to select data from the tables.
GRANT
SELECT
  ON itemInfo TO PUBLIC;

GRANT
SELECT
  ON loginInfo TO PUBLIC;

GRANT
SELECT
  ON pastOrder TO PUBLIC;

GRANT
SELECT
  ON orderItems TO PUBLIC;

-- Add sample records.
INSERT INTO
  loginInfo(userName, userPassword)
VALUES
  ('ben', 'notsecurePassword');

INSERT INTO
  pastOrder(ID, orderTime, orderCompleted, totalCost)
VALUES
  (2, '11.30.22 10:35AM', '10:42AM', 4.29);

INSERT INTO
  orderItems (
    orderID,
    orderItemName,
    orderItemCost,
    orderItemURI,
    orderItemsSize
  )
VALUES
  (
    1,
    'Cold Brew',
    4.29,
    'https://peets-shop.imgix.net/products/cold-brew-iced-coffee.png?v=1597269387&auto=formatcompress&w=540',
    'Small'
  );