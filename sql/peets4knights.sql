--
-- This SQL script builds a database for PeetsforKnights.
--
-- @author tanis33
-- @version Fall, 2022
--
-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS itemInfo;

DROP TABLE IF EXISTS loginInfo;

DROP TABLE IF EXISTS pastOrder;

DROP TABLE IF EXISTS orderItems;

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
  smCost money,
  mdCost money,
  lgCost money
);

CREATE TABLE loginInfo (
  userName varchar(50),
  userPassword varchar(50)
);

CREATE TABLE pastOrder (
  ID SERIAL PRIMARY KEY,
  orderTime varchar(50),
  orderCompleted varchar(50),
  totalCost varchar(50)
);

CREATE TABLE orderItems (
  orderID SERIAL REFERENCES pastOrder(ID),
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