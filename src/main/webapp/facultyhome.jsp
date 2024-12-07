<%@page import="com.klef.jfsd.springboot.model.Faculty"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Faculty faculty = (Faculty) session.getAttribute("faculty");
if(faculty == null)
{
	response.sendRedirect("sessionexpired");
	return;
}
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Faculty Home</title>
</head>
<body>
<%@include file="facultynavbar.jsp" %>
<div class="content">
<h3 align="center">Welcome <i style="color: green;"><%=faculty.getId()%>-<%=faculty.getName() %></i></h3>
</div>
</body>
</html>