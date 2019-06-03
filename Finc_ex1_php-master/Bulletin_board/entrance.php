<?php
session_start();
// エラーメッセージの初期化
$errorMessage = "";
// ログインボタンが押された場合
if (isset($_POST["login"])) {
    // 1. ユーザIDの入力チェック
    if (empty($_POST["username"])) {  // emptyは値が空のとき
        $errorMessage = 'ユーザーIDが未入力です。';
    }
    else if (empty($_POST["password"])) {
        $errorMessage = 'パスワードが未入力です。';
    }

    else {
        // 入力したユーザIDを格納
        $username = $_POST["username"];
        include 'dbaccess.php';//DB接続
        $stmt = $dbh->prepare('SELECT * FROM users WHERE name = ?');
        $stmt->execute(array($username));
        $password = $_POST["password"];
        $userinfo=$stmt->fetch(PDO::FETCH_ASSOC);
        if($userinfo["password"]==$password){
            //userのIDとusernameをセッションに
            $_SESSION["userid"] = $userinfo["id"];
            $_SESSION["username"]= $userinfo["name"];
            header("Location: home.php");
                exit();  // 処理終了
        } else {// 認証失敗
            $errorMessage = 'ユーザーIDあるいはパスワードに誤りがあります。';
        }
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

        <!ログインユーザ場合のフォーム：入力してこのphpファイル実行される>
        <div class="login">
            <form  action="entrance.php" method="post">
                <fieldset>
                    <legend>ログインフォーム</legend>
                    <div><font color="#ff0000"><?php echo htmlspecialchars($errorMessage, ENT_QUOTES); ?></font></div>
                        <label>ユーザーID</label>
                            <input type="text" name="username" placeholder="ユーザーIDを入力"
                            value="<?php if (!empty($_POST["username"])) {echo htmlspecialchars($_POST["username"], ENT_QUOTES);} ?>">
                        <br>
                        <label>パスワード</label>
                            <input type="password" name="password" , placeholder="半角英数文字8文字で入力してください">
                        <p>
                            <input type="submit" name="login" value="ログイン">
                        </p>
                </fieldset>
            </form>
        </div>

        <!新規ユーザの：設定画面にとぶ>
        <div class="signup">
            <form action="signup.php" method="post">
                <fieldset>
                    <legend>未登録の方</legend>
                        <input type="submit" name="signup" value="新規登録">
                </fieldset>
            </form>
        </div>
    </body>
</html>