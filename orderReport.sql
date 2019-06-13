
-- the size of one page
SET PAGESIZE 20

SET LINESIZE 200

BREAK ON TODAY


COLUMN TODAY NEW_VALUE report_date
SELECT TO_CHAR(SYSDATE, 'fmMonth DD, YYYY') TODAY
FROM DUAL;


set termout off

ttitle center "MasterOwl Orders: Accessed " report_date skip 2


btitle center "MasterOwl Comics Inc." 


spool orderReport.txt


column ComicCustomer.custid format a10 heading "Customer Id"

column name format a20 heading "Customer Name"

column phone_email format a20 heading "Phone/Email"

column address format a20 heading "Address"

column orderId heading "Order Id"

column title format a10 heading "Title"

column price format $9,999.99 heading "Item Price"

column orderDate format a20 heading "Date Ordered"

column shippedDate format a20 heading "Date Shipped"

column computesubTotal(orderId) format $9,999.99 heading "Subtotal"

column 0.05*computesubTotal(orderId) format $9,999.99 heading "Tax"

column shippingFee format $9,999.99 heading "Shipping Fee"

column computediscount(orderId) format $9,999.99 heading "Discount"

column computeTotal(orderId) format $9,999.99 heading "Grand Total"

--used functions to compute the nonattribute columns

BREAK ON orderId ON ROW SKIP 1


	Select ComicCustomer.custid, name, phone_email, address, orderId, title, price,orderDate,shippedDate, computesubTotal(orderId), 0.05*computesubTotal(orderId), shippingFee, computediscount(orderId),computeTotal(orderId) from 
	ComicCustomer full outer join (ItemOrders full outer join StoreItem on ItemOrders.itemId = StoreItem.itemid) on ComicCustomer.custId = ItemOrders.custid where ComicCustomer.custid = &custid and ItemOrders.orderDate > &orderDate order by ItemOrders.orderId; 
	
	--gets the info based on the inputted custid and specified date, from &custid and &orderDate--
	--joined all tables for simplicity--

spool off;

--clear all formatting commands ...
/*
CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF 
BTITLE OFF
SET VERIFY OFF 
SET FEEDBACK OFF
SET RECSEP OFF
SET ECHO OFF
*/

