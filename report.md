# Final Report on *Padaria* Database Project

## Context Description
As we defined before, our project will be about a Portuguese bakery and we will refer to it as _Padaria_ during this and further reports.

Every _Padaria_ has its name, location, contact info and its own set of employees and it is important to know who is the manager. Evidently, the manager must be one of the employees. For simplification, we will consider that there is only one manager per _Padaria_. Also about the employees, we must store their shift to be able to see if the hours of work are being equally distributed and to be able to link an employee to an order. Having this link makes it easier to have better quality control, since you can be sure of who did something wrong (or to be able to praise someone for doing good).

The most important part of a _Padaria_ is the order a client makes. In this order the client can choose products from a list of options, including beverages, cakes, pastries, breads and other. For each product it can be made in the bakery or can be bought already done. Because of this, it is interesting to store who the suppliers are and basic information about them. For paying for the order, the client can use any common method and the client will be able to use fidelity points that he/she will earn after buying any products.

Last but not least, сustomers can order food from home, and our team handles the deliveries directly. We’ve included a **Delivery** class to keep track of important details. This makes it easy to organize home deliveries and ensures everything runs smoothly within our system.

## Conceptual Model
### Initial Conceptual Model
To create a UML diagram for the *Padaria* database, we looked closely at the main classes, their attributes, and how they relate to each other. The model is made to cover all the business needs and show how the data system works. In this section, we will explain the classes, constraints, associations, and multiplicities to give a clear view of how everything interacts within the system.

The diagram uses classes to represent the key parts of our system. We’ve described each relationship, association, and multiplicity while keeping in mind any derived elements and constraints. This way, we can better understand the business logic and how the database is set up.

Classes and their attributes:
- **Client**
  - *Attributes:* clientID, clientName, email, phoneNumber, address.
  - *Constraints:* Each client has a unique ClientID to ensure data accuracy and prevent duplicate entries.

- **Employee**
    - *Attributes:* employeeID, employeeName, job, salary, hiringDate.
    - *Constraints:* EmployeeID uniquely identifies each employee, essential for payroll and staff management.

- **Order**
  - *Attributes:* orderID, orderDate, totalValue, orderStatus.
  - *Constraints:* The total value of an order can be calculated based on the sum of all product prices included in the order.

- **Product**
  - *Attributes:* productID, productName, price, stockQuantity, productType.
  - *Constraints:* Stock quantity must always be non-negative to avoid inventory issues.

- **Payment**
  - *Attributes:* paymentID, paymentMethod, paymentDate, paymentValue.
  - *Constraints:* Each payment is linked to a specific order, enabling precise tracking of transactions.

- **Sale**
  - *Attributes:* saleID, description, discountPercentage, startingDate, endingDate.
  - *Constraints:* The promotion is only active within its defined period to ensure accurate discount application.

- **Shift**
  - *Attributes:* shiftID, startingTime, endingTime, intervalBreak.
  - *Constraints:* The shift start time must always precede the end time.

- **Ingredient**
  - *Attributes:* ingredientID, name, stockQuantity, unit, expirationDate.
  - *Constraints:* Ingredient stock levels must be maintained as non-negative to avoid production delays.

- **Supplier**
  - *Attributes:* supplierID, supplierName, contactNumber.
  - *Constraints:* Each ingredient is associated with a specific supplier, ensuring traceability of the source.

- **Rating**
  - *Attributes:* ratingID, score, comments.
  - *Constraints:* Each rating is tied to a specific order or product, allowing for detailed customer feedback.

- **Delivery**
  - *Attributes:* deliveryID, deliveryAddress, deliveryDate, deliveryStatus.
  - *Constraints:* Delivery status can be set to ‘In Process’, ‘Delivered’, or ‘Canceled’, allowing for accurate logistics tracking.

Key associations and multiplicities between the classes have been defined to detail how system components interact with one another:

- **Client — Order** (One-to-Many): A single client can place multiple orders, which supports tracking repeat customers.
- **Rating — Client** (Many-to-One): A client can leave multiple ratings, but each rating is linked to a specific client.
- **Payment — Order** (One-to-One): Each payment is directly associated with one order, ensuring proper payment allocation.
- **Sale — Product** (Many-to-Many): A product can be part of several sales, and a sale can cover multiple products.
- **Employee — Product** (Many-to-Many): Employees can work on multiple products, and each product can be managed by several employees.
- **Employee — Order** (One-to-Many): One employee can handle many orders during their shift.
- **Shift — Employee** (Many-to-Many): An employee can work in different shifts, and each shift can have multiple employees assigned.
- **Order — Product** (One-to-Many): Each order can include multiple products.
- **Rating — Order** (One-to-One): Each order can have a single unique rating.
- **Delivery — Order** (One-to-Many): One delivery can group multiple orders for efficiency.
- **Product — Ingredient** (One-to-Many): Products are made from multiple ingredients.
- **Ingredient — Supplier** (Many-to-One): One supplier can supply many ingredients.

#### Initial UML Diagram
![Initial UML Diagram](/assets/Initial%20Diagram.png)

### AI Support
For this task, we leveraged a generative AI tool (ChatGPT) to assist in refining our initial conceptual model for the Padaria bakery database. The goal was to evaluate whether the AI could offer insights or improvements to our existing model, particularly in terms of constraints, relationships, and 
attributes.

**Sequence of Interaction with AI:**

We began by submitting the initial conceptual model, describing the classes, attributes, and relationships involved. The AI then reviewed the model and provided various suggestions, which we critically assessed. Some of the suggestions were valuable and led to modifications in our final model, while others were deemed unnecessary or overly complex (at the end of this section you can see the full answer from ChatGPT).

**Critical Assessment of Results**

The AI provided some useful recommendations, and we have decided to incorporate the following suggestions into our final model:

1. **Stock Quantity Constraints:** The AI emphasized the importance of ensuring that StockQuantity for both products and ingredients never falls below zero. This is essential for maintaining accurate inventory levels. We agreed with this suggestion and will implement validation logic to enforce this constraint. This ensures that products and ingredients always have non-negative stock values, preventing inventory issues.

