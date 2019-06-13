<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // collect input data from the form

	// Get the orderid
     $orderid = $_POST['orderid'];

	/// Need to enter in form: 02-OCT-18
    $shippeddate = date('d-M-y', strtotime($_POST['shippeddate']));

     if (!empty($orderid)){
		$orderid = prepareInput($orderid);
     }

	// Call the function to insert orderid and shippeddate
	// into ItemOrders table

	insertShipDateIntoDB($orderid,$shippeddate);
	
}


function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}

function insertShipDateIntoDB($orderid,$shippeddate){
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
	// Calling the PLSQL procedure, setShipDate
	$sql = oci_parse($conn, 'begin setShipDate(:orderid,:shippeddate); end;');	


	oci_bind_by_name($sql, ':orderid', $orderid);
	oci_bind_by_name($sql, ':shippeddate', $shippeddate);


	// Execute the query
	$res = oci_execute($sql);
	

	if ($res){
		echo '<br><br> <p style="color:green;font-size:20px">';
		echo "Date Updated </p>";
	}
	else{
		$e = oci_error();
        	echo $e['message'];
	}
	oci_free_statement($sql);
	OCILogoff($conn);
}
?>

