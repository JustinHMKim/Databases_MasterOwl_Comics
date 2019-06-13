CREATE TABLE ComicCustomer (
	custId int PRIMARY KEY, 
	name varchar(255) NOT NULL,  
	phone_email varchar(255) NOT NULL UNIQUE, 
	address varchar(255),
	dateJoined DATE,
	custtype varchar(255),
	CONSTRAINT customer_type CHECK (custtype = 'gold' OR custtype = 'regular')
);--Applied Null table approach for gold vs regular customers

CREATE TABLE StoreItem (
	itemId int PRIMARY KEY, 
	price DECIMAL(19, 4),
	ISBN int,
	noCopies int CHECK (noCopies >= 0),
	title varchar(255),
	pubDate DATE,
	shirtsize varchar(3),
	CONSTRAINT ISBN_uni UNIQUE(ISBN),
	CONSTRAINT item_type CHECK (ISBN is NULL OR shirtsize is NULL)
);/*Applied Null table approach for shirts vs comic books. ISBN and shirtsize indicate which type the item is; Constraint for one to 
be NULL so no item can be both a shirt and a comicbook. */

CREATE TABLE ItemOrders (
	orderId int NOT NULL,
	itemId int NOT NULL, 
	custId int NOT NULL, 
	orderDate DATE,
	noItems int,
	shippedDate DATE,
	CONSTRAINT chk_date CHECK (shippedDate > orderDate),
	shippingFee DECIMAL(19, 4),
	FOREIGN KEY (itemId) REFERENCES StoreItem(itemId),
	FOREIGN KEY (custId) REFERENCES ComicCustomer(custId),
	CONSTRAINT PK_ItemOrders PRIMARY KEY (orderId)
);


