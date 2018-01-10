<?php
/*
* zakladni Controller - pro odvozovani vlastnich
*/

namespace core;

use PDO;
use PDOException;

class Controller
{
    /**
     * Database Connection
     * @var $db null
     */
    public $db = null;

    /**
     * Template
     * @var View
     */
    public $template = null;


    /**
    * Database connector method
    */
    protected function openDatabaseConnection()
    {
        //PDO options
        $options = array(
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"
        );

        // database PDO connector
        $db_init = DB_TYPE . ':host=' . DB_HOST . ';dbname=' . DB_NAME;

        try {
            $this->db = new PDO($db_init, DB_USER, DB_PASS, $options);
        }
        catch (PDOException $e) {
            //znovu vyhodime pro vychozi error handler
            throw $e;
        }

    }


    /**
    * Set View template
    * @param $template - template name
    */

    protected function setTemplate($template) {

        $this->template = new View($template);

    }
}    