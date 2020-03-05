<?php
    include 'dbaccess.php';
    include 'header.php';
    // スレッド詳細取得
    $stmt = $dbh->prepare('SELECT * FROM Threads WHERE id=?');
    $stmt->execute(array($_GET["thread_id"]));
    $info=$stmt->fetch(PDO::FETCH_ASSOC);
    //レス詳細取得
    $restmt = $dbh->prepare('SELECT * FROM Responses WHERE thread_id=?');
    $restmt->execute(array($_GET["thread_id"]));
?>

<!doctype html>
<html>
    <body>
        <!あるスレッドの詳細表示>
        <div class="container" >
            <h2>タイトル:<?php echo htmlspecialchars($info['title']);?></h2>
                <h3>[スレッド内容]</h3>
                <fieldset>
                    <div class="thread">
                    <?php echo htmlspecialchars($info['body']);?>
                    </div>
                </fieldset>
            <h3>＊レス一覧</h3>
            <a href='./respost.php?thread_id=<?php echo $info['id']?>'>レス追加</a>
            <fieldset>
                <ol>
                    <?php foreach($restmt->fetchAll(PDO::FETCH_ASSOC) as $resinfo):?>
                        <li class="thread">
                            <?php echo htmlspecialchars($resinfo["title"]);?>
                            <?php echo ":";?>
                            <?php echo htmlspecialchars($resinfo["res_body"]);?>
                            <?php if($resinfo["res_userid"]==$_SESSION["userid"]):?>
                                <a href='./edit.php?res_id=<?php echo $resinfo['id']?>&type=res'>編集</a>
                                <form method="post" action="delete.php">
                                    <p>
                                        <input type="submit" name="delete" value="削除">
                                    </p>
                                    <input type="hidden" name="thread_id" value=<?php echo $thread['id'];?>>
                                </form>
                            <?php endif; ?>
                        </li>
                    <?php endforeach; ?>
                </ol>
            </fieldset>
        </div>
    </body>
</html>

