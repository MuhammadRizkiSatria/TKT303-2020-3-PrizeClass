<?php
require_once 'dbfunction.php';
$db = new DbFunction();

$data1    = $db->viewMapel($_POST['id']);
echo json_encode($data1);
