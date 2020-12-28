<?php
	require_once 'dbfunction.php';
	$db = new DbFunction();
	
	$data1	= $db->TampilPesan($_POST['id_kelas']);
	echo json_encode($data1);
?>	