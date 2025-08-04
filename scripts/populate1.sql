/* 
Initial populate file for populating the Bakery database
*/

PRAGMA foreign_keys = ON;

-- deleting all data from tables incase they already have data for some reason
DELETE FROM Person;
DELETE FROM Client;
DELETE FROM Employee;
DELETE FROM Bakery;
DELETE FROM Fidelity;
DELETE FROM Shift;
DELETE FROM Product;
DELETE FROM Ingredient;
DELETE FROM Supplier;
DELETE FROM Sale;
DELETE FROM Delivery;
DELETE FROM Orders;
DELETE FROM Rating;
DELETE FROM Payment;

-- Inserting clients
INSERT INTO Person (personID, personName, nif) VALUES (1, 'Casemiro Medeiros', '321304810');
INSERT INTO Person (personID, personName, nif) VALUES (2, 'Daria Mahdych', '908743133');
INSERT INTO Person (personID, personName, nif) VALUES (3, 'Heitor Brandão', '554121309');
INSERT INTO Person (personID, personName, nif) VALUES (4, 'Matilde Martins', '987566313');
INSERT INTO Person (personID, personName, nif) VALUES (5, 'André Villas-Boas', '767112903');

INSERT INTO Client (personID, email, phoneNumber, address, birthDate) VALUES (1, 'casemiromelojorge@gmail.com', '932692390', 'Rua Manuel Pacheco Miranda, 205', '2003-02-20');
INSERT INTO Client (personID, email, phoneNumber, address, birthDate) VALUES (2, 'dariamahdych@gmail.com', '960440992', 'Praça 9 de Abril, 251', '2002-04-18');
INSERT INTO Client (personID, email, phoneNumber, address, birthDate) VALUES (3, 'heitorbrandao@gmail.com', '912360650', 'Rua do Breiner, 333', '2003-08-02');
INSERT INTO Client (personID, email, phoneNumber, address, birthDate) VALUES (4, 'mmartins@gmail.com', '221909566', 'Rua Monsenhor Fonseca Soares, 188', '1999-12-12');
INSERT INTO Client (personID, email, phoneNumber, address, birthDate) VALUES (5, 'andrevillasboas@fcporto.pt', '945089921', 'Via Futebol Clube do Porto, s/n', '1977-10-17');

-- inserting data into Bakery table (need to be inserted before employee)
INSERT INTO Bakery (bakeryID, name, location, phoneNumber) VALUES (1, 'Pão Quente', 'Paranhos', '210908423');
INSERT INTO Bakery (bakeryID, name, location, phoneNumber) VALUES (2, 'Massa Nobre', 'Cedofeita', '990776421');
INSERT INTO Bakery (bakeryID, name, location, phoneNumber) VALUES (3, 'Nova Armada', 'Foz', '566121009');
INSERT INTO Bakery (bakeryID, name, location, phoneNumber) VALUES (4, 'Pão e Massa', 'Lordelo do Ouro', '221889110');
INSERT INTO Bakery (bakeryID, name, location, phoneNumber) VALUES (5, 'Ribeiro', 'Lavadores', '212909333');

-- Employees
INSERT INTO Person (personID, personName, nif) VALUES (6, 'Felipe Silveira', '457189087');
INSERT INTO Person (personID, personName, nif) VALUES (7, 'Dinis Pinto', '986312765');
INSERT INTO Person (personID, personName, nif) VALUES (8, 'Margarida Ferreira', '987677012');
INSERT INTO Person (personID, personName, nif) VALUES (9, 'Inês Abreu', '765562190');
INSERT INTO Person (personID, personName, nif) VALUES (10, 'Mafalda Almeida', '823908452');

INSERT INTO Employee (personID, job, salary, hiringDate, bakeryID, isManager) VALUES (6, 'Baker', 1200, '2021-02-01', 1, 1);
INSERT INTO Employee (personID, job, salary, hiringDate, bakeryID, isManager) VALUES (7, 'Waiter', 930, '2021-02-01', 1);
INSERT INTO Employee (personID, job, salary, hiringDate, bakeryID, isManager) VALUES (8, 'Waiter', 860, '2021-06-01', 1);
INSERT INTO Employee (personID, job, salary, hiringDate, bakeryID, isManager) VALUES (9, 'Waiter', 860, '2021-06-01', 2);
INSERT INTO Employee (personID, job, salary, hiringDate, bakeryID, isManager) VALUES (10, 'Baker', 1100, '2023-01-15', 3);

