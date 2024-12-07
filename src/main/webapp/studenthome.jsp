<%@ page import="com.klef.jfsd.springboot.model.Student" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
Student student = (Student) session.getAttribute("student");
if (student == null) {
    response.sendRedirect("sessionexpired");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Home</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <%@ include file="studentnavbar.jsp" %>
    <div class="content">
        <h3 align="center">Welcome <i style="color: green;"><%= student.getId() %> - <%= student.getName() %></i></h3>
        
        <!-- Leaderboard Table -->
        <h3 align="center">Leaderboard</h3>
        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Attendance Count</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="entry" items="${leaderboard}">
                    <tr>
                        <td><c:out value="${entry.studentId}" /></td>
                        <td><c:out value="${entry.studentName}" /></td>
                        <td><c:out value="${entry.attendanceCount}" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
