<?php
    include 'dbaccess.php';
    // スレッド詳細取得
    $stmt = $dbh->prepare('SELECT * FROM Threads WHERE id=?');
    $stmt->execute(array($_GET["thread_id"]));
    $info=$stmt->fetch(PDO::FETCH_ASSOC);
    //レス詳細取得
    $restmt = $dbh->prepare('SELECT * FROM Responses WHERE id=?');
    $restmt->execute(array($_GET["res_id"]));
    $resinfo=$restmt->fetch(PDO::FETCH_ASSOC);
    $_SESSION["token"]==uniqid();
    // エラーメッセージの初期化
    $errorMessage = "";

    // 投稿ボタンが押された場合
    if (isset($_POST["edit"])){
        if ($_POST["token"]==$_SESSION["token"]){
            // 入力チェック
            if (empty($_POST["name"])) {  // emptyは値が空のとき
                $errorMessage = 'タイトルが未入力です。';
            }
            else if (empty($_POST["comment"])) {
                $errorMessage = '内容が未入力です。';
            }
            else{
                if ($_POST["type"]=="thread"){
                    //レコード挿入 prepred statement でescape処理も自動で行われる
                    //placeholfer用いてSQLインジェクション対策
                    $estmt=$dbh->prepare("update Threads set title = :title, body = :body where id =:id");
                    $estmt->execute(array(":title"=>$_POST["name"],":body"=>$_POST["comment"],":id"=>$_POST["id"]));
                    header("Location: home.php");  // mypage画面へ遷移
                        echo "編集が完了しました";
                    exit();  // 処理終了
                } else {
                    $erestmt=$dbh->prepare("update Responses set title = :title,res_body = :body where id =:id");
                    $erestmt->execute(array(":title"=>$_POST["name"],":body"=>$_POST["comment"],":id"=>$_POST["id"]));
                    header("Location: home.php");  // mypage画面へ遷移
                        echo "編集が完了しました";
                    exit();  // 処理終了
                }
            }
        }
    }
?>

<?php
    include 'header.php';
?>
<html>

<body>
    <div class="section">
    <div><font color="#ff0000">
    <?php echo htmlspecialchars($errorMessage, ENT_QUOTES); ?></font></div>
        <h2>投稿編集画面</h2>
        <form action="edit.php" method="post">
            <!responseかthreadかをtypeで場合分け>
            <?php if($_GET["type"]=="res"):?>
            <input type="hidden" name="type" value="res">
            <input type="hidden" name="id" value=<?php echo $resinfo["id"]?>
            <h4>レス名</h4>
                <input type="text" name="name" value="<?php echo htmlspecialchars($resinfo["title"]);?>">
            <h4>内容</h4>
                <textarea name="comment" cols="30" rows="3" maxlength="80" wrap="hard" value="<?php echo htmlspecialchars($resinfo["body"]);?>"></textarea>
            <?php else:?>
            <input type="hidden" name="type" value="thread">
            <input type="hidden" name="id" value=<?php echo $info["id"]?>>
            <h4>スレッド名</h4>
                <input type="text" name="name" value="<?php echo htmlspecialchars($info["title"]);?>">
            <h4>内容</h4>
                <textarea name="comment" cols="30" rows="3" maxlength="80" wrap="hard" value="<?php echo htmlspecialchars($info["body"]);?>"></textarea>
        <?php endif ;?>
        <p>
            <input type="submit" name="edit" value="編集完了">
            <input type="hidden" name="token" value="<?php echo $_SESSION["token"]?>">
        </p>
        </form>
</body>
</html>