2. **New Client Attributes:** The AI recommended adding DateOfBirth and TaxNumber attributes to the Client class. This enhancement allows us to collect more detailed information about our customers, which could be useful for tax reporting purposes, loyalty programs, or personalized marketing efforts. We found this suggestion beneficial and decided to incorporate it into the model.

However, not all AI recommendations were adopted. For instance, the AI proposed adding a separate "Promotion" or "OrderItem" class to provide more granularity in the handling of promotions and the breakdown of orders. While this could add detail, we felt that the existing “Sale" class and the way Order manages its relationship with Product already meet our needs without unnecessary complexity. Furthermore, suggestions related to adding more granular tracking of shifts and employee roles were deemed excessive for the bakery’s current operational scope.

**Suggestions from ChatGPT**
1. **Missing Entity: Cart/Order_Item:**
   - Since one order can contain multiple products, you should have an intermediary entity, usually called Order_Item or Cart, to represent the quantity of each product in an order. This will help better track items within an order (especially if there are different quantities of the same product in one order).

   - Attributes for Order_Item: Order_ItemID (primary key), OrderID (foreign key), ProductID (foreign key), Quantity (number of products)

2. **Additions to Existing Entities:**
  - *Client:* Include DateOfBirth or RegistrationDate to allow customer segmentation based on time of registration or age.
  - *Employee:* You can add an EmployeeType attribute to differentiate between part-time/full-time employees, bakers, delivery staff, or administrative employees.
  - *Order:* Consider adding DeliveryFee and Tax, as they are often part of the final order total.

3. **New Entity:** *Promotion:*
You mentioned that the *"Sale"* entity represents promotions. However, creating a distinct Promotion entity would allow you to manage specific promotions separately from actual sales. You could then link Promotion to Product via a Product_Promotion table.
   - Attributes for Promotion: PromotionID (primary key), PromotionName, DiscountPercentage PromotionStartDate, PromotionEndDate

4. **Relationship between Product and Order:**
There should be a *Many-to-Many relationship* between Order and Product, which is missing. Introducing a linking table like Order_Item will help you track which product belongs to which order and in what quantity.

5. **Delivery to Client:**
It might be useful to track deliveries by linking them to the client directly, not just through orders. In some cases, a client might have a recurring delivery schedule or multiple deliveries over time.

**Constraint and Multiplicity Analysis**
- **Shift Constraints:** Ensure that StartingTime < EndingTime. This is crucial for shift logic and scheduling. You already mentioned it, but implementing it at the database level is important.
- **Stock Quantity Constraints:** Both Product and Ingredient have a StockQuantity. You need to ensure stock is always non-negative, either through triggers or validation logic.
- **Payment-One-to-One:** Ensure the one-to-one relationship between Payment and Order is enforced at the database level so that no order is paid for twice or left unpaid. You might also consider a scenario where multiple payment methods are allowed for an order (part-cash, part-card).
- **Many-to-Many Relationships:** Currently, many-to-many relationships (like Employee to Product, and Sale to Product) will require intermediary tables, such as Employee_Product and Sale_Product. Ensure these intermediary entities are implemented for accurate database design.
- **Optional Relationships:** Make sure relationships like Rating to Order or Rating to Client are optional, as not every client will leave a rating.

**Recommendations for Optimizing Data Flow and Reducing Redundancy**
1. **Intermediate Entities:** As noted, introduce intermediary tables like Order_Item to manage many-to-many relationships between Order and Product. This will eliminate redundancy and ensure better data integrity.

2. **Remove StockQuantity from Product if using Ingredients:**
If the bakery’s inventory system revolves around ingredients rather than finished products (i.e., the bakery tracks the quantity of flour, sugar, etc.), it may be better to manage stock via the Ingredient entity and derive the available stock of Product based on the available ingredients.

3. **Promotion Period Enforcement:**
Ensure that the Sale/Promotion dates are consistently enforced when applying discounts to products. This can be done via database constraints or application-level logic to prevent promotions from being used outside of their valid dates.

**Recommended Changes to UML Diagram**
- Introduce intermediary entities like Order_Item and Product_Promotion to simplify many-to-many relationships and better track items in orders.
- Add new attributes (like DateOfBirth, EmployeeType, and Tax) where necessary to cover important bakery operations.
- Add optional relationships between entities like Rating and Client, ensuring they're flexible enough to reflect real-world processes.

#### Python Code to Generate UML

Below is Python code using the graphviz library that can help generate a UML diagram based on the suggested improvements:

The revised model introduces better management for many-to-many relationships with intermediary entities (Order_Item and Product_Promotion). Additional attributes for clients, employees, and orders increase the flexibility of the database. These changes reflect the need for more granular tracking of orders, stock, and employees in a bakery setting.

