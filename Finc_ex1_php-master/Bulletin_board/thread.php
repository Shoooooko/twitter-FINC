<?php
    include 'dbaccess.php';
    include 'header.php';
    $stmt = $dbh->query('SELECT * FROM Threads');
?>

<!doctype html>
<html>
    <body>
        <!全スレッド表示>
        <div class="container" >
            <h3>スレッド一覧</h3>
                <fieldset>
                    <ol>
                        <?php foreach($stmt->fetchAll(PDO::FETCH_ASSOC) as $thread):?>
                            <li class="thread">
                                <h4><?php echo htmlspecialchars($thread['title']);?></h4>
                                <a href='./detail.php?thread_id=<?php echo $thread['id'];?>'>詳細</a>
                            </li>
                        <?php endforeach; ?>
                    </ol>
                </fieldset>
        </div>
    </body>
</html>