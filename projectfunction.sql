Create Or Replace Function computeTotal(oid int) 			--function computes total for a particular item order--
Return Number IS 
	totalSum DECIMAL(19, 4);
	quantity int;
	membership varchar(255); 
	sfee DECIMAL(19, 4);

BEGIN
	Select price
		into totalSum
		from StoreItem
		where StoreItem.itemId = 
			(Select itemId 
			from ItemOrders
			where orderId = oid);
	Select custtype
		into  membership
		from ComicCustomer
		where ComicCustomer.custid = (Select custid 
			from ItemOrders
			where orderId = oid);

	Select shippingFee, noItems
		into  sfee, quantity
		from ItemOrders
		where orderId = oid;

	
		IF membership = 'gold' AND totalSum >= 100.00 THEN		--applies 10% discount if purchase is at least $100 for gold members--
			totalSum := 1.05 *((totalSum * quantity) * 0.9);
			
		ELSIF membership = 'gold' AND totalSum < 100.00 THEN	--otherwise just removes the shipping fee--
			totalSum := 1.05 *(totalSum*quantity);
		ELSE
			totalSum := 1.05 *(totalSum*quantity) + sfee;
		END IF;
	
	
	
	RETURN totalSum;
END;
/
show errors;


Create Or Replace Function computesubTotal(oid int)				--computes subtotal for use in report--
Return Number IS 
	subtotalSum DECIMAL(19, 4);
	quantity int;

BEGIN
	Select price
		into subtotalSum
		from StoreItem
		where StoreItem.itemId = 
			(Select itemId 
			from ItemOrders
			where orderId = oid);
	Select noItems
		into quantity
		from ItemOrders
		where orderId = oid;


	IF quantity is not NULL THEN								
		subtotalSum := subtotalSum*quantity;
	END IF;
	
	RETURN subtotalSum;
END;
/
show errors;

Create Or Replace Function computediscount(oid int)				--computes gold member discount for use in report--
Return Number IS 
	discount DECIMAL(19, 4);
	totalSum DECIMAL(19, 4);
	quantity int;
	membership varchar(255); 

BEGIN
	Select price
		into totalSum
		from StoreItem
		where StoreItem.itemId = 
			(Select itemId 
			from ItemOrders
			where orderId = oid);
	Select noItems
		into quantity
		from ItemOrders
		where orderId = oid;
	Select custtype
		into  membership
		from ComicCustomer
		where ComicCustomer.custid = (Select custid 
			from ItemOrders
			where orderId = oid);

	
		IF membership = 'gold' AND totalSum >= 100.00 THEN
			discount := 0.1 *(totalSum * quantity) ;
		ELSE
			discount := 0;
		END IF;
	
	

	
	RETURN discount;
END;
/
show errors;