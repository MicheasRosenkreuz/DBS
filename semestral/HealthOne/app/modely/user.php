<?php

namespace app\modely;


class User {

    private $db;

    function __construct($db) {
        $this->db = $db;
    }

    public function getAll() {
        $sql = "SELECT Lekar_id, jmeno, heslo FROM Lekar";
        $result = $this->db->query($sql);
        return $result->fetchAll();
    }

    public function getById($id) {
        $params = array(':Lekar_id' => $id);
        $sql = "SELECT Lekar_id, jmeno, heslo FROM Lekar WHERE Lekar_id = :Lekar_id";
        $query = $this->db->prepare($sql);
        $query->execute($params);
        return $query->fetch();
    }

    public function getByName($name) {
        $params = array(':jmeno' => $name);
        $sql = "SELECT * FROM Lekar WHERE jmeno = :jmeno";
        $query = $this->db->prepare($sql);
        $query->execute($params);
        return $query->fetch();
    }
	public function getAllById($id){
		$params = array(':id' => $id);
		$sql = "SELECT * FROM Lekar WHERE lekar_id = :id";
		$query = $this->db->prepare($sql);
		$query->execute($params);
		$all = $query->fetch();
		return $all;
	}

    public function getIdByName($name) {
        $params = array(':jmeno' => $name);
        $sql = "SELECT Lekar_id FROM Lekar WHERE lekar_id = :jmeno";
        $query = $this->db->prepare($sql);
        $query->execute($params);
        $id = $query->fetch();
        if (is_object($id)) {
            $id = $id->lekar_id;
        } else {
            $id = 0;
        }
        return $id;
    }
    public function getPassById($id){
        $params = array(':lekar_id' => $id);
        $sql = "SELECT heslo FROM Lekar WHERE lekar_id = :lekar_id";
        $query = $this->db->prepare($sql);
        $query->execute($params);
        $pass = $query->fetch();
        if (is_object($pass)) {
            $pass = $pass->heslo;
        } else {
            $pass = 0;
        }
        return $pass;
    }
        public function getNameById($id) {
        $params = array(':Lekar_id' => $id);
        $sql = "SELECT  jmeno, prijmeni FROM lekar WHERE lekar_id = :Lekar_id";
        $query = $this->db->prepare($sql);
        $query->execute($params);
        return $query->fetch();
    }

}
