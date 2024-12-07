<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f6f9fc 0%, #edf2f7 100%);
        }

        .navbar {
            height: 100%;
            width: 280px;
            position: fixed;
            top: 0;
            left: 0;
            background: linear-gradient(150deg, #1a365d 0%, #2c5282 50%, #2b6cb0 100%);
            padding-top: 20px;
            transition: all 0.3s ease;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
        }

        .nav-header {
            padding: 20px;
            text-align: center;
            color: white;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 20px;
            background: rgba(255, 255, 255, 0.1);
        }

        .nav-header i {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #ffffff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .nav-header h2 {
            font-size: 1.5rem;
            font-weight: 500;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }

        .nav-item {
            padding: 15px 25px;
            text-decoration: none;
            font-size: 1.1rem;
            color: white;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            position: relative;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }

        .nav-item i {
            margin-right: 12px;
            width: 24px;
            text-align: center;
        }

        .nav-item:hover {
            background: linear-gradient(90deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            padding-left: 35px;
        }

        .nav-item.active {
            background: linear-gradient(90deg, rgba(255, 255, 255, 0.2) 0%, rgba(255, 255, 255, 0.1) 100%);
            border-left: 4px solid #ffffff;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.4);
            backdrop-filter: blur(4px);
            z-index: 1000;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal.active {
            display: flex;
            opacity: 1;
        }

        .modal-content {
            background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
            width: 90%;
            max-width: 500px;
            margin: auto;
            padding: 30px;
            border-radius: 15px;
            position: relative;
            transform: translateY(-50px);
            transition: transform 0.3s ease;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .modal.active .modal-content {
            transform: translateY(0);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e2e8f0;
        }

        .modal-header h3 {
            color: #1a365d;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #64748b;
            transition: color 0.2s ease;
        }
        .close-modal:hover {
            color: #1a365d;
        }

        .modal-options {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
        }

        .modal-option {
            padding: 20px;
            background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
            border-radius: 12px;
            text-decoration: none;
            color: #2c5282;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
        }

        .modal-option:hover {
            background: #ffffff;
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(44, 82, 130, 0.1);
        }

        .modal-option i {
            font-size: 1.5rem;
            margin-right: 15px;
            color: #2c5282;
        }

        .modal-option-content {
            flex: 1;
        }

        .modal-option-content h4 {
            color: #2c5282;
            margin-bottom: 5px;
            font-size: 1.1rem;
        }

        .modal-option-content p {
            color: #64748b;
            font-size: 0.9rem;
        }

        .content {
            margin-left: 280px;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }

        @media (max-width: 768px) {
            .navbar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .content {
                margin-left: 0;
                margin-top: 20px;
            }

            .nav-item {
                padding: 12px 20px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="nav-header">
        <i class="fas fa-user-graduate"></i>
        <h2>Student Dashboard</h2>
    </div>
    
    <a href="studenthome" class="nav-item <%= (request.getRequestURI().endsWith("studenthome")) ? "active" : "" %>">
        <i class="fas fa-home"></i>
        Home
    </a>
    
    <a href="displayallevents" class="nav-item <%= (request.getRequestURI().endsWith("displayallevents")) ? "active" : "" %>">
        <i class="fas fa-calendar-alt"></i>
        View All Events
    </a>
    
    <a href="stumyevents" class="nav-item <%= (request.getRequestURI().endsWith("stumyevents")) ? "active" : "" %>">
        <i class="fas fa-calendar-check"></i>
        My Events
    </a>
    
        <a href="studentmyattendance" class="nav-item <%= (request.getRequestURI().endsWith("studentmyprofile")) ? "active" : "" %>">
        <i class="fas fa-user"></i>
        My Attendance
    </a>
    
           <a href="studentmyprofile" class="nav-item <%= (request.getRequestURI().endsWith("studentmyprofile")) ? "active" : "" %>">
        <i class="fas fa-user"></i>
        Profile
    </a>
    
    <a href="logout" class="nav-item <%= (request.getRequestURI().endsWith("logout")) ? "active" : "" %>">
        <i class="fas fa-sign-out-alt"></i>
        Logout
    </a>
</div>



</body>
</html>
