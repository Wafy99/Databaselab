CREATE INDEX IDX_CustomerID ON Customer(CustomerID);

CREATE INDEX IDX_CustomerFullNameDOB_ID
ON Customer(FirstName, LastName, DOB, CustomerID);

CREATE INDEX IDX_ProductNameDesc
ON Product(ProductName, Description);

CREATE INDEX IDX_OrderProduct
ON Order_Details(OrderID, ProductID);

SHOW INDEXES FROM Customer;

ALTER TABLE Customer RENAME INDEX IDX_CustomerID TO IDX_Customer_ID;

DROP INDEX IDX_Customer_ID ON Customer;

ALTER TABLE Product ALTER INDEX IDX_ProductNameDesc INVISIBLE;

ALTER TABLE Product ALTER INDEX IDX_ProductNameDesc VISIBLE;