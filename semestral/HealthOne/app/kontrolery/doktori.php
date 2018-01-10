<?php
/**
 * Created by PhpStorm.
 * User: Michal Jirásek
 * Date: 10.01.2018
 * Time: 21:56
 */

namespace app\kontrolery;

use core\Controller;
use core\View;

class Doktori extends Controller
{
    private $ct;

    public function __construct() {
        if (isset($_SESSION['logged'])) {
            $this->setTemplate('app/sablony/pacienti');
        } else {
            $this->setTemplate('app/sablony/default');
        }
        $this->openDatabaseConnection();
        $this->ct = new \app\modely\doktori($this->db);
    }

    public function index(){
        if (!isset($_SESSION['logged'])) {
            $this->template->set('title', 'HealthOne - Home');
            $content = new View('app/pohledy/home');
            $this->template->set('content', $content->render());
        }else {
            $this->setTemplate('app/sablony/doktori');
            $this->template->set('title', 'HealthOne - Doktoři');
            $doktori = new View('app/pohledy/doktori/all');
            $doktori->set('doktori', $this->ct->selectTableLekari());
            $this->template->set('content', $doktori->render());
        }
        echo $this->template->render();
    }

}