```python
from graphviz import Digraph

# Create a new directed graph
uml_diagram = Digraph('UML Diagram', filename='bakery_db_uml', format='png')

# Define classes
classes = {
    'Client': ['clientID', 'clientName', 'email', 'phoneNumber', 'address', 'dateOfBirth'],
    'Employee': ['employeeID', 'employeeName', 'job', 'salary', 'hiringDate', 'employeeType'],
    'Order': ['orderID', 'orderDate', 'totalValue', 'orderStatus', 'deliveryFee', 'tax'],
    'Product': ['productID', 'productName', 'price', 'stockQuantity', 'productType'],
    'Order_Item': ['orderItemID', 'orderID', 'productID', 'quantity'],
    'Payment': ['paymentID', 'paymentMethod', 'paymentDate', 'paymentValue'],
    'Shift': ['shiftID', 'startingTime', 'endingTime', 'intervalBreak'],
    'Ingredient': ['ingredientID', 'name', 'stockQuantity', 'unit', 'expirationDate'],
    'Supplier': ['supplierID', 'supplierName', 'contactNumber'],
    'Sale': ['saleID', 'description', 'discountPercentage', 'startingDate', 'endingDate'],
    'Promotion': ['promotionID', 'promotionName', 'discountPercentage', 'promotionStartDate', 'promotionEndDate'],
    'Rating': ['ratingID', 'score', 'comments'],
    'Delivery': ['deliveryID', 'deliveryAddress', 'deliveryDate', 'deliveryStatus']
}

# Add nodes to UML diagram
for class_name, attributes in classes.items():
    uml_diagram.node(class_name, label=f"{class_name}|{'|'.join(attributes)}")

# Define relationships
uml_diagram.edge('Client', 'Order', label='1-to-many')
uml_diagram.edge('Order', 'Payment', label='1-to-1')
uml_diagram.edge('Order', 'Delivery', label='many-to-1')
uml_diagram.edge('Order', 'Order_Item', label='1-to-many')
uml_diagram.edge('Order_Item', 'Product', label='many-to-1')
uml_diagram.edge('Sale', 'Product', label='many-to-many')
uml_diagram.edge('Employee', 'Order', label='1-to-many')
uml_diagram.edge('Shift', 'Employee', label='many-to-many')
uml_diagram.edge('Rating', 'Order', label='1-to-1')
uml_diagram.edge('Product', 'Ingredient', label='many-to-1')
uml_diagram.edge('Ingredient', 'Supplier', label='many-to-1')
uml_diagram.edge('Promotion', 'Product', label='many-to-many')

# Render the UML diagram
uml_diagram.render()
```

### Refined Conceptual Model
After receiving feedback from ChatGPT, we decided to make selective changes to the conceptual model based on the value they would add to the system while rejecting others that introduced complexity without tangible benefits. Here’s a detailed explanation of the decisions made:

**Changes adopted:**
1. **Stock Quantity Constraints:**

    We initially included a StockQuantity attribute in both the Product and Ingredient classes. However, after taking a closer look at how our system works, we decided to remove the StockQuantity from the Product class and keep it only in the Ingredient class. This change makes stock management easier because we can track inventory using just the raw ingredients. This way, we avoid duplication and can accurately check if we have enough ingredients to make a product.

    **How it is enforced:**

    By managing stock levels at the ingredient level, we can keep better track of inventory and make restocking simpler. We'll still use application logic or database triggers to ensure that ingredient stock never goes below zero. This helps us avoid issues like promising more products than we can actually make or facing delays in production.

2. **Additional Client Attributes:**

    Another valuable recommendation was adding the attributes DateOfBirth and TaxNumber to the Client class. Initially, our model only stored basic client information (e.g., name, email, phone and address). However, by including these additional attributes, we can offer more tailored services and improve compliance with tax regulations.
    
    - The birthDate attribute can be useful for personalizing customer interactions, such as offering birthday discounts or targeted marketing based on age.
    - The TaxNumber/NIF is particularly relevant for businesses that require this information for legal or tax reporting purposes, such as invoicing and loyalty programs.

3. **Other minor changes**

    After reanalyzing the initial diagram, we saw that we did not have the “Bakery” class and did not have the “manager” relation for the employees, so we created them. Also, we were not sure about how to implement the “Fidelity” idea in our diagram, so we only managed to create the class on the refined model.

These enhancements enable more personalized customer service and improve the system's future adaptability to legal requirements.

**Suggestions rejected:**

While ChatGPT provided several useful recommendations, not all were implemented due to considerations around the complexity they would add relative to their value for Padaria's operational needs. Here's a deeper dive into why certain suggestions were not adopted:

1. ***Promotion* Class for Handling Sales:**

    The AI recommended adding a new class called "Promotion" to more effectively manage discounts and sales. This would introduce a separate entity for managing promotional activities, which could allow for greater flexibility in handling discounts, bundles, or seasonal offers.

    **Why it was not adopted:**

    After reviewing this suggestion, we concluded that the existing Sale class already sufficiently manages the promotion aspect within the system. The current model includes attributes like DiscountPercentage, StartingDate, and EndingDate, which cover the essential needs of running promotions. Adding a new "Promotion" class would complicate the system without delivering significant operational benefits, as the Sale class already supports our current promotional mechanisms.

2. ***OrderItem* Class for Detailed Order Management:**

    Another suggestion was to add an "OrderItem" class to break down orders into finer details, including individual items, quantities, and prices. This could provide more detailed tracking of orders and their components.

    **Why it was not adopted:**

    While this suggestion adds more granularity, it also increases the complexity of the order management system. For a bakery like Padaria, which operates on a relatively straightforward ordering system, the current Order and Product relationships already capture the necessary data without needing an additional "OrderItem" intermediary. Our existing system allows us to track which products are part of each order, and adding more layers would introduce unnecessary complexity into the model without providing significant operational benefits.

    The bakery's business model doesn't require the level of granularity that an "OrderItem" class would offer, and the additional database overhead and complexity would not justify the marginal gains in functionality.

3. **Detailed Shift Management:**

    The AI also suggested refining the shift management by adding more details about roles, shift assignments, or tracking exact hours worked for payroll purposes.

    **Why it was not adopted:**

    While detailed shift management could be beneficial for some industries, the bakery’s current operational scale doesn’t warrant this level of tracking. We already track which employees work in which shifts, and this suffices for managing daily operations. Adding more complexity to shift tracking would increase the overhead without improving business efficiency or adding substantial value to the bakery’s scheduling processes. For now, the existing Shift and Employee relationship meets our needs.

**Final Decision on the Conceptual Model:**

The main goal of our conceptual model is to ensure that it is simple, efficient, and aligned with the business needs of a bakery. While ChatGPT provided helpful insights, we chose to adopt only those suggestions that enhance functionality without introducing unnecessary complexity.

Our final model prioritizes:

- **Data integrity:** By managing stock levels at the ingredient level, we ensure that our inventory data remains accurate and avoids potential issues related to over-promising available stock.
- **Customer Personalization:** By adding DateOfBirth and TaxNumber to the client data, we can offer personalized services and ensure compliance with tax regulations.
- **Simplicity:** We rejected suggestions that would overcomplicate the system, ensuring the model remains easy to manage and well-suited to the bakery’s needs.

