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
    require_once(".\dbConnect.php");

    //promenna pro dotaz
    $query = NULL;

    //def. hodnoty kvuli pamatovani si posledni volby
    $jednotky = "lahev 0.5l";

    //kontrola tlacitek
    if (isset($_REQUEST["submit_jednotky"])) {
        //budeme filtrovat podle pohlavi
        //stahneme data
        $jednotky = htmlspecialchars($_REQUEST["jedn"]);


        try {
            //pripravime SQL dotaz
            $query = $db->prepare("SELECT * FROM tbl_zbo WHERE jedn = ?");
            //pripravime pole s parametry
            $params = array($jednotky);
            //spustime dotaz s parametry
            $query->execute($params);
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }
    ?>

    <h1>Zbozi podle merne jednotky</h1>
    <form action="" method="post">
        <fieldset>
            <legend>Merna jednotka</legend>
            lahev 0.5l : <input type="radio" name="jedn" value="lahev 0.5l" <?php echo (($jednotky == "lahev 0.5l") ? " checked" : ""); ?> /><br />
            lahev 0.75l : <input type="radio" name="jedn" value="lahev 0.75l" <?php echo (($jednotky == "lahev 0.75l") ? " checked" : ""); ?> /><br />
            lahev 1.5l : <input type="radio" name="jedn" value="lahev 1.5l" <?php echo (($jednotky == "lahev 1.5l") ? " checked" : ""); ?> /><br />
            lahev 2l : <input type="radio" name="jedn" value="lahev 2l" <?php echo (($jednotky == "lahev 2l") ? " checked" : ""); ?> /><br />
            ks : <input type="radio" name="jedn" value="ks" <?php echo (($jednotky == "ks") ? " checked" : ""); ?> /><br />
            kg : <input type="radio" name="jedn" value="kg" <?php echo (($jednotky == "kg") ? " checked" : ""); ?> /><br />
            <input type="submit" name="submit_jednotky" value="Filtruj" />
        </fieldset>

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