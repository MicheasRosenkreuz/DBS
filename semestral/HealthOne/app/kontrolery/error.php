<?php
namespace app\kontrolery;

/*
* Error controller
* pro zobrazovani chyb
*/
use core\Controller;
use core\View;

if(!defined('BASE_DIR')) die('no direct script access');

class Error extends Controller {
    
    public function __construct() {
        $this->setTemplate('app/sablony/default');
    }
    
    public function index() {
        $this->notFound();
    }

    /**
    * Error 404 - stranka nenalezena
    */
    public function notFound() {
        $this->template->set('title', '404 - not found');
        $content = new View('app/pohledy/404');
        $this->template->content = $content->render();
        echo $this->template->render();
    }

    /**
     *
     * Error 500 - debugovaci vypis
     * @param \Exception $exception
     * @throws \Exception
     */
    public function debugError(\Exception $exception) {
        $this->template->set('title', '500 - server error');
        $content = new View('app/pohledy/debugger');
        $content->set('myException', $exception);
        $this->template->content = $content->render();
        echo $this->template->render();
        exit();
    }


    /**
     *
     * Error 500 - debugovaci vypis
     * realne by bylo nutne zalogovat chybu, poslat mail adminovi, nebo oboji...
     * @param \Exception $exception
     * @throws \Exception
     */
    public function error500(\Exception $exception) {

        $this->template->set('title', '500 - server error');
        $content = new View('app/pohledy/500');
        $this->template->content = $content->render();
        echo $this->template->render();
        exit();
    }

   

}