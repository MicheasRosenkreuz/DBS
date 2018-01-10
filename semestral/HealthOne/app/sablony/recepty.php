<?php if (!defined('BASE_DIR')) die('no direct script acess'); ?>
<!DOCTYPE html>

<html lang="cs">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">


        <title>HealthOne - <?= $title ?></title>

        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!-- Custom styles for this template -->
        <link href="mycss.css" rel="stylesheet" type="text/css">

    </head>

    <body>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="home">HealthOne</a>
                </div><?php if (isset($_SESSION['logged'])) { ?>                       
                    <ul class="nav navbar-nav hlavni-navigace">
                        <li>
                            <a href="pacienti">PACIENTI</a>
                        </li>

                        <li>
                            <a href="recepty">RECEPTY</a>
                        </li>
						<li>
                            <a href="recepty">DOKTOŘI</a>
                        </li>
                    </ul><?php } ?>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="<?php echo isset($_SESSION['logged']) ? 'logout' : 'user' ?>">
                            <span class="glyphicon glyphicon-log-in"></span> 
                            <?php echo isset($_SESSION['logged']) ? 'logout' : 'login' ?>
                        </a></li>
                </ul>
            </div>
        </nav>
        <div id="content" class="container">
            <div>
                <div class="col-sm-6 col-xs-6 prepinace">
                    <a href="?sel=all"><button class="btn btn-lg" id="vsechny">Všechny</button></a>
                    <a href="?sel=byid"><button class="btn btn-lg" id="splnene">Mnou vypsané recepty</button></a>               
                </div>
            </div>
            <div class="row" style="text-align: center">
                <?php echo $content; ?>
            </div>
        </div>
        <footer class="footer">
            <div class="container-fluid">
                <div class="fooclass">Michal Jirásek, Jiří Sál, Patrik Jíra</div>
            </div>
        </footer>
    </body>


</html>