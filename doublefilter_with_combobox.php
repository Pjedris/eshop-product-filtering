<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESHOP</title>
    <style>
        html * {
            font-size: 14px;
            line-height: 1.625;
            color: black;
            font-family: Nunito, sans-serif;
        }

        table {
            border: 1px solid black;
            border-collapse: collapse;
            text-align: center;
        }

        td {
            border: 1px solid black;
            border-collapse: collapse;
            text-align: center;
        }

        tr {
            border: 2px solid black;
            border-collapse: collapse;
            text-align: center;
        }

        body {
            background-color: lightgrey;
        }

        input[type=submit] {
            background-color: blue;
            border: none;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            font-weight: bold;
            margin: 4px 2px;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <?php
    //pripojeni k DB
    require_once (".\dbConnect.php");

    //promenna pro dotaz
    $query = NULL;

    //def. hodnoty kvuli pamatovani si posledni volby
    $jednotky = isset($_POST['jedn']) ? $_POST['jedn'] : array();
    $kategorie = isset($_POST['kat']) ? $_POST['kat'] : array();

    //kontrola tlacitek
    if (isset($_REQUEST["submit_jednotky"])) {
        //budeme filtrovat podle merne jednotky a kategorie
        try {
            $sql = "SELECT * FROM tbl_zbo WHERE 1=1";
            $params = array();

            // Dynamicky sestavit SQL podle vybranych kategorii
            $sql .= !empty($kategorie) ? " AND kat IN (" . rtrim(str_repeat('?,', count($kategorie)), ',') . ")" : '';
            $params = array_merge($params, $kategorie);

            // Dynamicky sestavit SQL podle vybranych jednotek
            $sql .= !empty($jednotky) ? " AND jedn IN (" . rtrim(str_repeat('?,', count($jednotky)), ',') . ")" : '';
            $params = array_merge($params, $jednotky);

            $query = $db->prepare($sql);
            $query->execute($params);
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    } else if(isset($_REQUEST["zobraz_vse"])) {
                //zobraz vse
                try {
                    $sql = "SELECT * FROM tbl_zbo";
                    $params = array();
                    $query = $db->prepare($sql);
                    $query->execute($params);
                } catch (PDOException $e) {
                    die($e->getMessage());
                }
    }
    ?>

    <!-- HTML FORMULÁŘ -->
    <h1>Zbozi podle merne jednotky a kategorie</h1>
    <form action="" method="post">
        <fieldset>
            <legend>Merna jednotka</legend>
            lahev 0.5l : <input type="radio" name="jedn[]" value="lahev 0.5l" <?php echo (in_array("lahev 0.5l", $jednotky) ? " checked" : ""); ?> /><br />
            lahev 0.75l : <input type="radio" name="jedn[]" value="lahev 0.75l" <?php echo (in_array("lahev 0.75l", $jednotky) ? " checked" : ""); ?> /><br />
            lahev 1.5l : <input type="radio" name="jedn[]" value="lahev 1.5l" <?php echo (in_array("lahev 1.5l", $jednotky) ? " checked" : ""); ?> /><br />
            lahev 2l : <input type="radio" name="jedn[]" value="lahev 2l" <?php echo (in_array("lahev 2l", $jednotky) ? " checked" : ""); ?> /><br />
            ks : <input type="radio" name="jedn[]" value="ks" <?php echo (in_array("ks", $jednotky) ? " checked" : ""); ?> /><br />
            kg : <input type="radio" name="jedn[]" value="kg" <?php echo (in_array("kg", $jednotky) ? " checked" : ""); ?> /><br />
        </fieldset>

        <fieldset>
            <legend>Kategorie</legend>
            <select name="kat[]">
                <option name="kat[]" value="dest" <?php echo (in_array("dest", $kategorie) ? " selected" : ""); ?>>
                    destiláty</option>
                <option name="kat[]" value="limo" <?php echo (in_array("limo", $kategorie) ? " selected" : ""); ?>>
                    limonády</option>
                <option name="kat[]" value="minVo" <?php echo (in_array("minVo", $kategorie) ? " selected" : ""); ?>>
                    minerální vody</option>
                <option name="kat[]" value="nap" <?php echo (in_array("nap", $kategorie) ? " selected" : ""); ?>>nápoje
                </option>
                <option name="kat[]" value="napAl" <?php echo (in_array("napAl", $kategorie) ? " selected" : ""); ?>>
                    alkoholické nápoje</option>
                <option name="kat[]" value="napNa" <?php echo (in_array("napNa", $kategorie) ? " selected" : ""); ?>>
                    nealkoholické nápoje</option>
                <option name="kat[]" value="ovze" <?php echo (in_array("ovze", $kategorie) ? " selected" : ""); ?>>ovoce
                    zelenina</option>
                <option name="kat[]" value="pec" <?php echo (in_array("pec", $kategorie) ? " selected" : ""); ?>>pečivo
                </option>
                <option name="kat[]" value="pivo" <?php echo (in_array("pivo", $kategorie) ? " selected" : ""); ?>>pivo
                </option>
                <option name="kat[]" value="vino" <?php echo (in_array("vino", $kategorie) ? " selected" : ""); ?>>víno
                </option>

            </select>
        </fieldset>

        <input type="submit" name="submit_jednotky" value="Filtruj" />
        <input type="submit" name="zobraz_vse" value="Zobraz vše" />
    </form>


    <!-- Zobrazoveni dat -->
    <table>
        <tr style="font-weight: bold; background-color: dimgray;">
            <td>Kategorie</td>
            <td>Nazev</td>
            <td>Popis</td>
            <td>Jednotkova cena</td>
            <td>Merna jednotka</td>
            <td>Jednotky na sklade</td>
        </tr>

        <?php
        //zkontroluji jestli mam v query data
        if ($query != NULL) {
            //mam data k zobrazeni
            while (($radek = $query->fetch(PDO::FETCH_BOTH)) != FALSE) {
                //stahneme data do extra promennych
                $kat = $radek["kat"];
                $naz = $radek["naz"];
                $pop = $radek["pop"];
                $jcen = $radek["jcen"];
                $jedn = $radek["jedn"];
                $sklad = $radek["sklad"];

                //vyechujeme do radku tabulky
                echo ("<tr> <td>$kat</td> <td>$naz</td>
                     <td>$pop</td> <td>$jcen</td> <td>$jedn</td>
                     <td>$sklad</td>
             </tr>");
            }
        }
        ?>
    </table>
</body>
</html>