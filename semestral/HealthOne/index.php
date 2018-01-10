<?php
session_start();
/*
* zakladni FCP a MVC skeleton
*/

//nastavit autoloading
spl_autoload_extensions('.php');
spl_autoload_register();

//load config
require('app/config.php');
//nastavit error handling
require('app/error_handler.php');


//start app - front controller
$app = new \app\Bootstrap();