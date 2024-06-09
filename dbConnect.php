<?php
    //Data Source Name
    $dsn = "mysql:host=127.0.0.1;port=3306;dbname=db_eshop";
    //uzivatel DB
    $user = "root";
    //heslo k DB
    $pass = "";

    //instance rozhrani PDO
    try {
        $db = new PDO(
            $dsn,
            $user,
            $pass,
            array(
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"
            )
        );
    } catch (PDOException $e) {
        //co se stane kdyz konstruktor selze
        die("Chyba v konstruktoru PDO : " . $e->getMessage());
    }
?>