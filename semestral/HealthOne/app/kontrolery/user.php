<?php

namespace app\kontrolery;

use core\Controller;
use core\View;

class User extends Controller {

    public function __construct() {
        $this->setTemplate('app/sablony/default');
        $this->openDatabaseConnection();
    }

    /**
     * zakladni metoda controlleru
     */
    public function index() {
        
        $this->template->set('title', 'User');
        if (isset($_SESSION['logged'])) {
            $user = new \app\modely\ User($this->db);
            $userinfo = $user->getById($_SESSION['id']);
            $content = new View('app/pohledy/user');
        } else {
            $content = new View('app/pohledy/login');
            $this->login();
        }
        $this->template->set('content', $content->render());
        echo $this->template->render();
    }

    public function login() {
        //zkontrolovat prvky
        //pak setnout sešnu a přihlásit ho, to už je hraní s db, to budu dělat zítra :)
        $id = isset($_POST['name']) ? $_POST['name'] : null;
        $pass = isset($_POST['pass']) ? $_POST['pass'] : null;
        if (isset($_POST['name']) && isset($_POST['pass'])) {
            $user = new \app\modely\User($this->db);
            $userpass = $user->getPassById($id);
			if ($userpass != $pass) {
				$content = new View('app/pohledy/login');
				$_SESSION['wrongpass'] = 0;
			} else {
				unset($_SESSION['wrongpass']);
				unset($_SESSION['wrongname']);
				$_SESSION['jmeno'] = $user->getNameById($id);
				$content = new View('app/pohledy/user');
				$_SESSION['id'] = $id;
				$_SESSION['logged'] = 0;
			}	
            $this->template->set('content', $content->render());
            echo $this->template->render();
        }
    }

}