While working on our database model, we realized there were a couple of ways we could make it better, so we added two new classes: Bakery and Fidelity. These ideas weren’t directly from the AI, but the insights it provided nudged us to see where we could make some valuable improvements.

**Bakery Class:**

At first, our model mostly focused on clients and products, but we quickly realized we were missing something important: the bakery locations themselves. So, we introduced the Bakery class to represent each branch. This addition lets us store all the key details like the name, location, and contact info of each bakery.

Plus, we added a link to the manager, showing which employee is in charge of each branch. This little detail helps us keep things organized, making it easier to see how each location is doing and where we might need to lend a hand. Adding this class means our system can now handle multiple bakery branches smoothly, which makes the whole setup more adaptable and easier to manage.

**Fidelity Class:**

We also thought it was time to do something special for our loyal customers, so we created the Fidelity class. Before, we just had basic info on clients, but we wanted to step it up by offering a way to reward regulars and keep them coming back. The Fidelity class does exactly that by keeping track of each customer’s points balance and membership start date, making it easy for us to manage rewards.

This loyalty program is a win-win: customers get rewarded for sticking around, and we get more repeat business. They can collect points and use them for discounts or special perks. By building this feature directly into the database, we’ve made it a breeze to run promotions and offer personalized deals. In the end, adding the Fidelity class is all about building stronger relationships with our customers and boosting loyalty.

#### Refined UML Diagram
![Refined UML Diagram](/assets/Refined%20Diagram.png)

### Final Conceptual Model
After the intermediary version of our project, we implemented the feedback provided by our professor.

The feedback focused on two specific issues. First, while most of our classes included an ID attribute, but “Fidelity” class and “Bakery” classes did not. Second, it was suggested that we create a generalization between “Client” and “Employee”, as both represent people.

In order to solve these problems, we added ID attributes to the “Fidelity” and “Bakery” classes to ensure consistency across class attributes. In the “Fidelity” class case, the ID references the clientID, since each client has one fidelity program associated exclusively with them. The second issue was resolved by creating a superclass called “Person” to generalize the common attributes between “Client” and “Employee”.

During the final steps of preparation for this submission, we realized that some attributes in our database were redundant, while others were unnecessary. As a result, we modified the final conceptual model to ensure consistency and alignment with the overall design.

#### Final UML Diagram
![Final UML Diagram](/assets/Final%20Diagram.png)

## Relational Schema
### Initial Relational Schema
Using the final version of our conceptual model, we created our initial relational schema. In doing that, we indicated the primary keys and foreign keys of all of our relations.

#### Initial Schema
**Person**(<u>personID</u>, personName, nif)
- Primary Key (PK): personID

**Client**(<u>personID</u> -> Person.personID, email, phoneNumber, address, birthDate)
- Primary Key (PK): personID
- Foreign Key (FK): personID -> Person.personID

**Employee**(<u>personID</u> -> Person.personID, job, salary, hiringDate, bakeryID -> Bakery.bakeryID, isManager, shiftID -> Shift.shiftID)
- Primary Key (PK): personID
- Foreign Key (FK): personID -> Person.personID, bakeryID -> Bakery.bakeryID, shiftID -> Shift.shiftID

**Bakery**(<u>bakeryID</u>, name, location, phoneNumber)
- Primary Key (PK): bakeryID

**Fidelity**(<u>personID</u> -> Client.personID, pointsBalance, startingDate)
- Primary Key (PK): personID
- Foreign Key (FK): personID -> Client.personID

**Shift**(<u>shiftID</u>, startingTime, endingTime, intervalBreak, employeeID -> Employee.personID)
- Primary Key (PK): shiftID
- Foreign Key (FK): employeeID -> Employee.personID

**Product**(<u>productID</u>, name, price, productType -> Ingredient.ingredientID)
- Primary Key (PK): productID
- Foreign Key (FK): productType -> Ingredient.ingredientID

**Ingredient**(<u>ingredientID</u>, name, unit, expirationDate, stockQuantity)
- Primary Key (PK): ingredientID

**Supplier**(<u>supplierID</u>, supplierName, contactNumber)
- Primary Key (PK): supplierID

**Sale**(<u>saleID</u>, description, discountPercentage, startingDate, endingDate, productID -> Product.productID)
- Primary Key (PK): saleID
- Foreign Key (FK): productID -> Product.productID

**Delivery**(<u>deliveryID</u>, deliveryAddress, deliveryDate, deliveryStatus, orderID -> Order.orderID)
- Primary Key (PK): deliveryID
- Foreign Key (FK): orderID -> Order.orderID

**Rating**(<u>ratingID</u>, score, comment, clientID -> Client.personID, orderID -> Order.orderID)
- Primary Key (PK): ratingID
- Foreign Key (FK): clientID -> Client.personID, orderID -> Order.orderID

**Payment**(<u>paymentID</u>, paymentMethod, paymentDate, paymentValue, orderID -> Order.orderID)
- Primary Key (PK): paymentID
- Foreign Key (FK): orderID -> Order.orderID

Order(<u>orderID</u>, orderDate, totalValue, orderStatus)
- Primary Key (PK): orderID

### AI Support
For this task, we used a generative AI tool (ChatGPT) to refine our relational schema. We provided the AI with our updated conceptual model revised after feedback along with our initial relational schema. The AI reviewed our work and suggested improvements, such as clarifying relationships and constraints.

**Answer from Chat GPT:**

After reviewing your schema, I can confirm it is well-structured and aligns effectively with the conceptual model provided. It adheres to normalization principles, and the relationships between entities are clearly defined. However, I have a few suggestions that could improve usability and clarity, depending on your project’s needs:

**Suggestions for Improvement:**

1. **Clarify Optional Relationships:**
- Relationships like Bakery <=> Employee *(Manager*) and Client <=> Fidelity are optional but not explicitly enforced as such in the schema.
- **Suggestion:** Add nullable foreign keys (NULL allowed) or document this behavior explicitly in the schema's documentation.

