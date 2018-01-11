<div class="container-fluid content-margin">
    <table class="ukoly table table-hover" data-type="objects">
        <thead>
            <tr>
                <th width="5%">ID doktora</th>
                <th width="15%">Cele jmeno</th>
                <th width="10%">Adresa</th>
                <th width="10%">Telefon</th>
                <th width="10%">Specializace</th>
                <th width="10%">Název nemocnice</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if(isset($doktori)) {
                foreach ($doktori as $row) {
                    $id = ($row->lekar_id);
            ?>
            <tr class = "cursor-pointer">
                <td><a href="#" style="display: block"><?= $id ?></a></td>
                <td><a href="#" style="display: block"><?= $row->jmeno ?></a></td>
                <td><a href="#" style="display: block"><?= $row->adresa ?></a></td>
                <td><a href="#" style="display: block"><?= $row->telefon ?></a></td>
                <td><a href="#" style="display: block"><?= $row->specializace ?></a></td>
                <td><a href="#" style="display: block"><?= $row->nemocnice ?></a></td>
            </tr>
            <?php
                }
            } ?>

        </tbody>
    </table>
    <div data-type="json">
    </div>
</div>
