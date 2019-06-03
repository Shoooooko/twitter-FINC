<?php
    include 'dbaccess.php';
    // エラーメッセージの初期化
    $errorMessage = "";
    // 投稿ボタンが押された場合
    if (isset($_POST["submit"])){
        // 入力チェック
        if (empty($_POST["name"])) {  // emptyは値が空のとき
            $errorMessage = 'タイトルが未入力です。';
        } else if (empty($_POST["comment"])) {
            $errorMessage = '内容が未入力です。';
        }
    if (!empty($_POST["name"]) && !empty($_POST["comment"])) {
            //レコード挿入 prepred statement でescape処理も自動で行われる
            //placeholfer用いてSQLインジェクション対策
            $stmt=$dbh->prepare("insert into threads (title,body,userid) values(?,?,?)");
            $stmt->execute(array($_POST["name"],$_POST["comment"],$_SESSION["userid"]));
            header("Location: home.php");  // mypage画面へ遷移
                echo "投稿が完了しました";
            exit();  // 処理終了
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
        <h3>新規投稿</h3>
        <form action="post.php" method="post">
            <!ここに入力されたものをdbに保存した上でhomeに送る>
            <h4>スレッド・レス名</h4>
                <input type="text" name="name">
            <h4>内容</h4>
                <textarea name="comment" cols="30" rows="3" maxlength="80" wrap="hard" placeholder="80字以内で入力してください。"></textarea>
        <p>
            <input type="submit" name="submit" value="投稿">
        </p>
        </form>

</body>
</html>