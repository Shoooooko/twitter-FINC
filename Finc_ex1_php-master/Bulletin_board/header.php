<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>掲示板</title>
        <link href="./stylesheets/reset.css" rel="stylesheet">
        <link href="./stylesheets/bulletin.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <h1 class="menu">掲示板</h1>
                <ul class="sub-menu">
                    <li>
                        <a href="logout.php">ログアウト</a>
                    </li>
                    <li>
                        <a href="home.php"><?php echo $_SESSION["username"]?>さんのMYページ</a>
                    </li>
                    <li>
                        <a href="thread.php">投稿一覧</a>
                    </li>
                    <li>
                        <a href="post.php">新規投稿</a>
                    </li>
                </ul>
        </header>
    </body>
</html>
