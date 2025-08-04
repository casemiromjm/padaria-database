/* 
"Create" file based on our initial create (create1.sql) and on AI feedback
*/
PRAGMA foreign_keys = ON;

-- clean up
DROP TABLE IF EXISTS Rating;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Delivery;
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS Shift;
DROP TABLE IF EXISTS Fidelity;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Bakery;
DROP TABLE IF EXISTS Person;

/* Person Table */
CREATE TABLE Person (
    personID INTEGER PRIMARY KEY NOT NULL CHECK (personID > 0),
    personName TEXT NOT NULL,
    nif VARCHAR(9) NOT NULL UNIQUE
);

/* Client Table */
CREATE TABLE Client (
    personID INTEGER PRIMARY KEY NOT NULL CHECK (personID > 0),
    email TEXT NOT NULL UNIQUE,
    phoneNumber TEXT NOT NULL,
    address TEXT NOT NULL,
    birthDate TEXT NOT NULL,

    FOREIGN KEY (personID) REFERENCES Person(personID) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Bakery Table */
CREATE TABLE Bakery (
    bakeryID INTEGER PRIMARY KEY NOT NULL CHECK (bakeryID > 0),
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    phoneNumber TEXT NOT NULL
);

/* Order Table */
CREATE TABLE Orders (
    orderID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (orderID > 0),
    orderDate TEXT NOT NULL,
    totalValue NUMERIC NOT NULL CHECK (totalValue > 0),
    orderStatus TEXT NOT NULL
);

/* Employee Table */
CREATE TABLE Employee (
    personID INTEGER PRIMARY KEY NOT NULL CHECK (personID > 0),
    job TEXT NOT NULL,
    salary NUMERIC NOT NULL CHECK (salary > 0),
    hiringDate TEXT NOT NULL,
    bakeryID INTEGER,
    isManager INTEGER NOT NULL DEFAULT 0 CHECK (isManager IN (0, 1)),

    FOREIGN KEY (personID) REFERENCES Person(personID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (bakeryID) REFERENCES Bakery(bakeryID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* Fidelity Table */
CREATE TABLE Fidelity (
    personID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (personID > 0),
    pointsBalance INTEGER NOT NULL DEFAULT 0 CHECK (pointsBalance >= 0),
    startingDate TEXT NOT NULL,

    FOREIGN KEY (personID) REFERENCES Client(personID) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Shift Table */
CREATE TABLE Shift (
    shiftID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (shiftID > 0),
    startingTime TEXT NOT NULL CHECK (startingTime < endingTime),
    endingTime TEXT NOT NULL,
    intervalBreak TEXT NOT NULL,
    employeeID INTEGER,

    FOREIGN KEY (employeeID) REFERENCES Employee(personID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* Product Table */
CREATE TABLE Product (
    productID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (productID > 0),
    name TEXT NOT NULL,
    price NUMERIC NOT NULL CHECK (price > 0),
    productType INTEGER NOT NULL,       -- main ingredient of the product

    FOREIGN KEY (productType) REFERENCES Ingredient(ingredientID)
);

/* Ingredient Table */
CREATE TABLE Ingredient (
    ingredientID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (ingredientID > 0),
    name TEXT NOT NULL,
    unit TEXT NOT NULL,
    expirationDate TEXT NOT NULL,
    stockQuantity INTEGER NOT NULL CHECK (stockQuantity >= 0)
);

/* Supplier Table */
CREATE TABLE Supplier (
    supplierID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (supplierID > 0),
    supplierName TEXT NOT NULL,
    contactNumber TEXT NOT NULL
);

/* Sale Table */
CREATE TABLE Sale (
    saleID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (saleID > 0),
    description TEXT NOT NULL,
    discountPercentage NUMERIC NOT NULL CHECK (discountPercentage >= 0 AND discountPercentage <= 100),
    startingDate TEXT NOT NULL,
    endingDate TEXT NOT NULL,
    productID INTEGER NOT NULL,

    FOREIGN KEY (productID) REFERENCES Product(productID)
);

/* Delivery Table */
CREATE TABLE Delivery (
    deliveryID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (deliveryID > 0),
    deliveryAddress TEXT NOT NULL,
    deliveryDate TEXT NOT NULL,
    deliveryStatus TEXT NOT NULL DEFAULT 'Pending',
    orderID INTEGER NOT NULL,

    FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

/* Rating Table */
CREATE TABLE Rating (
    ratingID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (ratingID > 0),
    score INTEGER NOT NULL CHECK (score >= 0 AND score <= 5),
    comment TEXT NOT NULL,
    clientID INTEGER NOT NULL,
    orderID INTEGER NOT NULL,

    FOREIGN KEY (clientID) REFERENCES Client(personID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Payment Table */
CREATE TABLE Payment (
    paymentID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (paymentID > 0),
    paymentMethod TEXT NOT NULL,
    paymentDate TEXT NOT NULL,
    paymentValue NUMERIC NOT NULL CHECK (paymentValue > 0),
    orderID INTEGER NOT NULL,

    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE ON UPDATE CASCADE
);
