<%@page import="com.klef.jfsd.springboot.model.Faculty"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%
Faculty faculty = (Faculty) session.getAttribute("faculty");
if(faculty == null)
{
    response.sendRedirect("sessionexpired");
    return;
}
%>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Profile</title>
    <style>
        /* Global Reset and Body */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #ecf0f1;
            color: #2c3e50;
        }

        /* Centered Content Wrapper */
        .content {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* Profile Card */
        .profile-card {
            background-color: #fff;
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
            transition: box-shadow 0.3s ease;
        }

        .profile-card:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        /* Profile Picture */
        .profile-card img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 20px;
            border: 4px solid #3498db;
        }

        /* Profile Name and Info */
        .profile-card h2 {
            font-size: 24px;
            color: #2980b9;
            margin-bottom: 10px;
        }

        .profile-card p {
            font-size: 16px;
            color: #7f8c8d;
            margin: 5px 0;
        }

        .profile-card .detail {
            font-weight: 600;
            color: #34495e;
        }

        .profile-card .value {
            font-weight: 400;
            color: #2980b9;
        }

        /* Update Profile Button */
        .update-btn {
            margin-top: 30px; /* Adjusted space above the button */
            padding: 15px 30px; /* Increased padding for a more prominent button */
            background-color: #2980b9;
            color: #fff;
            font-size: 18px; /* Increased font size for better readability */
            border-radius: 50px; /* Rounded corners for a sleek look */
            border: none;
            cursor: pointer;
            display: inline-block; /* Make it an inline element */
            text-decoration: none; /* Remove underline */
            transition: background-color 0.3s ease, transform 0.3s ease;
            width: 100%; /* Button takes the full width of the card */
            max-width: 300px; /* Limit the button's width */
        }

        .update-btn:hover {
            background-color: #1f658a;
            transform: translateY(-3px);
        }

        /* Mobile Responsiveness */
        @media (max-width: 600px) {
            .profile-card {
                padding: 20px;
                width: 90%;
            }

            .profile-card h2 {
                font-size: 22px;
            }

            .profile-card p {
                font-size: 14px;
            }

            /* Adjust the button's width on small screens */
            .update-btn {
                width: 100%;
                max-width: none;
            }
        }
    </style>
</head>
<body>

    <%@include file="facultynavbar.jsp"%>

    <div class="content">
        <div class="profile-card">
            <h2>Faculty Profile</h2>
            
            <p class="detail">ID:</p>
            <p class="value"><c:out value="${faculty.id}"></c:out></p>

            <p class="detail">Full Name:</p>
            <p class="value"><c:out value="${faculty.name}"></c:out></p>

            <p class="detail">Department:</p>
            <p class="value"><c:out value="${faculty.department}"></c:out></p>

            <p class="detail">Gender:</p>
            <p class="value"><c:out value="${faculty.gender}"></c:out></p>            

            <p class="detail">Email:</p>
            <p class="value"><c:out value="${faculty.email}"></c:out></p>

            <p class="detail">Contact:</p>
            <p class="value"><c:out value="${faculty.contact}"></c:out></p>

            <!-- Update Profile Button -->
            <a href="updateProfile" class="update-btn">Update Profile</a>
        </div>
    </div>

</body>
</html>
