<?php
    session_start();
    //データベースへの接続
    try {
        $dbh=new PDO('mysql:host=127.0.0.1;dbname=finc_bulletin','shokosql','amberoshi');
        //PDOのエラーレポートを表示
        $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        $errorMessage = 'データベースエラー';
        exit;
    }
?>