2. **Shift Table Simplification:**
- Including shiftID directly in the Employee table limits flexibility for employees who may work in multiple shifts.
- **Alternative:** If necessary, consider reintroducing a junction table like EmployeeShift to represent the many-to-many relationship between employees and shifts for better scalability.

3. **isManager Field in Employee:**
- While useful, relying on isManager (with values 0 or 1) may become challenging in larger systems.
- **Alternative:** Use a dedicated relationship (Manager table) or add constraints that ensure only one manager exists per bakery.

4. **Order <=> Product Relationship:**
- Many-to-many relationships like Order <=> Product are often handled using a junction table, which is currently managed programmatically.
- **Suggestion:** If your application involves frequent queries involving orders and products, consider introducing a junction table (OrderProduct) to simplify query logic.

If simplicity and lightweight implementation are key, your schema as-is is valid. The suggestions above are optional and only applicable if the specific use case or scalability demands it. I do not recommend changes unless these challenges are encountered in practical use.

### Final Relational Schema

**Proposed Final Schema and Defense:**

Our schema is already well-structured and aligns perfectly with the project requirements and the UML model. After analyzing the feedback from generative AI, we have decided to maintain our schema as it is, as the proposed suggestions are optional and would introduce unnecessary complexity without significant benefits.

**Why our schema works:**

1. **Simplicity and Clarity:**

Our schema is straightforward and avoids unnecessary complexity. This makes it easier to work with, especially when handling queries and maintaining the database.

Introducing additional tables or attributes, as suggested by AI, is not essential for our current use case and would only complicate the design.


2. **Alignment with the UML Model:**

We have designed the schema to strictly follow the UML model without unauthorized changes. This ensures consistency between the conceptual model and the database implementation.

3. **Relationships Managed Intelligently:**

Some relationships, like **Order <=> Product** and **Order <=> Client**, are not explicitly enforced in the schema but are easily managed through application logic or external documentation. This keeps the schema simple and efficient.

4. **Practical for Our Needs:**

Our database is designed for real-world scenarios. Adding junction tables or additional attributes, as suggested by AI, would complicate queries and increase overhead unnecessarily.

**Key Suggestions from AI and Our Decisions:**

1. **Order <=> Client:**
- **AI Suggestion:** Add clientID to the Order table to explicitly link orders to clients.
- **Our Decision:** This is unnecessary for our case, as the relationship can be managed programmatically. Keeping the schema as-is ensures simplicity.

2. **Order <=> Product:**
- **AI Suggestion:** Introduce a junction table to handle many-to-many relationships between orders and products.
- **Our Decision:** For our use case, this relationship can be handled outside the schema. Adding a junction table would complicate queries without significant advantages.

3. **Shift Independence:**
- **AI Suggestion:** Rethink the relationship between Shift and Employee.
- **Our Decision:** The current setup is sufficient and adheres to the UML model. There is no need for changes.

**Conclusion:**

The AI suggestions were carefully reviewed, and while they provide valuable options, we opted not to implement them, as our schema already satisfies project requirements and is well-optimized. Maintaining our current design ensures simplicity, usability, and alignment with the UML model without unnecessary overhead.

## Functional Dependencies and Normal Form Analysis
### Initial Functional Dependencies and Normal Form Analysis
Here’s our analysis of the functional dependencies and normalization for each table in the schema. We checked for violations of Boyce-Codd Normal Form (BCNF) and Third Normal Form (3NF) and explained why the tables are already normalized.

1. **Person**
- **Relation:** Person(<u>personID</u>, personName, nif)
- **Functional Dependencies:**
  - personID -> personName, nif
- **Analysis:** The primary key is personID and it determines all other attributes. There are no extra dependencies or violations.
- **Conclusion:** Already in BCNF and 3NF.

2. **Client**
- **Relation:** Client(<u>personID -> Person.personID</u>, email, phoneNumber, address, birthDate)
- **Functional Dependencies:**
  - personID -> email, phoneNumber, address, birthDate
- **Analysis:** The primary key is personID, and it determines all other attributes. No issues like partial or transitive dependencies exist.
- **Conclusion:** In BCNF and 3NF.

3. **Employee**
- **Relation:** Employee(<u>personID -> Person.personID</u>, job, salary, hiringDate, bakeryID -> Bakery.bakeryID, isManager, shiftID -> Shift.shiftID)
- **Functional Dependencies:**
  - personID -> job, salary, hiringDate, bakeryID, isManager, shiftID
- **Analysis:** The primary key is personID, and it uniquely determines all other attributes. No partial dependencies exist because there are no attributes dependent on a subset of the primary key. No transitive dependencies exist because every non-key attribute depends directly on the primary key. Therefore, there are no violations.
- **Conclusion:** In BCNF and 3NF.

4. **Bakery**
- **Relation:** Bakery(<u>bakeryID</u>, name, location, phoneNumber)
- **Functional Dependencies:**
  - bakeryID -> name, location, phoneNumber
- **Analysis:** The primary key is bakeryID, which determines all other fields. No extra dependencies.
- **Conclusion:** In BCNF and 3NF.

5. **Fidelity**
- **Relation:** Fidelity(<u>personID -> Client.personID</u>, pointsBalance, startingDate)
- **Functional Dependencies:**
  - personID -> pointsBalance, startingDate
- **Analysis:** fidelityProgramID is the primary key and determines everything. No extra dependencies or violations.
- **Conclusion:** In BCNF and 3NF.

6. **Shift**
- **Relation:** Shift(<u>shiftID</u>, startingTime, endingTime, intervalBreak, employeeID -> Employee.personID)
- **Functional Dependencies:**
  - shiftID -> startingTime, endingTime, intervalBreak, employeeID
- **Analysis:** shiftID is the primary key and determines all other attributes. No violations.
- **Conclusion:** In BCNF and 3NF.

7. **Product**
- **Relation:** Product(<u>productID</u>, name, price, productType -> Ingredient.ingredientID)
- **Functional Dependencies:**
  - productID -> name, price, productType
