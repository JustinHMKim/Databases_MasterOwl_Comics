Create Or Replace Trigger goldupdate --sets shipping fee to 0 for any outstanding orders, but not orders that have already gone through--
After UPDATE ON ComicCustomer
For each row
BEGIN
	if updating ('custtype')  then
		if :NEW.custtype = 'gold' then
			update ItemOrders
			set shippingFee = 0
			where custId = :NEW.custId and shippedDate is NULL;
		END if;
	End if;
END;
/
show errors;

Create Or Replace Trigger checkstock --Other constraint against adding too many comics to an order where there is not enough supply--
BEFORE INSERT OR UPDATE ON ItemOrders
For each row
DECLARE
	avail integer;
BEGIN
	Select noCopies into avail
		from StoreItem
		WHERE StoreItem.itemId =:NEW.itemId;
		
	if :NEW.noitems > avail THEN
		DBMS_OUTPUT.PUT_LINE ('Order too large');
		RAISE_APPLICATION_ERROR(-20010,'Not enough stock for order');
	End if;

END ;
/
show errors;

