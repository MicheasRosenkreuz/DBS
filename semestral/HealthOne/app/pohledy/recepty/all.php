<div class="container-fluid content-margin">
    <table class="ukoly table table-hover" data-type="objects">
        <thead>
            <tr>
                <th width="15%">Id Receptu</th>
                <th width="55%">Název Léku</th>
                <th width="15%">Doktor</th>
                <th width="15%">Pacient</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if(isset($recepty)) {
                foreach ($recepty as $row) {
                    $id = ($row->recept_id);
                    $id_l = ($row->lek_id);
                    ?>
                    <tr class = "cursor-pointer">				
                        <td><a href="?id=<?= $id ?>&id_l=<?= $id_l ?>" style="display: block"><?= $row->recept_id ?></a></td>
                        <td><a href="?id=<?= $id ?>&id_l=<?= $id_l ?>" style="display: block"><?= $row->lek_jmeno ?></a></td>
                        <td><a href="?id=<?= $id ?>&id_l=<?= $id_l ?>" style="display: block"><?= $row->lekar_jm.' '.$row->lekar_pr?></a></td>
                        <td><a href="?id=<?= $id ?>&id_l=<?= $id_l ?>" style="display: block"><?= $row->pacient_jmeno ?></a></td>
                    </tr>

                <?php }
            } ?>


        </tbody>
    </table>
    <div data-type="json">
    </div>
</div>
