
--status
CREATE TABLE Status (
    Id INT PRIMARY KEY,
    Status VARCHAR(50) NOT NULL
);
-- Territory
CREATE TABLE Territory (
    TerritoryID INT PRIMARY KEY,
    Name VARCHAR(100),
    CountryRegionCode VARCHAR(10),
    TerritoryGroup VARCHAR(100),
    SalesLastYear DECIMAL(18,2),
    SalesYTD DECIMAL(18,2),
    CostLastYear DECIMAL(18,2),
    CostYTD DECIMAL(18,2),
    ModifiedDate DATETIME
);
--Category
CREATE TABLE Category (
    ProductCategoryID INT PRIMARY KEY,
    Name VARCHAR(100),
    ModifiedDate DATETIME
);
-- Subcategory
CREATE TABLE Subcategory (
    ProductSubcategoryID INT PRIMARY KEY,
    ProductCategoryID INT NOT NULL,
    Name VARCHAR(100),
    ModifiedDate DATETIME,
    CONSTRAINT FK_Subcategory_Category
        FOREIGN KEY (ProductCategoryID)
        REFERENCES Category(ProductCategoryID)
);
-- Product
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(150),
    ProductNumber VARCHAR(50),
    ProductModelID INT,
    ProductSubcategoryID INT,
    ListPrice DECIMAL(18,2),
    StandardCost DECIMAL(18,2),
    FinishedGoodsFlag BIT,
    MakeFlag BIT,
    ModifiedDate DATETIME,
    CONSTRAINT FK_Product_Subcategory
        FOREIGN KEY (ProductSubcategoryID)
        REFERENCES Subcategory(ProductSubcategoryID)
);
-- P-C-S -
CREATE TABLE Product_Category_Subcategory (
    ProductID INT,
    ProductCategoryID INT,
    ProductSubcategoryID INT,
    Name VARCHAR(150),
    CategoryName VARCHAR(100),
    PRIMARY KEY (ProductID, ProductCategoryID, ProductSubcategoryID),
    CONSTRAINT FK_PCS_Product
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FK_PCS_Category
        FOREIGN KEY (ProductCategoryID) REFERENCES Category(ProductCategoryID),
    CONSTRAINT FK_PCS_Subcategory
        FOREIGN KEY (ProductSubcategoryID) REFERENCES Subcategory(ProductSubcategoryID)
);
-- SalesPerson
CREATE TABLE SalesPerson (
    BusinessEntityID INT PRIMARY KEY,
    FullName VARCHAR(150),
    JobTitle VARCHAR(100),
    City VARCHAR(100),
    StateProvinceName VARCHAR(100),
    CountryRegionName VARCHAR(100),
    PostalCode VARCHAR(20),
    PhoneNumber VARCHAR(30),
    PhoneNumberType VARCHAR(30),
    SalesQuota DECIMAL(18,2),
    SalesLastYear DECIMAL(18,2),
    SalesYTD DECIMAL(18,2),
    TerritoryID INT,
    CONSTRAINT FK_SalesPerson_Territory
        FOREIGN KEY (TerritoryID)
        REFERENCES Territory(TerritoryID)
);
-- ShipMethod
CREATE TABLE ShipMethod (
    ShipMethodID INT PRIMARY KEY,
    Name VARCHAR(100),
    ShipBase DECIMAL(18,2),
    ShipRate DECIMAL(18,2),
    ModifiedDate DATETIME
);
--Order
CREATE TABLE [Order] (
    SalesOrderID INT PRIMARY KEY,
    CustomerID INT,
    AccountNumber VARCHAR(50),
    OrderDate DATE,
    DueDate DATE,
    ShipDate DATE,
    Status INT,
    OnlineOrderFlag BIT,
    OrderFlag BIT,
    SubTotal DECIMAL(18,2),
    TaxAmt DECIMAL(18,2),
    Freight DECIMAL(18,2),
    TotalDue DECIMAL(18,2),
    TerritoryID INT,
    ShipMethodID INT,
    SalesPersonID INT,
    CONSTRAINT FK_Order_Status
        FOREIGN KEY (Status) REFERENCES Status(Id),
    CONSTRAINT FK_Order_Territory
        FOREIGN KEY (TerritoryID) REFERENCES Territory(TerritoryID),
    CONSTRAINT FK_Order_ShipMethod
        FOREIGN KEY (ShipMethodID) REFERENCES ShipMethod(ShipMethodID),
    CONSTRAINT FK_Order_SalesPerson
        FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(BusinessEntityID)
);
--OrderDetail
CREATE TABLE OrderDetail (
    SalesOrderDetailID INT PRIMARY KEY,
    SalesOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    OrderQty INT,
    UnitPrice DECIMAL(18,2),
    UnitPriceDiscount DECIMAL(18,2),
    LineTotal DECIMAL(18,2),
    ModifiedDate DATETIME,
    CONSTRAINT FK_OrderDetail_Order
        FOREIGN KEY (SalesOrderID)
        REFERENCES [Order](SalesOrderID),
    CONSTRAINT FK_OrderDetail_Product
        FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID)
);