<?php
class DbFunction
{
	private $koneksi;

	//Constructor
	function __construct()
	{
		require_once 'dbkoneksi.php';
		$db = new Dbkoneksi();
		$this->koneksi = $db->BuatKoneksi();
	}

	//Destructor
	function __destruct()
	{
	}

	//--------------------- FUNCTION - FUNCTION LAIN -------------
	// Register USER Client
	public function RegisterSiswa($username, $pass, $email)
	{
		$statementIn = $this->koneksi->prepare("INSERT INTO tb_siswa (username,pass,email) VALUES ('" . $username . "',MD5('" . $pass . "'),'" . $email . "')");
		$result = $statementIn->execute();

		return $result;
	}
	public function RegisterGuru($username, $pass, $email)
	{
		$statementIn = $this->koneksi->prepare("INSERT INTO tb_guru (username,pass,email) VALUES ('" . $username . "',MD5('" . $pass . "'),'" . $email . "')");
		$result = $statementIn->execute();

		return $result;
	}

	//Cek Data USER
	public function CekRegisterSiswa($email)
	{
		$query_cek = $this->koneksi->query("SELECT * FROM tb_siswa WHERE email = '" . $email . "' ");
		$data = array();

		while ($item = $query_cek->fetch_assoc()) {
			$data[] = $item;
		}
		return $data;
	}
	public function CekRegisterguru($email)
	{
		$query_cek = $this->koneksi->query("SELECT * FROM tb_guru WHERE email = '" . $email . "' ");
		$data = array();

		while ($item = $query_cek->fetch_assoc()) {
			$data[] = $item;
		}
		return $data;
	}

	//Login Akun Client
	public function cekLoginSiswa($email, $pass)
	{
		$statement = $this->koneksi->prepare("SELECT * FROM tb_siswa WHERE email = ? AND pass = MD5(?) LIMIT 1");
		$statement->bind_param("ss", $email, $pass);

		if ($statement->execute()) {
			$user = $statement->get_result()->fetch_assoc();
			$statement->close();
			return $user;
		} else {
			return NULL;
		}
	}
	public function cekLoginGuru($email, $pass)
	{
		$statement = $this->koneksi->prepare("SELECT * FROM tb_guru WHERE email = ? AND pass = MD5(?) LIMIT 1");
		$statement->bind_param("ss", $email, $pass);

		if ($statement->execute()) {
			$user = $statement->get_result()->fetch_assoc();
			$statement->close();
			return $user;
		} else {
			return NULL;
		}
	}
	public function getMapel()
	{
		$hasil	= $this->koneksi->query("SELECT * FROM tb_mapel ");
		$data1	= array();

		while ($item = $hasil->fetch_assoc()) {
			# code...
			$data1[]	= $item;
		}

		return $data1;
	}
	public function TampilPesan($idkelas)
	{
		$hasil	= $this->koneksi->query("SELECT * FROM tbl_pesan where id_kelas = '" . $idkelas . "'  ORDER BY id_pesan AND tanggal desc");
		$data1	= array();

		while ($item = $hasil->fetch_assoc()) {
			# code...
			$data1[]	= $item;
		}

		return $data1;
	}

	public function KirimPesan($idkelas, $iduser, $namauser, $pesan)
	{

		$tanggal = date('y-m-d');

		$statementIn = $this->koneksi->prepare("INSERT INTO tbl_pesan (id_kelas,id_user,nama_user,pesan,waktu,tanggal) VALUES ('" . $idkelas . "','" . $iduser . "','" . $namauser . "','" . $pesan . "',NOW(),'" . $tanggal . "' )");
		$result = $statementIn->execute();

		return $result;
	}

	public function viewMapel($id)
	{
		$hasil	= $this->koneksi->query("SELECT * FROM tb_mapel WHERE id = '" . $id . "' ");
		$data1	= array();

		while ($item = $hasil->fetch_assoc()) {
			# code...
			$data1[]	= $item;
		}

		return $data1;
	}
}
