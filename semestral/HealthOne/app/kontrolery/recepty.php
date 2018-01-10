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
            /*if (isset($_GET['sel'])) {
                switch ($_GET['sel']) {
                    case "all":
                        $content = new View('app/pohledy/tasks/all');
                        $content->set('ukoly', $this->getAllTasks());
                        break;
                    case "done":
                        $content = new View('app/pohledy/tasks/done');
                        $content->set('ukoly', $this->getAllTasks());
                        break;
                    case "notdone":
                        $content = new View('app/pohledy/tasks/notdone');
                        $content->set('ukoly', $this->getAllTasks());
                        break;
                    case "json":
                        $content = new View('app/pohledy/tasks/json');
                        $content->set('ukoly', $this->getAllTasks());
                        break;
                    case "addtask":
                        $content = new View('app/pohledy/tasks/addtask');
                        $this->addTask();
                        break;
                    case "changevalue":
                        $content = new View('app/pohledy/tasks/all');
                        $this->updateValueByTaskId($_SESSION['taskid']);                     
                        $content->set('ukoly', $this->getAllTasks());
                        break;
                    case "changestatus":
                        $content = new View('app/pohledy/tasks/all');                       
                        $this->updateByTaskId($_SESSION['taskid']);
                        $content->set('ukoly', $this->getAllTasks());
                        break;   
                    case "delete":
                        $content = new View('app/pohledy/tasks/all');
                        $this->deleteByTaskId($_SESSION['taskid']);
                        $content->set('ukoly', $this->getAllTasks());
                    default:
                        $content = new View('app/pohledy/tasks/all');
                        $content->set('ukoly', $this->getAllTasks());
                        break;
                }
			/*
            } else if (isset($_GET['id'])) {
                $_SESSION['taskid'] = $_GET['id'];
                $content = new View('app/pohledy/tasks/detail');
                $content->set('ukol', $this->getById($_GET['id']));
                $content->set('user', $this->getUserById($_SESSION['id']));
            } else if (isset($_GET['changestatus'])) {
                $content = new View('app/pohledy/home');
                $content->set('ukoly', $this->getAllTasks());
                $idt = (int) $_SESSION['taskid'];
                $this->updateByTaskId($idt);
            } else if (isset($_GET['changevalue'])) {
                $content = new View('app/pohledy/tasks/changevalue');
                if (isset($_POST['newvalue'])) {
                    $this->updateValueByTaskId($_SESSION['taskid']);
                }
            } else {
                $content = new View('app/pohledy/tasks/all');
                $content->set('ukoly', $this->getAllTasks());
            }*/
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
