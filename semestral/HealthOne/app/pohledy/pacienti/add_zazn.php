<div style="margin-top: 10%;"><?php $_SESSION['date'] = date('Y-m-d H:i:s'); ?>
    <form action="pacienti?sel=add_zazn" method="POST">
        <div class="form-group">
            <textarea class="form-control" name="diagnoza" placeholder="Diagnoza" required></textarea>	
        </div>
		<select class="form-control" name="lek">
			<option>Bez léku</option>
			<?php $sal = $this->_data['pacienti'];
				for ($i = 0; $i < sizeof($sal); $i++) {?>
					<option><?php echo $sal[$i]->jmeno ?></option>
			<?php }?>
		</select>
		<div class="form-group">
            <textarea class="form-control" name="davkovani" placeholder="Davkovani" style="margin-top: 0.5%"></textarea>	
        </div>
        <button type="submit" class="btn btn-default" style="margin-top: 0.5%">Pridej</button>
    </form>
</div>