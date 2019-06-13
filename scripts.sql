start cleanup.sql

set serveroutput on

spool projectoutput.txt

start tables.sql

start projecttrigger.sql

start inserts.sql

start projectfunction.sql

start projectqueries.sql

execute orderDetails (0,date '2017-10-01');

execute orderDetails (0,date '2017-10-08');

update ComicCustomer set custtype = 'gold', dateJoined = date '2019-06-07' where custid = 0;

execute orderDetails (0,date '2017-10-01');

execute setShipDate (10, date '2019-06-07');

execute orderDetails (0,date '2017-10-01');

select computetotal(10) from dual; 

Select noCopies from StoreItem;

execute additemorder(26,3,5, date '2017-10-28', 20, NULL)

Select * from ItemOrders;

Select noCopies from StoreItem;

execute additemorder(26,3,5, date '2017-10-28', 2, NULL)

Select * from ItemOrders;

Select noCopies from StoreItem;

start orderReport.sql


spool off