<%@page import="com.klef.jfsd.springboot.model.Faculty" %>
<%@page import="com.klef.jfsd.springboot.model.Admin" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Faculty faculty = (Faculty) session.getAttribute("faculty");
if (faculty == null) {
    response.sendRedirect("sessionexpired");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Faculty</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Styling the form and page for a modern look */
        .form-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2.5rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .page-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(120deg, rgba(26, 54, 93, 0.05) 0%, rgba(44, 82, 130, 0.05) 100%),
                url('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&q=80&w=2070')
                center/cover no-repeat;
            filter: blur(0px);
            z-index: -1;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h2 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(150deg, #1a365d, #2c5282);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .form-header p {
            color: #64748b;
            font-size: 1.1rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group.full-width {
            grid-column: span 2;
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
            font-size: 1rem;
        }

        .form-input:focus {
            outline: none;
            border-color: #2c5282;
            box-shadow: 0 0 0 3px rgba(44, 82, 130, 0.1);
        }

        .select.form-input {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%232c5282' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            padding-right: 2.5rem;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            justify-content: center;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
        }

        .btn-reset {
            background: #fff;
            color: #2c5282;
            border: 1px solid #2c5282;
        }

        .btn-submit {
            background: linear-gradient(150deg, #1a365d, #2c5282);
            color: white;
        }

        .success-message {
            text-align: center;
            color: #059669;
            background: #ecfdf5;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<%@ include file="facultynavbar.jsp" %>

<div class="page-background"></div>

<div class="form-container">
    <div class="form-header">
        <h2>Update Faculty</h2>
        <p>Edit the details of the faculty below</p>
    </div>

    <c:if test="${not empty param.message}">
        <div class="success-message">
            <i class="fas fa-check-circle"></i> ${param.message}
        </div>
    </c:if>

    <form method="post" action="facultysaveupdate">
        <div class="form-grid">
            <div class="form-group">
                <label class="form-label" for="fid">Faculty ID</label>
                <input type="number" id="fid" name="fid" class="form-input" value="${faculty.id}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label" for="fname">Full Name</label>
                <input type="text" id="fname" name="fname" class="form-input" value="${faculty.name}" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="fdept">Department</label>
                <select id="fdept" name="fdept" class="form-input" required>
                    <option value="">Select Department</option>
                    <option value="CSE" ${faculty.department == 'CSE' ? 'selected' : ''}>CSE</option>
                    <option value="CSIT" ${faculty.department == 'CSIT' ? 'selected' : ''}>CSIT</option>
                    <option value="ECE" ${faculty.department == 'ECE' ? 'selected' : ''}>ECE</option>
                    <option value="EEE" ${faculty.department == 'EEE' ? 'selected' : ''}>EEE</option>
                    <option value="ME" ${faculty.department == 'ME' ? 'selected' : ''}>ME</option>
                </select>
            </div>
            <div class="form-group full-width">
                <label class="form-label">Gender</label>
                <label><input type="radio" name="fgender" value="Male" ${faculty.gender == 'Male' ? 'checked' : ''}> Male</label>
                <label><input type="radio" name="fgender" value="Female" ${faculty.gender == 'Female' ? 'checked' : ''}> Female</label>
                <label><input type="radio" name="fgender" value="Other" ${faculty.gender == 'Other' ? 'checked' : ''}> Other</label>
            </div>
            <div class="form-group">
                <label class="form-label" for="femail">Email</label>
                <input type="email" id="femail" name="femail" class="form-input" value="${faculty.email}" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="fcontact">Contact</label>
                <input type="text" id="fcontact" name="fcontact" class="form-input" value="${faculty.contact}" required>
            </div>
        </div>
        <div class="button-group">
            <button type="submit" class="btn btn-submit">Update Faculty</button>
            <button type="reset" class="btn btn-reset">Reset</button>
        </div>
    </form>
</div>
</body>
</html>
