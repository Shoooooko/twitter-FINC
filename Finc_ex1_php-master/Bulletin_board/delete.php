<?php
    include 'dbaccess.php';
    if (isset($_POST["delete"])){
        if ($_POST["res_id"]==null){
            // スレッド詳細取得してlogin/userのthreadかcheckした上でresとthread消す
            $stmt = $dbh->prepare('SELECT * FROM Threads WHERE id=?');
            $stmt->execute(array($_POST["thread_id"]));
            $info=$stmt->fetch(PDO::FETCH_ASSOC);
            if($info["userid"]==$_SESSION["userid"]){
                $restmt = $dbh->prepare("delete from Responses where thread_id = :thread_id");
                $restmt -> bindParam(':thread_id',$_POST["thread_id"] , PDO::PARAM_INT);
                $restmt -> execute();
                $stmt = $dbh->prepare('DELETE FROM Threads WHERE id=?');
                $stmt->execute(array($_POST["thread_id"]));
            }
        }else{
            //echo 'res!';
            $restmt = $dbh->prepare('DELETE FROM Responses WHERE (id=? and res_userid=?)');
            $restmt->execute(array('id'=> $_POST["res_id"],'res_userid' => $_SESSION["userid"]));
        }header("Location: home.php");  // mypage画面へ遷移
            echo "削除が完了しました";
    }
?>

<html>
    <body>
    <div><font color="#ff0000">
    <?php echo htmlspecialchars($errorMessage, ENT_QUOTES); ?></font></div>
    </body>
</html>