<div class="container-fluid content-margin">
    <table class="ukoly table table-hover" data-type="objects">
        <thead>
            <tr>
                <th width="5%">RC pacienta</th>
                <th width="15%">Cele jmeno</th>
                <th width="10%">Adresa</th>
                <th width="10%">Telefon</th>
                <th width="10%">Email</th>
				<th width="10%">Praktický lékař</th>
				<th width="10%">Superpojištěnec</th>
				<th width="15%">Pojišťovna</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if(isset($pacienti)) {
                foreach ($pacienti as $row) {
                    $id = (int) ($row->rc);
            ?>
            <tr class = "cursor-pointer">
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $id ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->pacient ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->adresa?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->telefon ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->email ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->lekar ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->superpojistenec ?></a></td>
                <td><a href="?id=<?= $id ?>" style="display: block"><?= $row->pojistovna ?></a></td>
            </tr>
            <?php
                }
            } ?>

        </tbody>
    </table>
    <div data-type="json">
    </div>
</div>
