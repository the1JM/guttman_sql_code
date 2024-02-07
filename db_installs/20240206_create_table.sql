SELECT '' AS 'INSTALLATION STARTING' \G

DROP DATABASE IF EXISTS guttman_202db_assign5;
-- Create Database
CREATE DATABASE IF NOT EXISTS guttman_202db_assign5
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

SHOW DATABASES \G

-- Use Database
USE guttman_202db_assign5;


-- Create tables
DROP TABLE
IF EXISTS
`vendor`;

CREATE TABLE
IF NOT EXISTS vendor (  vendorid    CHAR (2) NOT NULL,
                      vendorname  VARCHAR (25) NOT NULL,
                                  PRIMARY KEY (vendorid)

);
SHOW CREATE TABLE vendor \G

DROP TABLE
IF EXISTS
`category`;

CREATE TABLE
IF NOT EXISTS category  (       categoryid      CHAR(2) NOT NULL,
                                categoryname    VARCHAR (25) NOT NULL,
                                                PRIMARY KEY (categoryid)
);
SHOW CREATE TABLE category \G

DROP TABLE
IF EXISTS
`product`;

CREATE TABLE
IF NOT EXISTS product (      productid     CHAR(3) NOT NULL,
                            productname    VARCHAR (25) NOT NULL,
                            productprice   NUMERIC (7,2) NOT NULL,
                            vendorid       CHAR (2) NOT NULL,
                            categoryid     CHAR (2) NOT NULL,
                                           PRIMARY KEY (productid),
                                           FOREIGN KEY (vendorid)
                                           REFERENCES vendor(vendorid),
                                           FOREIGN KEY (categoryid)
                                           REFERENCES category(categoryid)   );
SHOW CREATE TABLE product \G

DROP TABLE
IF EXISTS
`region`;

CREATE TABLE
IF NOT EXISTS region (     regionid     CHAR NOT NULL,
                           regionname   VARCHAR (25) NOT NULL,
                                        PRIMARY KEY (regionid)
);

SHOW CREATE TABLE region \G
DROP TABLE
IF EXISTS
`store`;

CREATE TABLE
IF NOT EXISTS store (      storeid      VARCHAR(3) NOT NULL,
                          storezip    CHAR(5) NOT NULL,
                          regionid    CHAR NOT NULL,
                                      PRIMARY KEY (storeid),
                                      FOREIGN KEY (regionid)
                                      REFERENCES region(regionid)
);
SHOW CREATE TABLE store \G

DROP TABLE
IF EXISTS
`customer`;


CREATE TABLE
IF NOT EXISTS customer   (      customerid      CHAR(7) NOT NULL,
                                customername    VARCHAR(15) NOT NULL,
                                customerzip     CHAR(5) NOT NULL,
                                                PRIMARY KEY (customerid)
);
SHOW CREATE TABLE customer \G

DROP TABLE
IF EXISTS
`salestransaction`;
CREATE TABLE
IF NOT EXISTS salestransaction (   tid            VARCHAR(8) NOT NULL,
                                  customerid      CHAR(7) NOT NULL,
                                  storeid         VARCHAR(3) NOT NULL,
                                  tdate           DATE NOT NULL,
                                                  PRIMARY KEY (tid),
                                                  FOREIGN KEY (customerid)
                                                  REFERENCES customer(customerid),
                                                  FOREIGN KEY (storeid)
                                                  REFERENCES store (storeid)
);
SHOW CREATE TABLE salestransaction \G
DROP TABLE
IF EXISTS
`soldvia`;

CREATE TABLE
IF NOT EXISTS soldvia  (      productid    CHAR(3)  NOT NULL,
                            tid           VARCHAR(8) NOT NULL,
                            noofitems     INT NOT NULL,
                                          PRIMARY KEY (productid, tid),
                                          FOREIGN KEY (productid)
                                          REFERENCES product (productid),
                                          FOREIGN KEY (tid)
                                          references salestransaction (tid)
);
SHOW CREATE TABLE soldvia \G

SELECT '' AS 'INSERTING VALUES INTO TABLE' \G

INSERT INTO vendor VALUES ('PG','Pacifica Gear');
INSERT INTO vendor VALUES ('MK', 'Mountain King');

INSERT INTO category VALUES ('CP', 'Camping');
INSERT INTO category VALUES ('FW', 'Footwear');

INSERT INTO product VALUES ('1X1', 'Zzz Bag', 100, 'PG','CP');
INSERT INTO product VALUES ('2X2','Easy Boot',70,'MK','FW');
INSERT INTO product VALUES ('3X3','Cosy Sock',15,'MK','FW');
INSERT INTO product VALUES ('4X4','Dura Boot',90,'PG','FW');
INSERT INTO product VALUES ('5X5','Tiny Tent',150,'MK','CP');
INSERT INTO product VALUES ('6X6','Biggy Tent',250,'MK','CP');


INSERT INTO region VALUES ('C','Chicagoland');
INSERT INTO region VALUES ('T','Tristate');

INSERT INTO store VALUES ('S1','60600','C');
INSERT INTO store VALUES ('S2','60605','C');
INSERT INTO store VALUES ('S3','35400','T');

INSERT INTO customer VALUES ('1-2-333','Tina','60137');
INSERT INTO customer VALUES ('2-3-444','Tony','60611');
INSERT INTO customer VALUES ('3-4-555','Pam','35401');

INSERT INTO salestransaction VALUES ('T111','1-2-333','S1','2013-01-01');
INSERT INTO salestransaction VALUES ('T222','2-3-444','S2','2013-01-01');
INSERT INTO salestransaction VALUES ('T333','1-2-333','S3','2013-01-02');
INSERT INTO salestransaction VALUES ('T444','3-4-555','S3','2013-01-02');
INSERT INTO salestransaction VALUES ('T555','2-3-444','S3','2013-01-02');

INSERT INTO soldvia VALUES ('1X1','T111',1);
INSERT INTO soldvia VALUES ('2X2','T222',1);
INSERT INTO soldvia VALUES ('3X3','T333',5);
INSERT INTO soldvia VALUES ('1X1','T333',1);
INSERT INTO soldvia VALUES ('4X4','T444',1);
INSERT INTO soldvia VALUES ('2X2','T444',2);
INSERT INTO soldvia VALUES ('4X4','T555',4);
INSERT INTO soldvia VALUES ('5X5','T555',2);
INSERT INTO soldvia VALUES ('6X6','T555',1);

SELECT '' AS 'INSTALLATION COMPLETED' \G
