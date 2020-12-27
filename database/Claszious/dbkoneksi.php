<?php
	class Dbkoneksi{
		private $koneksi;
		
		// Koneksi ke database
		public function BuatKoneksi(){
			require_once 'config.php';
			$this->koneksi = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_DATABASE);
			return $this->koneksi;
		}
	}
?>