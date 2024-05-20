DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_pk                 TEXT,
    customer_first_name         TEXT,
    customer_last_name          TEXT,
    customer_email              TEXT,
    customer_password           TEXT, 
    customer_phone              TEXT,
    PRIMARY KEY(customer_pk)
);

DROP TABLE IF EXISTS addresses;

CREATE TABLE addresses (
    address_pk              TEXT,
    address_customer_fk     TEXT,
    address_line_1          TEXT,
    address_line_2          TEXT,
    address_city            TEXT,
    address_postal_code     TEXT,
    address_state           TEXT,
    address_country         TEXT,

    PRIMARY KEY (address_pk),
    FOREIGN KEY (address_customer_fk) REFERENCES customers(customer_pk)

);


DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_pk            TEXT,
    order_customer_fk   TEXT,
    order_date          INTEGER,
    order_total_amount  REAL,

);


