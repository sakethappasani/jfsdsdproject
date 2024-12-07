<%@page import="com.klef.jfsd.springboot.model.Faculty"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Faculty faculty = (Faculty) session.getAttribute("faculty");
if (faculty == null) 
{
    response.sendRedirect("sessionexpired");
    return;
}
%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${msg}</title>
<style>
    /* General Page Layout */
    .faculty-message-body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .faculty-content {
        max-width: 900px;
        margin: 30px auto;
        padding: 20px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .faculty-message h2 {
        margin: 20px 0;
        font-size: 24px;
    }

    /* Red and Green Message Styles */
    .faculty-message-box {
        font-size: 20px;
        font-weight: bold;
        padding: 15px;
        border-radius: 5px;
        width: 100%;
        text-align: center;
    }

    .faculty-error-message {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    .faculty-success-message {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    /* Link Style */
    .faculty-link {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }

    .faculty-link:hover {
        background-color: #2980b9;
    }

    /* Mobile Responsiveness */
    @media (max-width: 768px) {
        .faculty-content {
            width: 90%;
            padding: 15px;
        }

        .faculty-message h2 {
            font-size: 20px;
        }

        .faculty-link {
            width: 100%;
            text-align: center;
        }
    }
</style>
</head>
<body class="faculty-message-body">
    <%@include file="facultynavbar.jsp"%>
    <div class="faculty-content">

        <c:if test="${flag == false}">
            <div class="faculty-message-box faculty-error-message">
                <h2>${msg}</h2>
            </div>
            <a class="faculty-link" href="facultymyevents">Back</a>
        </c:if>

        <c:if test="${flag == true}">
            <div class="faculty-message-box faculty-success-message">
                <h2>${msg}</h2>
            </div>
            <a class="faculty-link" href="facultymyevents">Back</a>
        </c:if>
    </div>
</body>
</html>
