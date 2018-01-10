<div style="margin-top: 10%;"><?php $_SESSION['date'] = date('Y-m-d H:i:s'); ?>
    <form action="pacienti?sel=add_zazn" method="POST">
        <div class="form-group">
            <textarea class="form-control" name="jmeno" placeholder="Jméno" required></textarea>	
		</div>
		<div class="form-group">
            <textarea class="form-control" name="prijmeni" placeholder="Přijmení" required></textarea>	
		</div>
		<div class="form-group">
            <textarea class="form-control" name="adresa" placeholder="Adresa" required></textarea>	
		</div>
		<div class="form-group">
            <textarea class="form-control" name="telefon" placeholder="Telefon" required></textarea>	
		</div>
		<div class="form-group">
            <textarea class="form-control" name="email" placeholder="Email" required></textarea>	
		</div>
        <button type="submit" class="btn btn-default" style="margin-top: 0.5%">Pridej</button>
    </form>
</div>