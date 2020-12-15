<?php
$dp = "";
$user = $_POST["user"];
$pass = $_POST["pass"];
$host = "localhost";

$conn = mysqli_connect($host,$user,$pass,$db);
if($conn)
{
	$q = "select '$user' and pass like '$pass'";
	$result = mysqli_querry($conn, $q);
	
if(mysqli_num_rows($result) > 0)
{
	echo "LOGIN SUCCESFULL....";
}else{
echo "LOGIN FAILED....";
}

}else
{
 "NOT CONNECTED....!"
 }
 
 
?>