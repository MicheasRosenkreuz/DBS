<?php

namespace app\modely;

class Recepty {

    private $db;

    function __construct($db) {
        $this->db = $db;
    }

    public function getAll() {
        $sql = "SELECT r.recept_id, le.lek_id, le.jmeno as lek_jmeno, l.jmeno as lekar_jm, l.prijmeni as lekar_pr, p.jmeno as pacient_jmeno
FROM recept_leky rl
JOIN recept r ON rl.recept_id=r.recept_id
JOIN leky le ON rl.lek_id=le.lek_id
LEFT JOIN pacient p ON p.pacient_rc=r.pacient_rc
LEFT JOIN lekar l ON l.lekar_id=r.lekar_id;";
        $result = $this->db->query($sql);
        return $result->fetchAll();
    }
	public function getAllById($id) {
		$params = array(':Lekar_id' => $id);
		$sql = "select r.recept_id, le.lek_id, le.jmeno as lek_jmeno, l.jmeno as lekar_jm, l.prijmeni as lekar_pr, p.jmeno as pacient_jmeno
FROM recept_leky rl
JOIN leky le ON rl.lek_id=le.lek_id
JOIN recept r ON rl.recept_id=r.recept_id
LEFT JOIN lekar l ON l.lekar_id=r.lekar_id
LEFT JOIN pacient p ON p.pacient_rc=r.pacient_rc
WHERE l.lekar_id = :Lekar_id;";
		$query = $this->db->prepare($sql);
		$query->execute($params);
		return $query->fetchAll();
	}
	public function getDetailOfRecepis($id, $id_l) {
		$params = array(':recept_id' => $id,':lek_id' => $id_l);
		$sql = "SELECT r.recept_id as recept_id, rl.davkovani as davkovani, le.jmeno as lek_jmeno, l.jmeno as lekar_jm,
       l.prijmeni as lekar_pr, p.jmeno as pacient_jmeno, p.prijmeni as pacient_prijmeni,
       le.ucel as ucel, le.vedlejsi_ucinky as vedlejsi
FROM recept_leky rl
JOIN leky le ON rl.lek_id=le.lek_id
JOIN recept r ON rl.recept_id=r.recept_id
LEFT JOIN lekar l ON l.lekar_id=r.lekar_id
LEFT JOIN pacient p ON p.pacient_rc=r.pacient_rc
WHERE :recept_id=r.recept_id AND :lek_id=le.lek_id;";
		$query = $this->db->prepare($sql);
		$query->execute($params);
		return $query->fetchAll();
	}	
}
