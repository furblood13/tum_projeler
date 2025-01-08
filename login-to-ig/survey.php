<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quick Survey</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: #fafafa;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .survey-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }
        h1 {
            text-align: center;
            color: #262626;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #262626;
        }
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #dbdbdb;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #0095f6;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-weight: 600;
        }
        button:hover {
            background-color: #0086e6;
        }
    </style>
</head>
<body>
    <div class="survey-container">
        <h1>Quick Survey</h1>
        <form action="process.php" method="POST">
            <div class="form-group">
                <label for="major">What is your major?</label>
                <input type="text" id="major" name="major" required>
            </div>
            <div class="form-group">
                <label for="city">Which city do you live in?</label>
                <input type="text" id="city" name="city" required>
            </div>
            <div class="form-group">
                <label for="expected_salary">How much money do you expect to earn when you graduate? ($)</label>
                <input type="number" id="expected_salary" name="expected_salary" required>
            </div>
            <div class="form-group">
                <label for="age">How old are you?</label>
                <input type="number" id="age" name="age" required>
            </div>
            <button type="submit" name="submit_survey">Submit Survey</button>
        </form>
    </div>
</body>
</html> 