- **Analysis:** productID is the primary key and determines everything else. No extra dependencies or violations.
- **Conclusion:** In BCNF and 3NF.

8. **Ingredient**
- **Relation:** Ingredient(<u>ingredientID</u>, name, unit, expirationDate, stockQuantity)
- **Functional Dependencies:**
  - ingredientID -> name, unit, expirationDate, stockQuantity
- **Analysis:** ingredientID is the primary key and determines all other fields. No issues here.
- **Conclusion:** In BCNF and 3NF.

9. **Supplier**
- **Relation:** Supplier(<u>supplierID</u>, supplierName, contactNumber)
- **Functional Dependencies:**
  - supplierID -> supplierName, contactNumber
- **Analysis:** supplierID is the primary key and determines all other fields. No violations.
- **Conclusion:** In BCNF and 3NF.

10. **Sale**
- **Relation:** Sale(<u>saleID</u>, description, discountPercentage, startingDate, endingDate, productID -> Product.productID)
- **Functional Dependencies:**
  - saleID -> description, discountPercentage, startingDate, endingDate, productID
- **Analysis:** saleID is the primary key and determines all other attributes. No extra dependencies or problems.
- **Conclusion:** In BCNF and 3NF.

11. **Delivery**
- **Relation:** Delivery(<u>deliveryID</u>, deliveryAddress, deliveryDate, deliveryStatus, orderID -> Order.orderID)
- **Functional Dependencies:**
  - deliveryID -> deliveryAddress, deliveryDate, deliveryStatus, orderID
- **Analysis:** deliveryID is the primary key and determines all fields. No violations here.
- **Conclusion:** In BCNF and 3NF.

12. **Rating**
- **Relation:** Rating(<u>ratingID</u>, score, comment, clientID -> Client.personID, orderID -> Order.orderID)
- **Functional Dependencies:**
  - ratingID -> score, comment, clientID, orderID
- **Analysis:** ratingID is the primary key and determines everything else. There are no partial or transitive dependencies.
- **Conclusion:** In BCNF and 3NF.

13. **Payment**
  - **Relation:** Payment(<u>paymentID</u>, paymentMethod, paymentDate, paymentValue, orderID -> Order.orderID)
  - **Functional Dependencies:**
    - paymentID -> paymentMethod, paymentDate, paymentValue, orderID
  - **Analysis:** paymentID is the primary key and determines all other fields. No violations exist.
  - **Conclusion:** In BCNF and 3NF.

14. **Order**
- **Relation:** Order(<u>orderID</u>, orderDate, totalValue, orderStatus)
- **Functional Dependencies:**
  - orderID -> orderDate, totalValue, orderStatus
- **Analysis:** orderID is the primary key and determines all other attributes. No partial or transitive dependencies exist.
- **Conclusion:** In BCNF and 3NF.

**Final thoughts**

After analyzing all the tables, we found that none of them violate BCNF or 3NF. Each table is properly normalized because each primary key uniquely identifies all other attributes in the table and there are no partial or transitive dependencies in any table. The schema is clean and ready for use.


### AI Support
Below is how generative AI assisted us in the functional dependency analysis and normalization process.

Input to AI:
```
Provide the schema for each table, listing its attributes.

Share the identified functional dependencies for each table.

Check for compliance with BCNF and 3NF
```

AI Generated Output:
```
Validation of functional dependencies and identification of any normalization issues.

Suggestions for further decomposition if violations of BCNF or 3NF are found.
```

1. **Person**
- **FDs:** personID -> personName, nif
- **Conclusion:** No issues. In BCNF and 3NF.

2. **Client**
- **FDs:** personID -> email, phoneNumber, address, birthDate
- **Conclusion:** No issues. In BCNF and 3NF.

3. **Employee**
- **FDs:** personID -> job, salary, hiringDate, bakeryID, isManager, shiftID
- **Conclusion:** No issues. In BCNF and 3NF.

4. **Bakery**
- **FDs:** bakeryID -> name, location, phoneNumber
- **Conclusion:** No issues. In BCNF and 3NF.

5. **Fidelity**
- **FDs:** personID -> pointsBalance, startingDate
- **Conclusion:** No issues. In BCNF and 3NF.

6. **Order**
- **FDs:** orderID -> orderDate, totalValue, orderStatus
- **Conclusion:** No issues. In BCNF and 3NF.

7. **Product**
- **FDs:** productID -> name, price, productType
- **Conclusion:** No issues. In BCNF and 3NF.

8. **Shift**
- **FDs:** shiftID -> startingTime, endingTime, intervalBreak
- **Conclusion:** No issues. In BCNF and 3NF.

9. **Ingredient**
- **FDs:** ingredientID -> name, unit, expirationDate, stockQuantity
- **Conclusion:** No issues. In BCNF and 3NF.

10. **Supplier**
- **FDs:** supplierID -> supplierName, contactNumber
- **Conclusion:** No issues. In BCNF and 3NF.

11. **Sale**
- **FDs:** saleID -> description, discountPercentage, startingDate, endingDate, productID
- **Conclusion:** No issues. In BCNF and 3NF.

12. **Delivery**
- **FDs:** deliveryID -> deliveryAddress, deliveryDate, deliveryStatus, orderID
- **Conclusion:** No issues. In BCNF and 3NF.

13. **Rating**
- **FDs:** ratingID -> score, comment, clientID, orderID
- **Conclusion:** No issues. In BCNF and 3NF.

14. **Payment**
- **FDs:** paymentID -> paymentMethod, paymentDate, paymentValue, orderID
- **Conclusion:** No issues. In BCNF and 3NF.

### Final Functional Dependencies and Normal Form Analysis
After using AI tools to assist in the analysis, we validated and refined our initial functional dependency and normalization review.

As it was shown on the previous point, there was nothing to change on our initial analysis since there was no violation due to every table having an ID attribute.

