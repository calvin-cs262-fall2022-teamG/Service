--
-- This SQL script builds a database for PeetsforKnights.
--
-- @author tanis33
-- @version Fall, 2022
--
-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS customizeType;

DROP TABLE IF EXISTS customize;

DROP TABLE IF EXISTS itemCost;

DROP TABLE IF EXISTS itemInfo;

-- Create the schema.
CREATE TABLE itemInfo (
  ID SERIAL PRIMARY KEY,
  itemName varchar(50),
  uri varchar(50),
  customizeTypeID integer
);

CREATE TABLE itemCost (
  itemID integer,
  smCost money,
  mdCost money,
  lgCost money  
);

CREATE TABLE customize (
  ID SERIAL PRIMARY KEY,
  customName varchar(50),
  costPer money,
  styleID integer  
);

CREATE TABLE customizeType (
  customizeTypeID integer,
  customizeID1 integer,
  customizeID2 integer,
  customizeID3 integer,
  customizeID4 integer,
  customizeID5 integer
);

-- Allow users to select data from the tables.
GRANT
SELECT
  ON itemInfo TO PUBLIC;

GRANT
SELECT
  ON itemCost TO PUBLIC;

GRANT
SELECT
  ON customize TO PUBLIC;

GRANT
SELECT
  ON customizeType TO PUBLIC;

-- Add sample records.
INSERT INTO itemInfo(ID, itemName, uri, customizeTypeID ) VALUES(1, 'Drip Coffee', 'urihere', 1);

INSERT INTO itemInfo(ID, itemName, uri, customizeTypeID ) VALUES(2, 'Cold Brew', 'urihere', 1);

INSERT INTO itemCost(itemID, smCost, mdCost, lgCost) VALUES (1, 2, 3, 4);

INSERT INTO itemCost(itemID, smCost, mdCost, lgCost) VALUES (2, 2.40, 3.40, 4.40);

INSERT INTO customize(ID, customName, costPer, styleID) VALUES (1, 'sugar', .50, 1);

INSERT INTO customize(ID, customName, costPer, styleID) VALUES (2, 'cream', .70, 1);

INSERT INTO customizeType(customizeTypeID, customizeID1) VALUES (1, 1);

INSERT INTO customizeType(customizeTypeID, customizeID1, customizeID2, customizeID3, customizeID4, customizeID5) VALUES (2, 1, NULL, NULL, NULL, NULL);