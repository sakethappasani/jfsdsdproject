<%@page import="com.klef.jfsd.springboot.model.Faculty"%>
<%@page import="com.klef.jfsd.springboot.model.Student"%>
<%@page import="com.klef.jfsd.springboot.model.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%
Faculty faculty = (Faculty) session.getAttribute("faculty");
if (faculty == null) {
    response.sendRedirect("sessionexpired");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Registrations</title>
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
	color: #2C3E50;
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

/* Center alignment for form button */
form {
	margin-top: 20px;
	text-align: center;
}

/* Styling for the submit button */
form input[type="submit"] {
	background-color: #2C3E50;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

form input[type="submit"]:hover {
	background-color: #34495E;
	transform: scale(1.05);
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	body {
		padding-left: 0;
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
	<%@ include file="facultynavbar.jsp"%>
	<div class="content-container">
		<h3>Registered Students</h3>
		<c:if test="${regList.size()>0}">
			<form action="markattedance" method="post">
				<table>
					<tr>
						<th>S.No</th>
						<th>ID</th>
						<th>Name</th>
						<th>Attendance</th>
					</tr>
					<c:forEach var="reg" items="${regList}">
						<tr align="center">
							<td><c:out value="${regList.indexOf(reg) + 1}" /></td>
							<td><c:out value="${reg.student.id}" /></td>
							<td><c:out value="${reg.student.name}" /></td>
							<td><input type="checkbox"
								name="attendance${regList.indexOf(reg) + 1}" /></td>
						</tr>
					</c:forEach>
				</table>
				<input type="hidden" name="eid" value="${regList[0].event.eventid}"/>
				<input type="submit" value="Post Attendance">
			</form>
		</c:if>
		<c:if test="${regList.size()==0}">
			<h4 align="center">No Students Registered</h4>
		</c:if>
	</div>
</body>
</html>
