<div class="container-fluid content-margin">
    <table class="ukoly table table-hover" data-type="objects">
        <thead>
            <tr>
                <th width="15%">RC pacienta</th>
                <th width="25%">Cele jmeno</th>
                <th width="20%">Adresa</th>
                <th width="20%">Telefon</th>
                <th width="20%">Email</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if(isset($pacienti)) {
            foreach ($pacienti as $row) {
            $id = (int) ($row->pacient_rc);
            $id = intval($id);
            ?>

            <tr class = "cursor-pointer">
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->pacient_rc ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->pacient_jm.' '.$row->pacient_pr ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->pacient_adr?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->pacient_tel ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->pacient_email ?></a></td>
            </tr>

                <?php
                }
            } ?>


        </tbody>
    </table>
    <div data-type="json">
    </div>
</div>
