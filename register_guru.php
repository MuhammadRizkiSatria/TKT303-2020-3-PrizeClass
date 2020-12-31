<?php
require_once 'dbfunction.php';
$db = new DbFunction();

//Json Respon
$respon = array("error" => FALSE);

if (isset($_POST['username']) && isset($_POST['email'])) {
    //Receiving POST
    $username            = $_POST['username'];
    $email          = $_POST['email'];
    $pass             = $_POST['pass'];


    $cek_register = $db->CekRegisterGuru($email);
    if ($cek_register == null) {
        $add_register = $db->RegisterGuru($username, $pass, $email);
        if ($add_register == 1) {
            $respon["error"] = FALSE;
            $respon["message"] = "Data Anda telah berhasil di tambah";
            echo json_encode($respon);
        } else {
            $respon["error"] = TRUE;
            $respon["message"] = "Pendaftaran anda gagal, silahkan coba kembali";
            echo json_encode($respon);
        }
    } else {
        $respon["error"] = TRUE;
        $respon["message"] = "Email yang anda gunakan, sudah ada dalam database kami..";
        $respon["data"] = $cek_register;
        echo json_encode($respon);
    }
} else {
    $respon["error"] = TRUE;
    $respon["message"] = "Kehilangan nilai Parameter!";
    echo json_encode($respon);
}
