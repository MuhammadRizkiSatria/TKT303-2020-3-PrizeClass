<?php
	class DbFunction{
		private $koneksi;
		
		//Constructor
		function __construct(){
			require_once 'dbkoneksi.php';
			$db = new Dbkoneksi();
			$this->koneksi = $db->BuatKoneksi();
		}
		
		//Destructor
		function __destruct(){
			
		}
		
		// mengirim data pesan
        public function KirimPesan($idkelas,$iduser,$namauser,$pesan){

			$tanggal = date('y-m-d');
			
            $statementIn = $this->koneksi->prepare("INSERT INTO tbl_pesan (id_kelas,id_user,nama_user,pesan,waktu,tanggal) VALUES ('".$idkelas."','".$iduser."','".$namauser."','".$pesan."',NOW(),'".$tanggal."' )");
            $result = $statementIn->execute();

            return $result;
        }

		// manmpilkan data
        public function TampilKelas(){
            $hasil	= $this->koneksi->query("SELECT * FROM tbl_kelas ORDER BY id_kelas ASC");
			$data1	= array();

			while ($item = $hasil->fetch_assoc()) {
				# code...
				$data1[]	= $item;
			}

			return $data1;
		}
		//

		// menmpilkan data berdasarkan kelas
        public function TampilPesan($idkelas){
            $hasil	= $this->koneksi->query("SELECT * FROM tbl_pesan where id_kelas = '". $idkelas ."'  ORDER BY id_pesan AND tanggal desc");
			$data1	= array();

			while ($item = $hasil->fetch_assoc()) {
				# code...
				$data1[]	= $item;
			}

			return $data1;
        }

					
		

	}
?>