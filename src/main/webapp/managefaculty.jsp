<%@page import="com.klef.jfsd.springboot.model.Student"%>
<%@page import="com.klef.jfsd.springboot.model.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="jakarta.tags.core" prefix="c"%>

<%
Admin admin = (Admin) session.getAttribute("admin");
if (admin == null) {
	response.sendRedirect("sessionexpired");
	return;
}
%><%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Faculty</title>
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

        /* Add styling for the Delete button */
        .delete-link {
            color: #fff;
            background-color: #e74c3c; /* Red color for Delete button */
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        /* Hover effect for the Delete button */
        .delete-link:hover {
            background-color: #c0392b; /* Darker red */
            transform: scale(1.05);
        }

        /* Styling for Update link */
        .update-link {
            color: #FFFFFF; /* Light blue color for Update */
            background-color: #FFA500; /* Light gray background for Update */
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        /* Hover effect for Update link */
        .update-link:hover {
            color: #FFFFFF;
            background-color: #FFD580; /* Slightly darker gray for hover */
            transform: scale(1.05);
        }

        /* Styling for Active and Block buttons */
        .active-link {
            color: white;
            background-color: #28a745; /* Green color for Active button */
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .block-link {
            color: white;
            background-color: #dc3545; /* Red color for Block button */
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .active-link:hover {
            background-color: #218838; /* Darker green on hover */
            transform: scale(1.05);
        }

        .block-link:hover {
            background-color: #c82333; /* Darker red on hover */
            transform: scale(1.05);
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
    <%@include file="adminnavbar.jsp" %>
    <div class="content-container">
        <h3>Manage Faculty</h3>
        
        <table>
            <tr>
                <th>Faculty ID</th>
                <th>Full Name</th>
                <th>Gender</th>
                <th>Department</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${facultyList}" var="faculty">
                <tr>
                    <td><c:out value="${faculty.id}"/></td>
                    <td><c:out value="${faculty.name}"/></td>
                    <td><c:out value="${faculty.gender}"/></td>
                    <td><c:out value="${faculty.department}"/></td>
                    <td><c:out value="${faculty.contact}"/></td>
                    <td><c:out value="${faculty.email}"/></td>
                    
                    <td>
                        <a href='<c:url value="updatefaculty?fid=${faculty.id}"></c:url>' class="update-link">Update</a>
                        <c:if test="${faculty.status=='true'}"><a href='<c:url value="blockfaculty/${faculty.id}"></c:url>' class="block-link">Block</a></c:if>
                        <c:if test="${faculty.status=='false'}"><a href='<c:url value="unblockfaculty/${faculty.id}"></c:url>' class="active-link">Active</a></c:if>
                    </td>
                    
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>