<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // collect input data from the form

	// Get the orderid
     $customerid = $_POST['customerid'];

	/// Need to enter in form: 02-OCT-18
    $somedate = date('d-M-y', strtotime($_POST['somedate']));

     if (!empty($customerid)){
		$customerid = prepareInput($customerid);
     }

	// Call the function with customerid and starting date for viewing orders


	ViewOrderDB($customerid,$somedate);
	
}


function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}

function ViewOrderDB($customerid,$somedate){
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
	// Calling the PLSQL procedure, orderDetails
	$sql = "CALL orderDetails(:customerid,:somedate)";	

	$foo = oci_parse($conn,$sql);


	oci_bind_by_name($foo, ':customerid', $customerid);
	oci_bind_by_name($foo, ':somedate', $somedate);


	// Execute the query
	$res = oci_execute($foo);
	
	echo "$res";


	
	oci_free_statement($foo);

	OCILogoff($conn);
}
?>

