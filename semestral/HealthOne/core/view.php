<?php
namespace core;
use Exception;

/**
 * zakladni trida pro vytvareni View
 * @author Not anymore
 */

class View {

    protected $_file;
    protected $_data = array();
    
    /**
     *  View constructor
     * @param string / view file name
     * @param array / data to view
     */
    public function __construct($viewname, array $data = NULL) {
        
        $this->_file = $viewname . ".php";
                
        if ($data !== NULL) {
            array_merge($data, $this->_data);
        }
    }
    

    /**
     * Rendering method
     * vytvori retezec reprezentujici dane view slozene z obsahu souboru 
     * a nastavenych promennych
     * @return string
     * @throws Exception
     * @throws \Exception
     */

    public function render() {
        //import pole data ve forme promnenych v lokalnim scope 
        extract($this->_data);
        //start output buffering

        ob_start();
        try {
            require_once $this->_file;
        }
        catch (Exception $e) {
            // pokud se to nepovede, smazeme bufer
            ob_end_clean();
            // Re-throw the exception
            throw $e;
        }

        // vrati obsah bufferu jako retezec
        return ob_get_clean();
    }
    
    
    /**
     * Magic setter
     * usage $view->key = $value;
     */
    public function __set($key, $value) {
        $this->set($key,$value);
    }

    
    /**
     * Function for seting the data to $_data;
     * allows chaining
     * usage: $view->set('key',$data);
     * @param string
     * @param value
     * @return View
     */
    public function set($key, $value = NULL) {
        $this->_data[$key] = $value;
        return $this;
    }
    
}