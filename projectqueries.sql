Create or Replace Procedure addItemOrder (oid int, iid int, cid int, orddate DATE, noordered int, shipdate DATE)

AS 
	quant int;
	memstatus varchar(255);
	no_more_books EXCEPTION; --One of the constraints against adding too many books to an order--

BEGIN 

	Select noCopies into quant 
	from StoreItem
	where StoreItem.itemid = iid;

	Select custtype into memstatus
	from ComicCustomer
	where ComicCustomer.custId = cid;

	IF quant is not NULL THEN
		IF noordered > quant THEN
			RAISE no_more_books;
		ELSE
			update StoreItem
			set noCopies = (quant - noordered)
			where StoreItem.itemId = iid;
		END IF;
	END IF;	

	IF memstatus = 'regular' THEN
		INSERT INTO ItemOrders
		(orderId, itemId, custId, orderDate, noItems, shippedDate, shippingFee)
		VALUES
		(oid,iid,cid,orddate,noordered,NULL,10.00);

	ELSE
		INSERT INTO ItemOrders
		(orderId, itemId, custId, orderDate, noItems, shippedDate, shippingFee)
		VALUES
		(oid,iid,cid,orddate,noordered,NULL,0.00);

	END IF;

EXCEPTION
	WHEN no_more_books THEN
		dbms_output.put_line('Insufficient stock for this order');

commit; 
END; 
/ 
Show errors; 




Create or Replace Procedure setShipDate (oid int, shippingDate DATE)
IS 
BEGIN 
	update ItemOrders
		set shippedDate = shippingDate
		where orderId = oid;

	COMMIT; 
END; 
/ 
Show errors; 


Create or Replace Procedure orderDetails (cid int, adate DATE)
As 
	selectedcust int;
	thedate date;
	
	o_cid ComicCustomer.custId%type;
	o_name ComicCustomer.name%type;
	o_phone_email ComicCustomer.phone_email%type;
	o_address ComicCustomer.address%type;
	o_iid StoreItem.itemId%type;
	o_price StoreItem.price%type;
	o_orderDate ItemOrders.orderDate%type;
	o_shippedDate ItemOrders.shippedDate%type;
	o_shipFee ItemOrders.shippingFee%type;
	o_custtype ComicCustomer.custtype%type;
	o_oid ItemOrders.orderId%type;
	o_title StoreItem.title%type;

Cursor Cust IS 
	Select ComicCustomer.custid, name, phone_email, address, StoreItem.itemId, price,orderDate,shippedDate, shippingFee, custtype, orderId, title from ComicCustomer full outer join (ItemOrders full outer join StoreItem on ItemOrders.itemId = StoreItem.itemid) on ComicCustomer.custId = ItemOrders.custid where ComicCustomer.custid = cid AND ItemOrders.orderDate > adate order by ComicCustomer.custId; 

--joins all the tables by itemid, then by custid so as to easily get all the relevant information to print--

BEGIN

open Cust;
Fetch Cust into o_cid, o_name, o_phone_email, o_address, o_iid, o_price, o_orderDate, o_shippedDate, o_shipFee, o_custtype, o_oid, o_title;
DBMS_OUTPUT.put_line('Customer Details: '||o_cid||', '||o_name||', '||o_phone_email||', '||o_address);
--Only need customer's details once, versus each of their orders, which necessitates the loop--
LOOP
	IF o_title is not NULL THEN
		DBMS_OUTPUT.put_line('Item Details: Order ID: '||o_oid||', Item ID: '||o_iid||', Title: ' ||o_title||', Price: '||o_price||', Date Ordered '||o_orderDate||', Date Shipped: '||o_shippedDate);
	ELSE
		DBMS_OUTPUT.put_line('Item Details: Order ID: '||o_oid||',Item ID: '||o_iid||', Price: $'||o_price||', Date Ordered '||o_orderDate||', Date Shipped: '||o_shippedDate);

	END IF;
	DBMS_OUTPUT.put_line('Subtotal: $'||computesubTotal(o_oid)||', Tax: $'||0.05*computesubTotal(o_oid)||', Shipping Fee: $'||o_shipFee||', Discount: $'||computediscount(o_oid)||', Total: $'||computeTotal(o_oid));
	Fetch Cust into o_cid, o_name, o_phone_email, o_address, o_iid, o_price, o_orderDate, o_shippedDate, o_shipFee, o_custtype, o_oid, o_title;
--used the added functions to compute the nonattribute details--
	EXIT WHEN CUST%notfound;

	END LOOP;

close Cust;

END; 
/ 
Show errors; 

