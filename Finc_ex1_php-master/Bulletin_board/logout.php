<?php
session_start();
//session解除
unset($_SESSION['userid']);
unset($_SESSION['username']);
header("Location: entrance.php"); 
?>