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

DROP TABLE IF EXISTS categories;

CREATE TABLE categories(
    category_pk           TEXT,
    category_name         TEXT,

    PRIMARY KEY (category_pk)

);

INSERT INTO categories(category_pk,category_name) VALUES ('1','category1');
INSERT INTO categories(category_pk,category_name) VALUES ('2','category2');
INSERT INTO categories(category_pk,category_name) VALUES ('3','category3');

SELECT * from categories;


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

INSERT INTO products(product_pk,product_name,product_price,product_description,product_stock,product_category_fk) VALUES ('1','product1',100,'product1 description',10,'1');
INSERT INTO products(product_pk,product_name,product_price,product_description,product_stock,product_category_fk) VALUES ('2','product2',200,'product2 description',20,'2');
INSERT INTO products(product_pk,product_name,product_price,product_description,product_stock,product_category_fk) VALUES ('3','product3',300,'product3 description',30,'3');

SELECT * from products;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_pk            TEXT,
    order_user_fk       TEXT,
    order_date          INTEGER,
    order_total_amount  REAL,

    PRIMARY KEY (order_pk),
    FOREIGN KEY (order_user_fk) REFERENCES users(user_pk)

);

INSERT INTO orders(order_pk,order_user_fk,order_date,order_total_amount) VALUES ('1','1',0,100);
INSERT INTO orders(order_pk,order_user_fk,order_date,order_total_amount) VALUES ('2','2',0,200);
INSERT INTO orders(order_pk,order_user_fk,order_date,order_total_amount) VALUES ('3','3',0,300);


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

INSERT INTO order_details(order_details_pk,order_details_order_fk,order_details_product_fk,order_details_quantity,order_details_unit_price) VALUES ('1','1','1',1,100);
INSERT INTO order_details(order_details_pk,order_details_order_fk,order_details_product_fk,order_details_quantity,order_details_unit_price) VALUES ('2','2','2',2,200);
INSERT INTO order_details(order_details_pk,order_details_order_fk,order_details_product_fk,order_details_quantity,order_details_unit_price) VALUES ('3','3','3',3,300);

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
INSERT INTO reviews(review_pk,review_user_fk,review_product_fk,review_rating,review_descriptiom,review_date) VALUES ('1','1','1',5,'good product',0);
INSERT INTO reviews(review_pk,review_user_fk,review_product_fk,review_rating,review_descriptiom,review_date) VALUES ('2','2','2',4,'its okay',0);
INSERT INTO reviews(review_pk,review_user_fk,review_product_fk,review_rating,review_descriptiom,review_date) VALUES ('3','3','3',1,'very shit',0);
INSERT INTO reviews(review_pk,review_user_fk,review_product_fk,review_rating,review_descriptiom,review_date) VALUES ('4','1','2',0,'it never came',0);
INSERT INTO reviews(review_pk,review_user_fk,review_product_fk,review_rating,review_descriptiom,review_date) VALUES ('5','3','2',0,'very nice',4);






/* JOIN QUERIES */


/* THIS QUERY MAKES THE FINAL FINISHED ORDER WITH TOTAL AMOUNT AND ORDER DETAILS ABOUT THE USER/CUSTOMER */

SELECT 
    orders.order_pk,
    orders.order_date,
    SUM(order_details.order_details_quantity * order_details.order_details_unit_price) AS order_total_amount,
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
JOIN 
    order_details ON orders.order_pk = order_details.order_details_order_fk
GROUP BY 
    orders.order_pk
ORDER BY 
    orders.order_pk;


/* GETS THE AVERAGE RATING ON EACH PRODUCT */
SELECT
    categories.category_name,
    products.product_name,
    AVG(reviews.review_rating) AS average_rating
FROM
    products
JOIN
    categories ON products.product_category_fk = categories.category_pk
LEFT JOIN
    reviews ON products.product_pk = reviews.review_product_fk
GROUP BY
    categories.category_name,
    products.product_name;
