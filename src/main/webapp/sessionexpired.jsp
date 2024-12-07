<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Session Expired</title>
    <style>
        /* General Body Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }

        /* Main Container */
        .container {
            background: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }

        /* Title */
        h3 {
            font-size: 24px;
            color: #ff6f61;
            margin-bottom: 20px;
        }

        /* Button Styles */
        a {
            display: inline-block;
            padding: 12px 24px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #45a049;
        }

        /* Additional Message */
        p {
            font-size: 16px;
            color: #555;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .container {
                padding: 20px;
                width: 90%;
            }

            h3 {
                font-size: 20px;
            }

            a {
                font-size: 14px;
            }
        }

    </style>
</head>
<body>

    <div class="container">
        <h3>Session Expired !!</h3>
        <p>Your session has expired. Please log in again to continue.</p>
        <a href="login">Login</a>
    </div>

</body>
</html>
