<?php

namespace app\modely;

class Pacienti {

    private $db;

    function __construct($db) {
        $this->db = $db;
    }

    /**
     * @return array s indexy:  {rc, pacient, adresa, telefon, email, lekar, pojistovna, superpojistenec}
     */
    public function selectTablePacient() {
        $sql = "SELECT p.pacient_rc as rc, CONCAT(p.jmeno, ' ', p.prijmeni) as pacient,
  p.adresa as adresa, p.telefon as telefon, p.email as email,
  CONCAT(lekar.jmeno, ' ',  lekar.prijmeni) as lekar, pojistovna.nazev as pojistovna,
  CONCAT(s.jmeno, ' ', s.prijmeni) as superpojistenec
FROM pacient p join pojistovna on p.kod_pojistovny=pojistovna.kod_pojistovny
  left join pacient s on p.superpojistenec_rc=s.pacient_rc
  join lekar on p.lekar_id=lekar.lekar_id;";
        $result = $this->db->query($sql);
        return $result->fetchAll();
    }
    public function getAll() {
        $sql = "SELECT * FROM pacient";
        $result = $this->db->query($sql);
        return $result->fetchAll();
    }
	public function getAllById($id) {
		$params = array(':Lekar_id' => $id);
		$sql = "SELECT pacient_rc as pacient_rc, jmeno as pacient_jm, prijmeni as pacient_pr, adresa as pacient_adr, telefon as pacient_tel, email as pacient_email
FROM pacient WHERE pacient_rc in(select distinct pacient_rc from zaznam WHERE :Lekar_id = lekar_id);";
		$query = $this->db->prepare($sql);
		$query->execute($params);
		return $query->fetchAll();
	}
	public function getDetailOfPacient($id) {
		$params = array(':pacient_rc' => $id);
		$sql = "select diagnoza, p.jmeno as pacient_jm, p.prijmeni as pacient_pr, p.pacient_rc as pacient_rc
FROM zaznam z
JOIN pacient p ON z.pacient_rc=p.pacient_rc
WHERE z.pacient_rc=:pacient_rc;";
		$query = $this->db->prepare($sql);
		$query->execute($params);
		return $query->fetchAll();
	}
	public function getLeky(){
		$sql = "SELECT * FROM leky";
		$query = $this->db->query($sql);
		return $query->fetchAll();
	}		
	public function getIdLekuByName($name){
		$params = array(':jmeno' => $name);
		$sql = "SELECT lek_id FROM leky WHERE jmeno = :jmeno";
		$query = $this->db->prepare($sql);
		$query->execute($params);
		return $query->fetch();
	}
	public function insertDiagnoza($pacient_rc, $lekar_id, $diagnoza, $date) {
        $params = array(':pacient_rc' => $pacient_rc, ':lekar_id' => $lekar_id, ':diagnoza' => $diagnoza, ':datum' => $date);
        $sql = "INSERT INTO zaznam (pacient_rc, lekar_id, recept_id, diagnoza, datum)"
                . "VALUES (:pacient_rc, :lekar_id, NULL, :diagnoza, :datum)";
        $query = $this->db->prepare($sql);
        $query->execute($params);
    }
	public function insertDiagnozaa($pacient_rc, $lekar_id, $recept_id, $diagnoza, $date) {
        $params = array(':pacient_rc' => $pacient_rc, ':lekar_id' => $lekar_id, ':diagnoza' => $diagnoza, ':datum' => $date, ':recept_id' => $recept_id);
        $sql = "INSERT INTO zaznam (pacient_rc, lekar_id, recept_id, diagnoza, datum)"
                . "VALUES (:pacient_rc, :lekar_id, :recept_id, :diagnoza, :datum)";
        $query = $this->db->prepare($sql);
        $query->execute($params);
    }
	public function getMaxId() {
		$sql = "SELECT MAX(recept_id) as recept_id FROM recept";
		$query = $this->db->query($sql);
		return $query->fetch();
	}
	public function insertRecept($recept_id, $lek_id, $lekar_id, $pacient_rc, $davkovani){
		$params = array(':recept_id' => $recept_id, ':lek_id' => $lek_id, ':lekar_id' => $lekar_id, ':pacient_rc' => $pacient_rc, ':davkovani' => $davkovani);
        $sql = "INSERT INTO recept (recept_id, lek_id, lekar_id, pacient_rc, davkovani)"
                . "VALUES (:recept_id, :lek_id, :lekar_id, :pacient_rc, :davkovani)";
        $query = $this->db->prepare($sql);
        $query->execute($params);
	}
}