## Database Creation Script
### Initial SQLite "create" Script
The “create1.sql” is our first version of the script responsible for creating the database tables. It is available in our submission and it can be accessed [here](scripts/create1.sql).

As explained in the script file, we chose the TEXT datatype for storing dates, as SQLite does not have a native DATE datatype. Additionally, we opted for the 'YYYY-MM-DD' format for storing dates in text.

Another important point to highlight is that we needed to change the Order table in our create file because SQLite does not accept to create a table named with a keyword. Because of that, it is renamed as Orders.

### AI Support
After the first version, we utilized ChatGPT, a generative AI tool, to gain insights on potential improvements for our initial script.

**Suggestions for Improving Your Code:**
After reviewing your SQL script for Task 5.1.8, here are suggestions for improvement:

1. **Standardize Data Types:**
- Use consistent data types for primary keys and foreign keys (e.g., INTEGER PRIMARY KEY and INTEGER).
- Ensure numeric values such as salary or price have sufficient precision if needed.

2. **Enhance Constraints for Data Integrity:**
- Add default values for fields like isManager (e.g., DEFAULT 0) to avoid the need to specify values for non-manager employees explicitly.
- Enforce additional business logic constraints via CHECK, where applicable:
  - *Example:* Ensure discountPercentage in the Sale table is between 0 and 100.


3. **Improve Handling of Many-to-Many Relationships:**
- Add a junction table for the **Employee <=> Shift** many-to-many relationship, as the employeeID in the Shift table currently assumes a one-to-one or many-to-one relationship.

4. **Default Values for Common Fields:**
- Set defaults for common attributes where feasible:
  - *Example:* deliveryStatus could default to Pending.

5. **Prepare for Flexibility:**
- Use ON DELETE SET NULL for foreign keys like bakeryID in the Employee table, so employees remain in the database even if their bakery is removed.

**Proposed Code with Improvements**

[Here](scripts/create_gptversion.sql) is the revised SQL code with these suggestions integrated.

**Key Changes in the Revised Code**
1. **Default Values:** Added default value for isManager and deliveryStatus.

2. **Enhanced Constraints:** Added range validation for discountPercentage in the Sale table.

3. **Junction Table for Employee <=> Shift:** Introduced EmployeeShift to handle the many-to-many relationship between employees and shifts.

**Summary**

These improvements ensure better alignment with the relational schema and database best practices, enhancing data integrity and flexibility. By introducing defaults and a junction table for many-to-many relationships, the schema becomes easier to use and maintain.

### Final SQLite "create" Script
We analyzed our previous SQLite database creation script and incorporated some improvements based on feedback while deciding to keep the design as simple as possible. Below, we explain the decisions made, the changes implemented, and why certain suggestions were not adopted.

**Decisions Made:**
1. **Avoiding a Junction Table for Employee <=> Shift**

After careful consideration, we decided not to implement a junction table for managing the many-to-many relationship between employees and shifts. Instead, we kept the employeeID attribute in the Shift table, which allows a one-to-one or many-to-one relationship.

**Reason:** Adding a junction table would increase complexity and make queries more cumbersome. For scenarios where multiple employees are assigned to a shift, we decided that this can be managed through application logic. This approach keeps the schema simpler and better aligned with our immediate project needs.

2. **Adding Default Values**

We added default values for attributes like isManager (DEFAULT 0) in the Employee table and deliveryStatus (DEFAULT 'Pending') in the Delivery table.

**Reason:** These defaults ensure consistent data entry and reduce potential errors during data insertion. For example, the default value of 0 for isManager simplifies the distinction between regular employees and managers.

3. **Enhanced Constraints for Data Integrity**

We implemented a constraint on discountPercentage in the Sale table to ensure values fall between 0 and 100.

**Reason:** This enforces business logic directly in the database and prevents invalid data from being entered.

4. **Simplified Relationships**

All other relationships were left as they were in the initial schema. This ensured we maintained the structure as outlined in the UML model while avoiding unnecessary changes that could complicate the schema.

**Final Adjustments to the Schema:**

1. **Employee <=> Shift Relationship**

By keeping employeeID in the Shift table, we allowed each shift to have one assigned employee. While this approach limits direct many-to-many representation, it is suitable for our current needs and can be extended via application logic.

2. **Default Values for attributes**

*isManager*: Ensures a clear distinction between managers and non-managers without needing additional input during data insertion.

*deliveryStatus*: Simplifies tracking delivery progress by starting with a default value of 'Pending'.


3. **Constraints for Business Logic**

Added validation for discountPercentage to ensure it falls within a reasonable range.

**Summary**

Our final database creation script reflects a balance between simplicity and functionality. We consciously avoided unnecessary complexity, like adding a junction table for the Employee ↔ Shift relationship, and focused on practical solutions to ensure the schema is efficient and easy to work with. Default values and enhanced constraints improve data integrity without overcomplicating the schema.

[This final script](scripts/create2.sql) aligns with the project’s requirements, supports all necessary operations, and remains flexible for future development or modifications.

## Data Loading
### Initial SQLite "populate" Script
The [populate1.sql](scripts/populate1.sql) script is designed to load data into the Bakery database while ensuring referential integrity using PRAGMA foreign_keys = ON; at the start. It introduces data for all tables in a clear and logical order, starting with entities like Person, Client, and Employee, followed by other tables like Shift, Product, Order, and Payment.

The script includes realistic entries, such as employees with different roles and salaries, varied product prices, and customer fidelity points. It also ensures that relationships between tables, like employees assigned to shifts or orders linked to deliveries, are accurately reflected. Overall, the script provides a solid base for running and testing the database effectively.

### AI Support
After completing the initial version of the populate1.sql script, we used ChatGPT, a generative AI tool, to review and provide feedback on our model and data. The AI offered insights on areas that could be improved to make the script more realistic and functional while maintaining simplicity.

**Feedback on Your Current Model and Data:**

**Strengths:**
1. **Clear Referential Integrity:**

The use of PRAGMA foreign_keys = ON; ensures consistent enforcement of foreign key relationships.

