<div class="container-fluid">
    <table class="ukoly table table-hover table-bordered" >
        <tbody>
			<?php if ((count($this->_data['pacienti'])) == 0) { ?>
			<div>
				<div>
					<h1>Karta je prázdná</h1>
				</div>
			</div>		
			<?php }else {?>
            <tr>
                <td width="25%">Jméno pacienta: </td><td><?= $this->_data['pacienti'][0]->pacient_jm." ".$this->_data['pacienti'][0]->pacient_pr ?></td>
            </tr>
			<tr>
                <td width="25%">Záznamy: </td><td></td>
            </tr>	
			<?php $sal = $this->_data['pacienti'];
                for ($i = 0; $i < sizeof($sal); $i++) {
                    $id = (int) ($sal[$i]->pacient_rc);
                    ?>
                    <tr>				
                        <td></td><td><?php echo $sal[$i]->diagnoza ?></td>
                    </tr>

                <?php } ?>
			<?php }?>
        </tbody>

    </table>

    <div data-type="json">
    </div>
</div>