--Inserts values into the 3 tables--

Insert into StoreItem values (0,20.00, NULL, NULL,NULL,NULL,'L');
Insert into ComicCustomer values (0,'Jill','jill@gmail.com','San Jose',NULL, 'regular');
Insert into ItemOrders values (0,0,0, date '2017-10-10', 1, date '2017-10-30',10);

Insert into StoreItem values (1,22.00, NULL, NULL,NULL,NULL,'XS');
Insert into ComicCustomer values (1,'Bill','bill@gmail.com','Santa Clara',NULL, 'regular');
Insert into ItemOrders values (1,1,1, date '2017-10-11', 2, date '2017-10-20',10);

Insert into StoreItem values (2,100.00,129381, 5,'M dash', date '2013-9-10', NULL);
Insert into ComicCustomer values (2,'Will','will@gmail.com','San Francisco',date '2017-10-10', 'gold');
Insert into ItemOrders values (2,2,2, date '2017-10-8', 5, date '2017-10-29',0);

Insert into StoreItem values (3,10.00,129382, 19,'N dash', date '2013-9-11', NULL);
Insert into ItemOrders values (3,3,2, date '2017-10-8', 4, date '2017-10-28',0);

Insert into ComicCustomer values (3,'Mill','Mill@gmail.com','San Jose',date '2017-11-10', 'gold');
Insert into ItemOrders values (4,3,3, date '2017-10-8', 4, NULL,0);

Insert into ComicCustomer values (4,'Nill','Nill@gmail.com','San Jose',date '2017-11-10', 'gold');
Insert into ItemOrders values (5,3,4, date '2017-10-8', 4, NULL,0);


Insert into ItemOrders values (6,3,4, date '2017-10-8', 1, NULL,0);


Insert into ItemOrders values (7,3,4, date '2017-10-8', 100, NULL,0);

Insert into StoreItem values (4,40.00, NULL, NULL,NULL,NULL,'L');
Insert into ComicCustomer values (5,'Till','till@gmail.com','Santa Monica',NULL, 'regular');
Insert into ItemOrders values (8,4,4, date '2017-10-24', 1, date '2017-10-30',0);

Insert into StoreItem values (5,32.00, NULL, NULL,NULL,NULL,'XS');
Insert into ComicCustomer values (6,'Jill','jill@gmail.com','Sahara',NULL, 'regular');
Insert into ItemOrders values (9,4,4, date '2017-10-09', 2, date '2017-11-23',0);

Insert into StoreItem values (6,40.00,129382, 5,'O dash', date '2013-11-10', NULL);

Insert into ItemOrders values (10,4,0, date '2017-10-07', 2,NULL,10);
