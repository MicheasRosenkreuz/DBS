<?php

namespace app\kontrolery;

use core\Controller;
use core\View;

class Pacienti extends Controller {

    public function __construct() {
        if (isset($_SESSION['logged'])) {
            $this->setTemplate('app/sablony/pacienti');
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
            $this->template->set('title', 'Pacienti');
            $content = new View('app/pohledy/home');
        } else {
            $this->template->set('title', 'Pacienti');
			$content = new View('app/pohledy/pacienti/all');
			$content->set('pacienti', $this->getAllPatients());
			if (isset($_GET['sel'])) {
				switch ($_GET['sel']) {
					case "all":
						$content = new View('app/pohledy/pacienti/all');
						$content->set('pacienti', $this->getAllPatients());
						break;
					case "byid":
						$content = new View('app/pohledy/pacienti/byid');
						$content->set('pacienti', $this->getAllPatientsById($_SESSION['id']));
						break;
					case "add_zazn":					
						$this->template->set('title', 'Karta');
						$content = new View('app/pohledy/pacienti/add_zazn');
						$content->set('pacienti', $this->getLeky());
						$this->addDiagnoza();
						break;
					case "add_pacient":
						$this->template->set('title', 'Přidej pacienta');
						$content = new View('app/pohledy/doktori/add_pacient');
						$content->set('pacienti', $this->getAllPatients());
						$this->addDiagnoza();
						break;
					default:
						break;
				}
			}else if (isset($_GET['id'])) {
				$id = $_GET['id'];
				$_SESSION['pacient_rc'] = $id;
				$this->setTemplate('app/sablony/karta');
				$this->template->set('title', 'Karta');
				$content = new View('app/pohledy/pacienti/pacientdetail');
				$content->set('pacienti', $this->getAllById($id));
			}
        }

        $this->template->set('content', $content->render());
        echo $this->template->render();
    }

//ziskani všech receptu
    public function getAllPatients() {
        $db = new \app\modely\pacienti($this->db);
        $db = $db->selectTablePacient();
        return $db;
    }
	public function getAllPatientsById($id) {
        $db = new \app\modely\pacienti($this->db);
        $db = $db->getAllById($id);
        return $db;
    }
	public function getAllById($id) {
		$db = new \app\modely\pacienti($this->db);
		$db = $db->getDetailOfPacient($id);
		return $db;	
	}
	public function getLeky(){
		$db = new \app\modely\pacienti($this->db);
		$db = $db->getLeky();
		return $db;
	}
	public function getIdLekuByName($jmeno_leku){
		$db = new \app\modely\pacienti($this->db);
		$db = $db->getIdLekuByName($jmeno_leku);
		return $db;
	}
	public function insertRecept($recept_id, $lek_id, $lekar_id, $pacient_rc, $davkovani){
		$db = new \app\modely\pacienti($this->db);
		$db = $db->insertRecept($recept_id, $lek_id, $lekar_id, $pacient_rc, $davkovani);
		return $db;
	}
	public function getMaxIdReceptu(){
		$db = new \app\modely\pacienti($this->db);
		$db = $db->getMaxId();
		return $db;
	}
	public function addDiagnoza() {
        if (isset($_POST['diagnoza'])) {
			if ($_POST['lek'] == "Bez léku") {
				$db = new \app\modely\pacienti($this->db);
				$lekar_id = $_SESSION['id'];
				$pacient_rc = $_SESSION['pacient_rc'];
				$date = $_SESSION['date'];
				$db = $db->insertDiagnoza($pacient_rc, $lekar_id, $_POST['diagnoza'], $date);
			}else{
				$db = new \app\modely\pacienti($this->db);
				$lekar_id = $_SESSION['id'];
				$pacient_rc = $_SESSION['pacient_rc'];
				$date = $_SESSION['date'];
				$lek_id = $this->getIdLekuByName($_POST['lek']);
				$davkovani = $_POST['davkovani'];
				$recept_id = $this->getMaxIdReceptu();
				$recept_id = $recept_id->recept_id;
				$recept_id = (int)($recept_id);
				$recept_id += 1;	
				$db = $db->insertRecept($recept_id, $lek_id->lek_id, $lekar_id, $pacient_rc, $davkovani);
				$db = new \app\modely\pacienti($this->db);
				$db = $db->insertDiagnozaa($pacient_rc, $lekar_id, $recept_id, $_POST['diagnoza'], $date);
			}
        }
    }
}
