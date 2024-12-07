<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ page import="com.klef.jfsd.springboot.model.Admin"%>
<%

Admin admin = (Admin)session.getAttribute("admin");
if(admin == null)
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
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Add Event</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
.form-container {
	max-width: 800px;
	margin: 2rem auto 2rem 33%;
	padding: 2rem;
	background: rgba(255, 255, 255, 0.75);
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
	background: linear-gradient(120deg, rgba(26, 54, 93, 0.05) 0%,
		rgba(44, 82, 130, 0.05) 100%),
		url('https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&q=80&w=2070')
		center/cover no-repeat;
	filter: blur(0px);
	z-index: -1;
}

.form-header {
	text-align: center;
	margin-bottom: 2rem;
	color: #1a365d;
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

textarea.form-input {
	min-height: 120px;
	resize: vertical;
}

.file-input-container {
	position: relative;
	margin-top: 1rem;
}

.file-input-label {
	display: flex;
	align-items: center;
	gap: 0.5rem;
	padding: 0.75rem 1rem;
	background: #f8fafc;
	border: 2px dashed #2c5282;
	border-radius: 8px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.file-input-label:hover {
	background: #f1f5f9;
}

.file-input-label i {
	color: #2c5282;
	font-size: 1.25rem;
}

input[type="file"] {
	position: absolute;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	opacity: 0;
	cursor: pointer;
}

.submit-btn {
	display: block;
	width: 100%;
	padding: 1rem;
	background: linear-gradient(150deg, #1a365d, #2c5282);
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 1.1rem;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s ease;
	margin-top: 2rem;
}

.submit-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(44, 82, 130, 0.2);
}

.success-message {
	text-align: center;
	color: #059669;
	background: #ecfdf5;
	padding: 1rem;
	border-radius: 8px;
	margin-bottom: 1rem;
}

@media ( max-width : 768px) {
	.form-container {
		margin: 1rem;
		padding: 1.5rem;
	}
	.form-header h2 {
		font-size: 2rem;
	}
}
</style>
</head>

<body>
	<%@ include file="adminnavbar.jsp"%>

	<div class="page-background"></div>

	<div class="form-container">
		<div class="form-header">
			<h2>Create New Event</h2>
			<p>Fill in the details below to register a new event</p>
		</div>

		<c:if test="${not empty message}">
			<div class="success-message">
				<i class="fas fa-check-circle"></i> ${message}
			</div>
		</c:if>

		<form action="insertevent" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label class="form-label" for="ename">Event Name</label>
        <input type="text" class="form-input" id="ename" name="ename" required placeholder="Enter event name">
    </div>

    <div class="form-group">
        <label class="form-label" for="edescription">Event Description</label>
        <textarea class="form-input" id="edescription" name="edescription" required placeholder="Provide a detailed description of the event"></textarea>
    </div>

    <div class="form-group">
        <label class="form-label" for="ecategory">Event Category</label>
        <input type="text" class="form-input" id="ecategory" name="ecategory" required placeholder="Enter event category">
    </div>

    <div class="form-group">
        <label class="form-label" for="evenue">Event Venue</label>
        <input type="text" class="form-input" id="evenue" name="evenue" required placeholder="Enter event location">
    </div>

    <div class="form-group">
        <label class="form-label" for="edate">Event Date</label>
        <input type="date" class="form-input" id="edate" name="edate" required>
    </div>

    <div class="form-group">
        <label class="form-label" for="etime">Event Time</label>
        <input type="time" class="form-input" id="etime" name="etime" required>
    </div>

    <div class="form-group">
        <label class="form-label" for="totalslots">Total Slots</label>
        <input type="number" class="form-input" id="totalslots" name="totalslots" required min="1" placeholder="Enter total number of slots">
    </div>

    <div class="form-group">
        <label class="form-label">Event Image</label>
        <div class="file-input-container">
            <label class="file-input-label">
                <i class="fas fa-cloud-upload-alt"></i>
                <span>Choose an image for the event</span>
                <input type="file" id="eimage" name="eimage" required accept="image/*">
            </label>
        </div>
    </div>

    <input type="hidden" name="eaddedby" value="<%= admin.getUsername() %>" />

    <button type="submit" class="submit-btn">
        <i class="fas fa-calendar-plus"></i> Create Event
    </button>
</form>

	</div>
</body>
</html>
