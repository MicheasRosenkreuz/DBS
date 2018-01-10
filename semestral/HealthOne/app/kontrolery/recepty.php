<?php

namespace app\kontrolery;

use core\Controller;
use core\View;

class Recepty extends Controller {

    public function __construct() {
        if (isset($_SESSION['logged'])) {
            $this->setTemplate('app/sablony/recepty');
        } else {
            $this->setTemplate('app/sablony/default');
        }
        $this->openDatabaseConnection();
    }

    /**
     * zakladni metoda controlleru
     */
    public function index() {

        if (!isset($_SESSION['logged'])) {
            $this->template->set('title', 'Domu');
            $content = new View('app/pohledy/home');
        } else {
            $this->template->set('title', 'Recepty');
			$content = new View('app/pohledy/recepty/all');
			$content->set('recepty', $this->getAllRecepts());
			if (isset($_GET['sel'])) {
				switch ($_GET['sel']) {
					case "all":
						$content = new View('app/pohledy/recepty/all');
						$content->set('recepty', $this->getAllRecepts());
						break;
					case "byid":
						$content = new View('app/pohledy/recepty/all');
						$content->set('recepty', $this->getAllReceptsById($_SESSION['id']));
						break;
					default:
						break;
				}
			}else if (isset($_GET['id'])) {
				$id = $_GET['id'];
                $id_l = $_GET['id_l'];
				$content = new View('app/pohledy/recepty/receptdetail');
				$content->set('recepty', $this->getAllById($id, $id_l));
			}

        }

        $this->template->set('content', $content->render());
        echo $this->template->render();
    }

//ziskani všech receptu
    public function getAllRecepts() {
        $db = new \app\modely\recepty($this->db);
        $db = $db->getAll();
        return $db;
    }
	public function getAllReceptsById($id) {
        $db = new \app\modely\recepty($this->db);
        $db = $db->getAllById($id);
        return $db;
    }
	public function getAllById($id, $id_l) {
		$db = new \app\modely\recepty($this->db);
		$db = $db->getDetailOfRecepis($id, $id_l);
		return $db[0];
	}
}
