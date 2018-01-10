<?php
/**
 * Created by PhpStorm.
 * User: Michal Jirásek
 * Date: 10.01.2018
 * Time: 21:56
 */

namespace app\modely;


class Doktori
{

    private $db;

    function __construct($db) {
        $this->db = $db;
    }

    public function selectTableLekari() {
        $sql =
"SELECT lekar_id, CONCAT(l.jmeno, ' ',  l.prijmeni) as jmeno, l.adresa, l.telefon, specializace,
  n.nazev AS nemocnice
FROM lekar l LEFT JOIN nemocnice n on l.nemocnice_id=n.nemocnice_id;";

        $result = $this->db->query($sql);
        return $result->fetchAll();
    }

}