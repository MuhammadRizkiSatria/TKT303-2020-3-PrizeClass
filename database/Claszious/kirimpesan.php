<?php
require_once 'dbfunction.php';
$db = new DbFunction();

//Json Respon
$respon = array("error"=>FALSE);

if (isset($_POST['id_kelas']) && isset($_POST['id_user']) && isset($_POST['pesan']) ){
	
	//Receiving POST
	$idkelas       = $_POST['id_kelas'];
	$iduser        = $_POST['id_user'];
	$namauser      = $_POST['nama_user'];
	$pesan         = $_POST['pesan'];
	
	
	
		$kirimpesan = $db->KirimPesan($idkelas,$iduser,$namauser,$pesan);

		if($kirimpesan == 1){
			$respon["error"] = FALSE;
			$respon["message"] = "Pesan anda terkrim";
		    echo json_encode($respon);    
		}else{
			$respon["error"] = TRUE;
		    $respon["message"] = "Pesan anda gagal terkirim";
		    echo json_encode($respon);
		}
}else{ 
	$respon["error"] = TRUE;
	$respon["message"] = "Kehilangan nilai parameter";
	echo json_encode($respon);
}
?>