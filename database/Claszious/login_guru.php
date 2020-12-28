<?php
require_once 'dbfunction.php';
$db = new DbFunction();

//Json Respon
$respon = array("error" => FALSE);

//Cek Login
if (isset($_POST['email']) && isset($_POST['pass'])) {
    //Receiving POST
    $email      = $_POST['email'];
    $pass       = $_POST['pass'];


    //Cek Login Untuk Student
    $user = $db->cekLoginGuru($email, $pass);


    if ($user != false) {
        $respon["error"] = FALSE;
        $respon["message"] = "Login Guru Berhasil";
        $respon["page"] = "guru";
        $respon["id"] = $user["id"];
        $respon["username"] = $user["username"];
        $respon["email"] = $user["email"];
        $respon["pass"] = $user["pass"];


        echo json_encode($respon);
    } else {
        $respon["error"] = TRUE;
        $respon["message"] = " Email atau Password salah!";
        echo json_encode($respon);
    }
} else {
    $respon["error"] = TRUE;
    $respon["message"] = "Kehilangan Parameter";
    echo json_encode($respon);
}