-- inserting data into Fidelity table
INSERT INTO Fidelity (personID, pointsBalance, startingDate) VALUES (1, 0, '2021-04-01');
INSERT INTO Fidelity (personID, pointsBalance, startingDate) VALUES (2, 0, '2021-04-01');
INSERT INTO Fidelity (personID, pointsBalance, startingDate) VALUES (3, 0, '2021-04-01');
INSERT INTO Fidelity (personID, pointsBalance, startingDate) VALUES (4, 0, '2022-01-16');
INSERT INTO Fidelity (personID, pointsBalance, startingDate) VALUES (5, 0, '2022-05-09');

-- inserting data into Shift table
INSERT INTO Shift (shiftID, startingTime, endingTime, intervalBreak, employeeID) VALUES (1, '09:00', '14:00', '11:00', 6);
INSERT INTO Shift (shiftID, startingTime, endingTime, intervalBreak, employeeID) VALUES (2, '13:00', '20:00', '16:00', 7);
INSERT INTO Shift (shiftID, startingTime, endingTime, intervalBreak, employeeID) VALUES (3, '13:00', '20:00', '16:00', 8);
INSERT INTO Shift (shiftID, startingTime, endingTime, intervalBreak, employeeID) VALUES (1, '09:00', '14:00', '11:00', 9);
INSERT INTO Shift (shiftID, startingTime, endingTime, intervalBreak, employeeID) VALUES (2, '13:00', '20:00', '16:00', 10);

-- inserting data into Ingredient table (change the quantity)
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (1, 'Farinha', 'kg', '2023-12-31', 95);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (2, 'Açúcar', 'kg', '2023-12-31', 120);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (3, 'Ovos', 'un', '2023-12-31', 80);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (4, 'Leite', 'l', '2023-12-31', 250);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (5, 'Fermento', 'g', '2023-12-31', 500);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (6, 'Manteiga', 'kg', '2023-12-31', 20);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (7, 'Sal', 'kg', '2023-12-31', 5);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (8, 'Água', 'l', '2023-12-31', 100);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (9, 'Chocolate', 'kg', '2023-12-31', 30);
INSERT INTO Ingredient (ingredientID, name, unit, expirationDate, stockQuantity) VALUES (10, 'Canela', 'g', '2023-12-31', 50);

-- inserting data into Product table (change the products)
INSERT INTO Product (productID, name, price, productType) VALUES (1, 'Pão de Deus', 1.2, 1);
INSERT INTO Product (productID, name, price, productType) VALUES (2, 'Bolo do Caco', 0.8, 1);
INSERT INTO Product (productID, name, price, productType) VALUES (3, 'Croissant Brioche', 1.2, 1);
INSERT INTO Product (productID, name, price, productType) VALUES (4, 'Pastel de Nata', 0.5, 4);
INSERT INTO Product (productID, name, price, productType) VALUES (5, 'Pão Tigre', 1.2, 1);

-- inserting data into Order table
INSERT INTO Orders (orderID, orderDate, totalValue, orderStatus) VALUES (1, '2021-04-01', 10, 'Done');
INSERT INTO Orders (orderID, orderDate, totalValue, orderStatus) VALUES (2, '2021-04-01', 10, 'Done');
INSERT INTO Orders (orderID, orderDate, totalValue, orderStatus) VALUES (3, '2022-01-16', 30, 'Done');
INSERT INTO Orders (orderID, orderDate, totalValue, orderStatus) VALUES (4, '2023-05-09', 12, 'Done');
INSERT INTO Orders (orderID, orderDate, totalValue, orderStatus) VALUES (5, '2024-11-30', 20, 'In progress');
INSERT INTO Orders (orderID, orderDate, totalValue, orderStatus) VALUES (6, '2022-11-30', 20, 'Done');
INSERT INTO Orders (orderID, orderDate, totalValue, orderStatus) VALUES (7, '2022-10-30', 18, 'Done');

-- inserting data into Supplier table
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (1, 'LMRLF Distribuidora', '932692389');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (2, 'DM Distribuidora', '912009342');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (3, 'JMS Distribuidora', '909211004');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (4, 'Durão Distribuidora', '901112654');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (5, 'Aves Distribuidora', '978576652');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (6, 'Pinto da Costa Distribuidora', '987654321');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (7, 'Póvoa Distribuidora', '987654322');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (8, 'Minho Distribuidora', '957454623');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (9, 'Porto Supplies', '997125324');
INSERT INTO Supplier (supplierID, supplierName, contactNumber) VALUES (10, 'Ribeiro Distribuidora', '980614235');

