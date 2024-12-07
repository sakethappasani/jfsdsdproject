<%@page import="com.klef.jfsd.springboot.model.Admin"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
Admin admin = (Admin) session.getAttribute("admin");
if (admin == null) {
	response.sendRedirect("sessionexpired");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .dashboard-container {
            padding: 2rem;
            margin-left: 280px;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }

        .card-icon i {
            font-size: 2rem;
            color: white;
        }

        .students-icon {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
        }

        .faculty-icon {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
        }

        .events-icon {
            background: linear-gradient(135deg, #FF9800 0%, #F57C00 100%);
        }

        .card-content {
            flex: 1;
        }

        .card-title {
            font-size: 1.1rem;
            color: #333;
            margin: 0;
            margin-bottom: 0.5rem;
        }

        .card-count {
            font-size: 1.8rem;
            font-weight: bold;
            color: #2c5282;
            margin: 0;
        }

        .welcome-section {
            background: linear-gradient(135deg, #1a365d 0%, #2c5282 100%);
            padding: 2rem;
            border-radius: 10px;
            color: white;
            margin-bottom: 2rem;
        }

        .welcome-section h1 {
            margin: 0;
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .welcome-section p {
            margin: 0;
            opacity: 0.9;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                margin-left: 0;
                padding: 1rem;
            }

            .cards-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<%@include file="adminnavbar.jsp"%>
    <div class="dashboard-container">
        <div class="welcome-section">
            <h1>Welcome <%=admin.getUsername() %> </h1>
            <p>Monitor and manage your institution's key metrics</p>
        </div>

        <div class="cards-container">
            <!-- Students Card -->
            <div class="card">
                <div class="card-icon students-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="card-content">
                    <h3 class="card-title">Total Students</h3>
                    <p class="card-count"><c:out value="${studentCount}"/></p>
                </div>
            </div>

            <!-- Faculty Card -->
            <div class="card">
                <div class="card-icon faculty-icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <div class="card-content">
                    <h3 class="card-title">Total Faculty</h3>
                    <p class="card-count"><c:out value="${facultyCount}"/></p>
                </div>
            </div>

            <!-- Events Card -->
            <div class="card">
                <div class="card-icon events-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="card-content">
                    <h3 class="card-title">Total Events</h3>
                    <p class="card-count"><c:out value="${eventCount}"/></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
