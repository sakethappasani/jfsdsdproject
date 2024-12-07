<%@page import="com.klef.jfsd.springboot.model.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Faculty Event Mapping</title>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
/* Page Background */
.page-background {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(120deg, rgba(26, 54, 93, 0.05) 0%,
        rgba(44, 82, 130, 0.05) 100%),
        url('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&q=80&w=2070')
        center/cover no-repeat;
    filter: blur(0px);
    z-index: -1;
}

/* Form Container */
.form-container {
    max-width: 800px;
    margin: 3rem auto;
    padding: 2.5rem;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
    backdrop-filter: blur(4px);
    border: 1px solid rgba(255, 255, 255, 0.18);
}

/* Form Header */
.form-header {
    text-align: center;
    margin-bottom: 2rem;
}

.form-header h2 {
    font-size: 2rem;
    background: linear-gradient(150deg, #1a365d, #2c5282);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.form-header p {
    color: #64748b;
}

/* Form Elements */
.form-group {
    margin-bottom: 1.5rem;
}

.form-label {
    display: block;
    margin-bottom: 0.5rem;
    color: #2c5282;
    font-weight: 500;
    font-size: 1rem;
}

.form-input {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    background: white;
    transition: all 0.3s ease;
    font-size: 1rem;
}

.form-input:focus {
    outline: none;
    border-color: #2c5282;
    box-shadow: 0 0 0 3px rgba(44, 82, 130, 0.1);
}

select.form-input {
    appearance: none;
    background-image:
        url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%232c5282' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 0.75rem center;
    background-size: 1em;
    padding-right: 2.5rem;
}

/* Submit Button */
.btn-submit {
    width: 100%;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 500;
    background: linear-gradient(150deg, #1a365d, #2c5282);
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(44, 82, 130, 0.2);
}
</style>
</head>
<body>

	<%@ include file="adminnavbar.jsp"%>
    <div class="page-background"></div>

    <div class="form-container">
        <div class="form-header">
            <h2>Faculty Event Mapping</h2>
            <p>Select a faculty member and map them to an event</p>
        </div>

        <form method="post" action="mapfacultyevent">
            <div class="form-group">
                <label class="form-label" for="faculty">Select Faculty</label>
                <select name="faculty" id="faculty" class="form-input" required>
                    <option value="">--Select Faculty--</option>
                    <c:forEach var="faculty" items="${facultyList}">
                        <option value="${faculty.id}">${faculty.id} - ${faculty.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label" for="event">Select Event</label>
                <select name="event" id="event" class="form-input" required>
                    <option value="">--Select Event--</option>
                    <c:forEach var="event" items="${eventList}">
                        <option value="${event.eventid}">${event.name} - ${event.date} - ${event.time}</option>
                    </c:forEach>
                </select>
            </div>

            <input type="hidden" name="admin" value="${admin.username}" />
            <button type="submit" class="btn-submit">Save Mapping</button>
        </form>
    </div>
</body>
</html>
