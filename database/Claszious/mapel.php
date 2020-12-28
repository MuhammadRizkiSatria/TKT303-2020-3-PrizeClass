<?php
require_once 'dbfunction.php';
$db = new DbFunction();

$data1    = $db->getMapel();
echo json_encode($data1);
