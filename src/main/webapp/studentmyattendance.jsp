<%@page import="com.klef.jfsd.springboot.model.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core"  prefix="c"%>
<%
Student student = (Student) session.getAttribute("student");
if (student == null) {
    response.sendRedirect("sessionexpired");
    return;
}
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View All Students</title>
    <style>
        /* General body styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding-left: 200px; /* Offset for fixed navbar */
        }

        /* Title styling */
        h3 {
            text-align: center;
            color: #2C3E50; /* Matching navbar color */
            font-size: 24px;
            margin-top: 20px;
            text-transform: uppercase;
        }

        /* Content container */
        .content-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            margin-top: 20px;
        }

        /* Table header styling */
        th {
            padding: 14px;
            background: #2C3E50;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 15px;
        }

        /* Table data cell styling */
        td {
            padding: 12px;
            font-size: 14px;
            color: #333;
            border-bottom: 1px solid #e0e0e0;
        }

        /* Row striping for readability */
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:nth-child(odd) {
            background-color: #ffffff;
        }

        /* Hover effect for table rows */
        tr:hover {
            background-color: #e1e8ec;
            transition: background-color 0.3s ease;
        }

        /* Border for table */
        table, th, td {
            border: 1px solid #ddd;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            body {
                padding-left: 0; /* Remove padding for small screens */
            }

            .content-container {
                padding: 15px;
            }

            h3 {
                font-size: 22px;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <%@include file="studentnavbar.jsp" %>
    <div class="content-container">
        <h3>My Attendance Status</h3>
        
<table>
    <tr>
        <th>S.No</th>
        <th>Event ID</th>
        <th>Event Name</th>
        <th>Status</th>
    </tr>
<c:forEach items="${attendanceList}" var="val" varStatus="status">
    <tr>
        <td><c:out value="${status.index + 1}"/></td> <!-- Display Serial Number -->
        <td><c:out value="${val.event.eventid}"/></td>
        <td><c:out value="${val.event.name}"/></td>
        <td><c:out value="${val.status ? 'Present' : 'Absent'}"/></td>
    </tr>
</c:forEach>

</table>

    </div>
</body>
</html>
