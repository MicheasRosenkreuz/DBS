<div class="container-fluid">
    <table class="ukoly table table-hover table-bordered" >
        <tbody>

            <tr>
                <td width="25%">Vypisující doktor: </td><td><?= $recepty->lekar_jm.' '.$recepty->lekar_pr ?></td>
            </tr>

            <tr>
                <td width="25%">Jméno pacienta: </td><td><?= $recepty->pacient_jmeno.' '.$recepty->pacient_prijmeni ?></td>
            </tr>
			<tr>
                <td width="25%">Název léku: </td><td><?= $recepty->lek_jmeno ?></td>
            </tr>
			<tr>
                <td width="25%">Účel léku: </td><td><?= $recepty->ucel ?></td>
            </tr>
			<tr>
                <td width="25%">Možné vedlejší účinky: </td><td><?= $recepty->vedlejsi ?></td>
            </tr>
			<tr>
                <td width="25%">Dávkování: </td><td><?= $recepty->davkovani ?></td>
            </tr>
        </tbody>

    </table>

    <div data-type="json">
    </div>
</div>