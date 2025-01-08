<?php
// Database configuration
$db_host = "sql104.infinityfree.com"; // You'll get this from InfinityFree
$db_name = "if0_38011353_surveytime"; // You'll get this from InfinityFree
$db_user = "if0_38011353"; // You'll get this from InfinityFree
$db_pass = "6ON5AJYdqudH"; // You'll get this from InfinityFree

try {
    $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?> 