2. **Well-Defined Relationships:**

The connections between Person, Client, and Employee are logical and intuitive.

Cascading updates and deletions promote data consistency and reduce potential orphan records.

3. **Diverse and Realistic Sample Data:**

Varied attributes in Person, Client, and Employee tables simulate real-world scenarios effectively.

4. **Detailed Product and Ingredient Data:**

Linking Product to Ingredient (via productType) demonstrates thoughtful product composition handling.

Including expiration dates and stock quantities addresses practical inventory management concerns.

5. **Shift and Employee Connection:**

Assigning employees to specific shifts in the Shift table clarifies work scheduling.

**Weaknesses:**
1. **Shift Data Duplication:**

The Shift table duplicates data for each employee working the same shift, leading to redundancy and maintenance challenges.

**Suggestion:** Create a many-to-many relationship using an intermediary EmployeeShift table:
```sql
CREATE TABLE EmployeeShift (  
    employeeID INTEGER NOT NULL,  
    shiftID INTEGER NOT NULL,  
    PRIMARY KEY (employeeID, shiftID),  
    FOREIGN KEY (employeeID) REFERENCES Employee(personID),  
    FOREIGN KEY (shiftID) REFERENCES Shift(shiftID)  
);
```

2. **Uniform Data in *Fidelity*:**

All pointsBalance values are set to 0, which does not reflect the dynamic nature of a loyalty program.

**Suggestion:** Introduce varied starting points to represent different levels of customer activity.

3. **Ingredient Expiration Dates:**

All expiration dates are uniform (2023-12-31), which does not reflect realistic inventory scenarios.

**Suggestion:** Add a mix of expiration dates to better simulate inventory management.

4. **Shift Timing Logic:**

The Shift table currently does not prevent overlapping shifts.

**Suggestion:** Implement checks or validations to flag or prevent overlapping shifts for the same time period.

**Recommendations:**
1. **Enhance Data Variety:**

Introduce more diversity in tables like Fidelity, Ingredient, and Shift to make the dataset more representative of real-world applications.

2. **Introduce an Intermediary Table for Shifts:**

Use an EmployeeShift table to better handle the many-to-many relationship between employees and shifts, avoiding data duplication.

3. **Add Expiration Date Diversity:**

Adjust expiration dates for ingredients to simulate realistic inventory turnover and challenges.

4. **Prevent Overlapping Shifts:**

Ensure logical validation in the Shift table to maintain work schedule integrity.

### Final SQLite "populate" Script

Based on feedback from populate1.sql and the suggestions from generative AI, we updated the data-loading process to make it more realistic and functional while keeping the system simple and practical. Some areas were improved with changes, and for others, we decided to stick with the current approach, which fits our needs.

**Changes Made:**
1. **Fidelity Points Variety**

***Before:*** All pointsBalance values were set to 0, which wasn’t realistic for a loyalty program.

***Now:*** We added different starting points to show customer activity levels better.

***Why This Makes Sense:*** It reflects real-life scenarios where customers have different loyalty points based on their purchases.

2. **Ingredient Expiration Dates**

***Before:*** All ingredients had the same expiration date (2023-12-31), which wasn’t realistic.

***Now:*** We introduced varied expiration dates to simulate real inventory scenarios.

***Why This Makes Sense:*** It helps represent stock management more realistically, like dealing with expired inventory.

**What We Kept The Same:**
1. **Shift Timing Logic**

***Why We Didn't Change:*** Overlapping shifts could be a concern, but for now, we assume shifts are managed manually or through external tools. Adding database-level checks would complicate the system without much benefit.

2. **Shift Data Duplication**

***Why We Didn't Change:*** We decided to keep the current setup where each employee gets their own row in the Shift table (Option 1: Duplicate Shift Rows). This approach is simple and works well for the bakery’s operations.

**Conclusion:**

The updated [populate2.sql](scripts/populate2.sql) script makes the data more realistic, especially with varied fidelity points and ingredient expiration dates. These changes improve the system’s ability to handle real-world scenarios without overcomplicating the design. For areas like shifts, we kept the current setup since it’s simple and works for our needs. This approach balances practicality and functionality well. Also, we debugged the populate file, solving problems with the wrong use of the default value while inserting employees, misusing duplicated shiftID and missing one attribute while inserting sales. Nevertheless, we added more inserts to make the database bigger and a little more realistic.

## Generative AI Integration Review
Throughout the project, we utilized AI tools whenever appropriate. In our case we did not have any major issues like misinformation. We focused on using ChatGPT because it can handle almost any input type (images, code, plain text, etc) and it has a large database for giving good feedback. In our experience, the main limitation was with the maximum number of inputs a user is able to send to the tool without needing to pay for the service.

Considering our project specifically, the AI helped the most during the first steps, in the UML diagram, especially because we, as a student, were still getting used to the subject and its technicalities. On the other hand, the AI was not of much use in the functional dependencies, because our design was created in a way that there was no violation of Boyce-Codd Normal Form nor 3 Normal Form.

In conclusion, we considered the use of AI tools pretty useful if you use it as a way for getting another look into what you are working on and as using it almost like a second brain


## Each member's contribution
Casemiro formatted the report and merged different versions of the report. Created the initial versions of create1.sql and populate1.sql files. Actively participated in the final versions of those files. Also, he was responsible for rearranging table creation on create2.sql to avoid issues and to the final revision of the populate2.sql.

Daria created the first version of the initial functional dependencies analysis and did the AI integration/changes. She also put the create1.sql in the AI tool and she wrote the IA output/analysis. She created the first version of create2.sql. Lastly, she passed the populate1.sql through AI and she did the analysis. Because of that, she created the first version of the populate2.sql file.

Heitor helped in managing the different versions of the final report. He created the first version of our initial relational schema. He changed the Uml model according to the feedback given to us. Also, he added more inserts on the populate file to be more realistic and made some changes based on our decisions across the project.  

Lastly, everyone participated in the process of validating the relational schema, first and final version, process of validating the functional dependencies, first and final version.
