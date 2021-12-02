<?php
	$db_name="warungsa_warung";
	$username="warungsa";
	$password="2Tim316#~";
	$server="localhost";

	$con = mysqli_connect($server, $username, $password, $db_name);
	if (!$con){
		// echo "Connection error".mysqli_connect_error();
	}
	else {
		// echo "Database connection success";
	}
?>