<?php
    include 'dbaccess.php';
    include 'header.php';
?>

<!doctype html>
<html>
    <body>
        <div class="container" >
            <h3>Myスレッド一覧</h3>
                <?php
                    $stmt = $dbh->prepare('SELECT * FROM Threads WHERE userid = ?');
                    $stmt->execute(array($_SESSION["userid"]));?>
                <fieldset>
                    <ol>
                        <?php foreach($stmt->fetchAll(PDO::FETCH_ASSOC) as $thread):?>
                            <li class="thread">
                                <h4><?php echo htmlspecialchars($thread['title']);?></h4>
                                <a href='./detail.php?thread_id=<?php echo $thread['id']?>'>詳細</a>
                                <a href='./edit.php?thread_id=<?php echo $thread['id']?>'>編集</a>
                                <form method="post" action="delete.php">
                                    <p>
                                        <input type="submit" name="delete" value="削除">
                                    </p>
                                    <input type="hidden" name="thread_id" value="<?php echo $thread['id'];?>">
                                </form>
                            </li>
                        <?php endforeach; ?>
                    </ol>
                </fieldset>
        </div>
    </body>
</html>

