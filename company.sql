DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_pk                 TEXT,
    user_first_name         TEXT,
    user_last_name          TEXT,
    user_email              TEXT,
    user_password           TEXT, 
    user_phone              TEXT,
    PRIMARY KEY(user_pk)
);


INSERT INTO users(user_pk,user_first_name,user_last_name,user_email,user_password,user_phone) VALUES ('1','one','onesen','1@1.com','password1','111');
INSERT INTO users(user_pk,user_first_name,user_last_name,user_email,user_password,user_phone) VALUES ('2','two','twosen','2@2.com','password2','222');
INSERT INTO users(user_pk,user_first_name,user_last_name,user_email,user_password,user_phone) VALUES ('3','three','threesen','3@3.com','password3','333');

SELECT * from users;

DROP TABLE IF EXISTS addresses;

CREATE TABLE addresses (
    address_pk              TEXT,
    address_user_fk         TEXT,
    address_line_1          TEXT,
    address_line_2          TEXT,
    address_city            TEXT,
    address_postal_code     TEXT,
    address_state           TEXT,
    address_country         TEXT,

    PRIMARY KEY (address_pk),
    FOREIGN KEY (address_user_fk) REFERENCES users(user_pk)
);

INSERT INTO addresses(address_pk,address_user_fk,address_line_1,address_line_2,address_city,address_postal_code,address_state,address_country) VALUES ('1','1','111 One drive','','Onetown','1111','Oo','Denmark');
INSERT INTO addresses(address_pk,address_user_fk,address_line_1,address_line_2,address_city,address_postal_code,address_state,address_country) VALUES ('2','2','222 Two drive','','Twotown','2222','Tt','Denmark');
INSERT INTO addresses(address_pk,address_user_fk,address_line_1,address_line_2,address_city,address_postal_code,address_state,address_country) VALUES ('3','3','333 Three drive','','Threetown','3333','Th','Denmark');

SELECT * from addresses;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_pk            TEXT,
    order_user_fk       TEXT,
    order_date          INTEGER,
    order_total_amount  REAL,

    PRIMARY KEY (order_pk),
    FOREIGN KEY (order_user_fk) REFERENCES users(user_pk)

);

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
    review_pk           TEXT,
    review_user_fk      TEXT,
    review_product_fk   TEXT,
    review_rating       REAL,
    review_descriptiom  TEXT,
    review_date         INTEGER,

    PRIMARY KEY (review_pk),
    FOREIGN KEY (review_user_fk) REFERENCES users(user_pk),
    FOREIGN KEY (review_product_fk) REFERENCES products(product_pk)

);

DROP TABLE IF EXISTS order_details;

CREATE TABLE order_details (
    order_details_pk            TEXT,
    order_details_order_fk      TEXT,
    order_details_product_fk    TEXT,
    order_details_quantity      INTEGER,
    order_details_unit_price    REAL,

    PRIMARY KEY (order_details_pk),
    FOREIGN KEY (order_details_order_fk) REFERENCES orders(order_pk),
    FOREIGN KEY (order_details_product_fk) REFERENCES products(product_pk)

);

DROP TABLE IF EXISTS products;

CREATE TABLE products(
    product_pk              TEXT,
    product_name            TEXT,
    product_price           REAL,
    product_description     TEXT,
    product_stock           INTEGER,
    product_category_fk     TEXT,

    PRIMARY KEY (product_pk),
    FOREIGN KEY (product_category_fk) REFERENCES categories(category_pk)

);


DROP TABLE IF EXISTS categories;

CREATE TABLE categories(
    category_pk           TEXT,
    category_name         TEXT

    PRIMARY KEY (category_pk)

)



/* JOIN QUERIES */
SELECT
    orders.order_pk,
    orders.order_date,
    orders.order_total_amount,
    users.user_first_name,
    users.user_last_name,
    addresses.address_line_1,
    addresses.address_city,
    addresses.address_state,
    addresses.address_country
FROM
    orders
JOIN
    users ON orders.order_user_fk = users.user_pk
JOIN
    addresses ON users.user_pk = addresses.address_user_fk
ORDER BY
    orders.order_pk;


