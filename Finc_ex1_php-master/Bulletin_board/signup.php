<?php
    session_start();
    $errorMessage = "";
    // ログインボタンが押された場合
    if (isset($_POST["submit"])){
            // 1. ユーザIDの入力チェック
        if (empty($_POST["username"])) {
            $errorMessage = 'ユーザーIDが未入力です。';
            exit();
        }
        if (empty($_POST["password"])) {
            $errorMessage = 'パスワードが未入力です。';
            exit();
        }

        else if (!empty($_POST["username"]) && !empty($_POST["password"])) {
        $password = $_POST["password"];
        include 'dbaccess.php';
        //レコード挿入 prepred statement でescape処理も自動で行われる
        //placeholfer用いてSQLインジェクション対策
        $stmt=$dbh->prepare("insert into users (name,password) values(?,?)");
        $stmt->execute(array($_POST["username"],$_POST["password"]));
        header("Location: entrance.php");  // login画面へ遷移
            echo "ユーザ登録が完了しました";
            exit();  // 処理終了
        } else {// 認証失敗
            $errorMessage = 'ユーザーIDあるいはパスワードに誤りがあります。';
        }
    }
?>

<html>

<head>
    <meta charset="utf-8">
    <title>掲示板</title>
    <link href="./stylesheets/reset.css" rel="stylesheet">
    <link href="./stylesheets/bulletin.css" rel="stylesheet">
</head>

<body>
    <header>
        <nav>
            <h1 class="menu">掲示板</h1>
        </nav>
    </header>
    <div class="signup">
        <p>
        <h3>新規登録画面</h3>
        </p>
        <form name="signup" action="signup.php" method="post">
        <div><font color="#ff0000"><?php echo htmlspecialchars($errorMessage, ENT_QUOTES); ?></font></div>
            <legend>ユーザID：</legend>
                <input type="text" name="username", placeholder="ユーザネームを入力してください">
            <br>
            <legend>パスワード：</legend>
                <input type="password" name="password" , placeholder="半角英数文字8文字で入力してください">
            <p>
                <input type="submit" name="submit" value="登録する">
            </p>
        </form>
    </div>
</body>

</html>