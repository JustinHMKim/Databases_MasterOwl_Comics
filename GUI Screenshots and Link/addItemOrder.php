
<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // collect input data from the form

	// Get the orderid
     $orderid = $_POST['orderid'];

	// Get the itemid
     $itemid = $_POST['itemid'];

	// Get the movie name
	$customerid = $_POST['customerid'];

	// Need to enter in form: 02-OCT-18
	$orderdate = date('d-M-y', strtotime($_POST['orderdate']));
	 
	// Get the number ordered
	$numberordered = $_POST['numberordered'];

	/// Need to enter in form: 02-OCT-18
	$shippeddate = date('d-M-y', strtotime($_POST['shippeddate']));

     if (!empty($orderid)){
		$orderid = prepareInput($orderid);
     }
     if (!empty($itemid)){
		$itemid = prepareInput($itemid);
     }
	 if (!empty($customerid)){
		$customerid = prepareInput($customerid);
	 }

	 if (!empty($numberordered)){
		$numberordered = prepareInput($numberordered);
	 }

	// Call the function to insert customer, product, order info
	// into ItemOrder table

	insertMOOrderIntoDB($orderid,$itemid,$customerid,$orderdate,$numberordered,$shippeddate);
	
}


function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}

function insertMOOrderIntoDB($orderid,$itemid,$customerid,$orderdate,$numberordered,$shippeddate){
	//connect to your database. Type in sd username, password and the DB path
	$conn = oci_connect('hkim', '000012689111', '//dbserver.engr.scu.edu/db11g');
	
	if (!$conn) {
		$e = oci_error();
		trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
	} 
	if(!$conn) {
	     print "<br> connection failed:";
        exit;
	}
	// Calling the PLSQL procedure, addItemOrder
	$sql = oci_parse($conn, 'begin addItemOrder(:orderid,:itemid,:customerid,:orderdate,:numberordered,:shippeddate); end;');	


	oci_bind_by_name($sql, ':orderid', $orderid);
	oci_bind_by_name($sql, ':itemid', $itemid);
	oci_bind_by_name($sql, ':customerid', $customerid);
	oci_bind_by_name($sql, ':orderdate', $orderdate);
	oci_bind_by_name($sql, ':numberordered', $numberordered);
	oci_bind_by_name($sql, ':shippeddate', $shippeddate);


	// Execute the query
	$res = oci_execute($sql);
	

	if ($res){
		echo '<br><br> <p style="color:green;font-size:20px">';
		echo "Order Inserted </p>";
	}
	else{
		$e = oci_error();
        	echo $e['message'];
	}
	oci_free_statement($sql);
	OCILogoff($conn);
}
?>

