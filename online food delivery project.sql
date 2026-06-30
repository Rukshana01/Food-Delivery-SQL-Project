CREATE DATABASE FoodDeliveryDB;
USE FoodDeliveryDB;
1.CREATE A TABLE
#CUSTOMERS TABLE
CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

#RESTAURANTS TABLE
CREATE TABLE Restaurants(
    RestaurantID INT PRIMARY KEY,
    RestaurantName VARCHAR(100),
    Cuisine VARCHAR(50)
);

#ORDERS TABLE
CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATETIME,
    Amount DECIMAL(10,2),

    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY(RestaurantID) REFERENCES Restaurants(RestaurantID)
);

#RATINGS TABLE
CREATE TABLE Ratings(
    RatingID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    Score INT,

    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY(RestaurantID) REFERENCES Restaurants(RestaurantID)
);

2.INSERT DATA
#CUSTOMERS
INSERT INTO Customers VALUES
(1,'Riya'),
(2,'Arjun'),
(3,'Sara'),
(4,'Rahul'),
(5,'Ananya');

#RESTAURANTS
INSERT INTO Restaurants VALUES
(101,'Pizza Hub','Italian'),
(102,'Burger Point','Fast Food'),
(103,'Biryani House','Indian'),
(104,'Sushi World','Japanese'),
(105,'Taco Fiesta','Mexican');

#ORDERS
INSERT INTO Orders VALUES
(1001,1,101,'2025-05-01 12:15:00',450),
(1002,2,102,'2025-05-01 13:30:00',300),
(1003,1,103,'2025-05-02 19:00:00',650),
(1004,3,101,'2025-05-02 18:30:00',500),
(1005,4,103,'2025-05-03 20:15:00',750),
(1006,2,101,'2025-05-04 12:00:00',400),
(1007,5,105,'2025-05-04 14:30:00',550),
(1008,1,104,'2025-05-05 21:00:00',800),
(1009,2,103,'2025-05-06 19:45:00',620),
(1010,3,102,'2025-05-06 13:10:00',350);

#RATINGS
INSERT INTO Ratings VALUES
(1,1,101,5),
(2,2,102,4),
(3,1,103,5),
(4,3,101,4),
(5,4,103,5),
(6,2,101,3),
(7,5,105,5),
(8,1,104,4),
(9,2,103,5),
(10,3,102,4);

3.DATA EXPLORATION
SELECT * FROM Customers;

SELECT * FROM Restaurants;

SELECT * FROM Orders;

SELECT * FROM Ratings;

4.CHECKING A MISSING VALUE
SELECT *FROM Customers
WHERE CustomerName IS NULL;

SELECT *FROM Restaurants
WHERE RestaurantName IS NULL;

SELECT *FROM Orders
WHERE Amount IS NULL;

SELECT *FROM Ratings
WHERE Score IS NULL;

5.RESTAURANT PERFORMANCE
Top Restaurants by Total Orders

SELECT
RestaurantID,
COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY RestaurantID
ORDER BY TotalOrders DESC;

RESTAURANT REVENUE
SELECT
RestaurantID,
SUM(Amount) AS Revenue
FROM Orders
GROUP BY RestaurantID
ORDER BY Revenue DESC;

RESTAURANT NAME WITH REVENUE
SELECT
r.RestaurantName,
SUM(o.Amount) AS Revenue
FROM Restaurants r
JOIN Orders o
ON r.RestaurantID=o.RestaurantID
GROUP BY r.RestaurantName
ORDER BY Revenue DESC;

6.AVERAGE RESTAURANT RATING
SELECT
r.RestaurantName,
AVG(rt.Score) AS AverageRating
FROM Restaurants r
JOIN Ratings rt
ON r.RestaurantID=rt.RestaurantID
GROUP BY r.RestaurantName
ORDER BY AverageRating DESC;

7.CUSTOMER LOYALITY
SELECT
CustomerID,
COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID)>1;

8.CUSTOMER RANKING
RANK()
SELECT
CustomerID,
COUNT(OrderID) AS TotalOrders,
RANK() OVER(
ORDER BY COUNT(OrderID) DESC
) AS Ranking
FROM Orders
GROUP BY CustomerID;

DENSE RANK()
SELECT
CustomerID,
COUNT(OrderID) AS TotalOrders,
DENSE_RANK() OVER(
ORDER BY COUNT(OrderID) DESC
) AS DenseRanking
FROM Orders
GROUP BY CustomerID;

9.PEAK ORDERING HOURS
SELECT
HOUR(OrderDate) AS OrderHour,
COUNT(*) AS TotalOrders
FROM Orders
GROUP BY HOUR(OrderDate)
ORDER BY TotalOrders DESC;

10.ORDER BY DATE
SELECT
DATE(OrderDate) AS OrderDay,
COUNT(*) AS TotalOrders
FROM Orders
GROUP BY DATE(OrderDate)
ORDER BY TotalOrders DESC;

11.CUISINE PERFORMANCE
SELECT
r.Cuisine,
COUNT(o.OrderID) AS OrdersCount,
SUM(o.Amount) AS Revenue
FROM Restaurants r
JOIN Orders o
ON r.RestaurantID=o.RestaurantID
GROUP BY r.Cuisine
ORDER BY Revenue DESC;

12.HIGHEST SPENDING CUSTOMER
SELECT
c.CustomerName,
SUM(o.Amount) AS TotalSpent
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;

13.HIGHEST RATED RESTAURANT
SELECT
r.RestaurantName,
AVG(rt.Score) AS AvgRating
FROM Restaurants r
JOIN Ratings rt
ON r.RestaurantID=rt.RestaurantID
GROUP BY r.RestaurantName
ORDER BY AvgRating DESC;