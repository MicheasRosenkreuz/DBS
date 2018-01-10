<?php

namespace app\kontrolery;

/*
 * Home controller 
 * ukazka pouziti View
 */

use core\Controller;
use core\View;

class Logout extends Controller {

    public function __construct() {
        $this->setTemplate('app/sablony/default');
    }

    /**
     * zakladni metoda controlleru
     */
    public function index() {
        $this->template->set('title', 'Logout');
        $content = new View('app/pohledy/logout');
        $this->template->set('content', $content->render());
        echo $this->template->render();
    }

}
