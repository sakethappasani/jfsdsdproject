<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Blocked</title>
    <style>
        /* General body styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Centering the content */
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            background-color: #fff;
        }

        h3 {
            font-size: 32px;
            color: #e74c3c;
            margin-top: 0;
            font-weight: bold;
        }

        p {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }

        a {
            font-size: 16px;
            color: #3498db;
            text-decoration: none;
            background-color: #e0e0e0;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        /* Hover effect for the Back link */
        a:hover {
            background-color: #bdc3c7;
            transform: scale(1.05);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            h3 {
                font-size: 28px;
            }

            p {
                font-size: 16px;
            }

            a {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Your Account has been Blocked !!</h3>
        <p>Please contact your concerned Admin</p>
        <a href="login">Back</a>
    </div>
</body>
</html>