-- inserting data into Sale table
INSERT INTO Sale (saleID, description, discountPercentage, startingDate, endingDate) Values (1,'Sale on Pão de Deus', 10, '2022-06-18','2022-07-15');
INSERT INTO Sale (saleID, description, discountPercentage, startingDate, endingDate) Values (2,'Sale on Bolo do Caco', 5, '2023-09-11','2023-09-25');
INSERT INTO Sale (saleID, description, discountPercentage, startingDate, endingDate) Values (3,'Sale on Croissant Brioche', 3, '2023-10-20','2023-10-28');
INSERT INTO Sale (saleID, description, discountPercentage, startingDate, endingDate) Values (4,'Sale on Pastel de Nata', 1, '2024-01-12','2024-05-13');
INSERT INTO Sale (saleID, description, discountPercentage, startingDate, endingDate) Values (5,'Sale on Pão Tigre', 15, '2024-09-20','2024-12-31');

-- inserting data into Delivery table
INSERT INTO Delivery (deliveryID, deliveryAddress, deliveryDate, deliveryStatus, orderID) VALUES (1, 'Rua Manuel Pacheco Miranda, 205', '2021-04-01', 'Done', 1);
INSERT INTO Delivery (deliveryID, deliveryAddress, deliveryDate, deliveryStatus, orderID) VALUES (2, 'Praça 9 de Abril, 251', '2021-04-01', 'Done', 2);
INSERT INTO Delivery (deliveryID, deliveryAddress, deliveryDate, deliveryStatus, orderID) VALUES (3, 'Rua do Breiner, 333', '2022-01-16', 'Done', 3);
INSERT INTO Delivery (deliveryID, deliveryAddress, deliveryDate, deliveryStatus, orderID) VALUES (4, 'Rua Monsenhor Fonseca Soares, 188', '2023-05-09', 'Done', 4);
INSERT INTO Delivery (deliveryID, deliveryAddress, deliveryDate, deliveryStatus, orderID) VALUES (5, 'Via Futebol Clube do Porto, s/n', '2024-11-30', 'In progress', 5);

-- inserting data into Rating table
INSERT INTO Rating (ratingID, score, comment, clientID, orderID) VALUES (1, 5, 'Muito bom!', 1, 1);
INSERT INTO Rating (ratingID, score, comment, clientID, orderID) VALUES (2, 4, 'Bom!', 2, 2);
INSERT INTO Rating (ratingID, score, comment, clientID, orderID) VALUES (3, 3, 'Meh', 3, 3);
INSERT INTO Rating (ratingID, score, comment, clientID, orderID) VALUES (4, 2, 'Mau', 4, 4);
INSERT INTO Rating (ratingID, score, comment, clientID, orderID) VALUES (5, 1, 'Muito mau', 5, 5);
INSERT INTO Rating (ratingID, score, comment, clientID, orderID) VALUES (6, 5, 'Muito bom!', 1, 6);
INSERT INTO Rating (ratingID, score, comment, clientID, orderID) VALUES (7, 4, 'Bom!', 2, 7);

-- inserting data into Payment table
INSERT INTO Payment (paymentID, paymentMethod, paymentDate, paymentValue, orderID) VALUES (1, 'MBWay', '2021-04-01', 10, 1);
INSERT INTO Payment (paymentID, paymentMethod, paymentDate, paymentValue, orderID) VALUES (2, 'Card', '2021-04-01', 10, 2);
INSERT INTO Payment (paymentID, paymentMethod, paymentDate, paymentValue, orderID) VALUES (3, 'Cash', '2022-01-16', 10, 3);
INSERT INTO Payment (paymentID, paymentMethod, paymentDate, paymentValue, orderID) VALUES (4, 'MBWay', '2023-05-09', 10, 4);
INSERT INTO Payment (paymentID, paymentMethod, paymentDate, paymentValue, orderID) VALUES (5, 'Card', '2024-11-30', 10, 5);
INSERT INTO Payment (paymentID, paymentMethod, paymentDate, paymentValue, orderID) VALUES (6, 'Card', '2022-11-30', 20, 6);
INSERT INTO Payment (paymentID, paymentMethod, paymentDate, paymentValue, orderID) VALUES (7, 'Cash', '2022-10-30', 18, 7);