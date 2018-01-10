<h1><?php
    if(isset($_SESSION['wrongname'])){
        echo '<h1>Spatny uzivatel</h1>';
    }else if(isset($_SESSION['wrongpass'])){
        echo '<h1>Spatne heslo</h1>';
    }else{
        echo '<h1>Prihlaseni';
    }

    unset($_SESSION['wrongpass']);
    unset($_SESSION['wrongname']);
    ?></h1>



<form action="user" method="POST">
    <div class="form-group">
        <input type="text" class="form-control" name="name" placeholder="Id doktora" required>
    </div>
    <div class="form-group">
        <input type="password" class="form-control" name="pass" placeholder="Heslo" required>
    </div>
    <button type="submit" class="btn btn-default">Přihlásit</button>
</form>