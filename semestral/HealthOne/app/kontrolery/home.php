<?php
namespace app\kontrolery;

/*
* Home controller 
* ukazka pouziti View
*/

use core\Controller;
use core\View;

class Home extends Controller {

    public function __construct() {
        $this->setTemplate('app/sablony/default');

//        $this->openDatabaseConnection();
    }

    /**
     * zakladni metoda controlleru
     */
    
    public function index() {
        $this->template->set('title', 'home');
        $content = new View('app/pohledy/home');
        $this->template->set('content', $content->render());
        echo $this->template->render();
    }

}