<?php
	require_once 'dbfunction.php';
	$db = new DbFunction();
	
	$data1	= $db->TampilKelas();
	echo json_encode($data1);
?>	