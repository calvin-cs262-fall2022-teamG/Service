--
-- This SQL script builds a database for PeetsforKnights.
--
-- @author tanis33
-- @version Fall, 2022
--
-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS itemInfo;

DROP TABLE IF EXISTS loginInfo;

-- Create the schema.
CREATE TABLE itemInfo (
  ID SERIAL PRIMARY KEY,
  itemName varchar(50),
  uri varchar(150),
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

-- Allow users to select data from the tables.
GRANT
SELECT
  ON itemInfo TO PUBLIC;

GRANT
SELECT
  ON loginInfo TO PUBLIC;

-- Add sample records.
INSERT INTO
  itemInfo(
    ID,
    itemName,
    uri,
    ice,
    milk,
    shots,
    decaf,
    syrup,
    whippedcream,
    sugar,
    toated,
    creamCheese,
    smCost,
    mdCost,
    lgCost
  )
VALUES
  (
    2,
    'Drip Coffee',
    'https://peets-shop.imgix.net/products/coffee-of-the-day.png?v=1597269387&auto=format,compress&w=360',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    NULL,
    NULL,
    2.55,
    3.00,
    3.35
  );

INSERT INTO
  loginInfo(userName, userPassword)
VALUES
  ('ben', 'securePassword');