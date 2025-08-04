/* 
Initial create file for creating the Bakery database
*/

/* 
the attributes dates are stored as TEXT because SQLite does
not have a storage class set aside for storing dates and/or times
and the date and time functions are capable of operating on TEXT, REAL, or INTEGER values.
also, the format we had in mind for the dates is "YYYY-MM-DD" for the sake of simplicity.
*/

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
    personID INTEGER PRIMARY KEY NOT NULL CHECK (personID > 0),
    personName TEXT NOT NULL,
    nif VARCHAR(9) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Client;
CREATE TABLE Client (
    personID INTEGER PRIMARY KEY NOT NULL CHECK (personID > 0),
    email TEXT NOT NULL UNIQUE,
    phoneNumber TEXT NOT NULL,
    address TEXT NOT NULL,
    birthDate TEXT NOT NULL,

    FOREIGN KEY (personID) REFERENCES Person(personID) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    personID INTEGER PRIMARY KEY NOT NULL CHECK (personID > 0),
    job TEXT NOT NULL,
    salary NUMERIC NOT NULL CHECK (salary > 0),
    hiringDate TEXT NOT NULL,
    bakeryID INTEGER,
    isManager INTEGER NOT NULL CHECK (isManager IN (0, 1)),
    shiftID INTEGER,

    FOREIGN KEY (personID) REFERENCES Person(personID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (bakeryID) REFERENCES Bakery(bakeryID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (shiftID) REFERENCES Shift(shiftID) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Bakery;
CREATE TABLE Bakery (
    bakeryID INTEGER PRIMARY KEY NOT NULL CHECK (bakeryID > 0),
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    phoneNumber TEXT NOT NULL
);

DROP TABLE IF EXISTS Fidelity;
CREATE TABLE Fidelity (
    personID PRIMARY KEY NOT NULL UNIQUE CHECK (personID > 0),
    pointsBalance INTEGER NOT NULL DEFAULT 0 CHECK (pointsBalance >= 0),
    startingDate TEXT NOT NULL,       -- starting date of the membership
    
    FOREIGN KEY (personID) REFERENCES Client(personID) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Shift;
CREATE TABLE Shift (
    shiftID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (shiftID > 0),
    startingTime TEXT NOT NULL CHECK (startingTime < endingTime),
    endingTime TEXT NOT NULL,
    intervalBreak TEXT NOT NULL,
    employeeID INTEGER,

    FOREIGN KEY (employeeID) REFERENCES Employee(personID) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Product;
CREATE TABLE Product (
    productID PRIMARY KEY NOT NULL UNIQUE CHECK (productID > 0),
    name TEXT NOT NULL,
    price NUMERIC NOT NULL CHECK (price > 0),
    productType TEXT NOT NULL
);

DROP TABLE IF EXISTS Ingredient;
CREATE TABLE Ingredient (
    ingredientID PRIMARY KEY NOT NULL UNIQUE CHECK (ingredientID > 0),
    name TEXT NOT NULL,
    unit TEXT NOT NULL,
    expirationDate TEXT NOT NULL,
    stockQuantity INTEGER NOT NULL CHECK (stockQuantity >= 0)
);

DROP TABLE IF EXISTS Supplier;
CREATE TABLE Supplier (
    supplierID PRIMARY KEY NOT NULL UNIQUE CHECK (supplierID > 0),
    supplierName TEXT NOT NULL,
    contactNumber TEXT NOT NULL,
    ingredientSupplied INTEGER NOT NULL,

    FOREIGN KEY (ingredientSupplied) REFERENCES Ingredient(ingredientID) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Sale;
CREATE TABLE Sale (
    saleID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (saleID > 0),
    description TEXT NOT NULL,
    discountPercentage NUMERIC NOT NULL CHECK (discountPercentage >= 0),
    startingDate TEXT NOT NULL,
    endingDate TEXT NOT NULL,
    productID INTEGER NOT NULL,

    FOREIGN KEY (productID) REFERENCES Product(productID)
);

-- rename order table, because order is a reserved keyword in SQLite
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    orderID PRIMARY KEY NOT NULL UNIQUE CHECK (orderID > 0),
    orderDate TEXT NOT NULL,
    totalValue NUMERIC NOT NULL CHECK (totalValue > 0),
    orderStatus TEXT NOT NULL
);

DROP TABLE IF EXISTS Delivery;
CREATE TABLE Delivery (
    deliveryID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (deliveryID > 0),
    deliveryAddress TEXT NOT NULL,
    deliveryDate TEXT NOT NULL,
    deliveryStatus TEXT NOT NULL,
    orderID INTEGER NOT NULL,

    FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

DROP TABLE IF EXISTS Rating;
CREATE TABLE Rating (
    ratingID INTEGER PRIMARY KEY NOT NULL UNIQUE CHECK (ratingID > 0),
    score INTEGER NOT NULL CHECK (score >= 0 AND score <= 5),
    comment TEXT NOT NULL,
    clientID INTEGER NOT NULL,
    orderID INTEGER NOT NULL,

    FOREIGN KEY (clientID) REFERENCES Client(personID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment (
    paymentID PRIMARY KEY NOT NULL UNIQUE CHECK (paymentID > 0),
    paymentMethod TEXT NOT NULL,
    paymentDate TEXT NOT NULL,
    paymentValue NUMERIC NOT NULL CHECK (paymentValue > 0),
    orderID INTEGER NOT NULL,

    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE ON UPDATE CASCADE
);
