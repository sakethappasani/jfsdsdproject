<%@page import="com.klef.jfsd.springboot.model.Faculty"%>
<%@page import="com.klef.jfsd.springboot.model.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Faculty faculty = (Faculty) session.getAttribute("faculty");
if(faculty == null)
{
	response.sendRedirect("sessionexpired");
	return;
}
%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View All Events</title>
<style>
    /* General Container */
    .container {
        width: 80%;
        margin: 0 auto;
        display: block;
        padding: 20px;
    }

    /* Card Styles */
    .card {
        width: 100%;
        display: flex;
        margin: 15px 0;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        border: 1px solid #ddd;
        transition: transform 0.3s ease;
    }

    .card:hover {
        transform: scale(1.03);
    }

    .card img {
        width: 200px;
        height: 200px;
        object-fit: cover;
        border-radius: 8px 0 0 8px;
    }

    .card-content {
        flex: 1;
        padding: 15px;
        text-align: left;
    }

    .card-content h4 {
        margin: 5px 0;
        font-size: 20px;
        color: #333;
    }

    .card-content p {
        margin: 5px 0;
        color: #555;
    }

    /* Button Container */
    .button-container {
        margin-top: 15px;
        display: flex;
        gap: 10px;
        align-items: center;
    }

    /* Buttons */
    .btn {
        padding: 8px 16px;
        font-size: 14px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
        display: inline-block;
        transition: background-color 0.3s ease;
    }

    .btn:hover {
        opacity: 0.8;
    }

    .btn-update {
        background-color: #4CAF50;
        color: white;
    }

    .btn-delete {
        background-color: #f44336;
        color: white;
    }

    .btn-students {
        background-color: #3498db;
        color: white;
    }

    .btn-attendance {
        background-color: orange;
        color: white;
    }

    /* Search Input */
    #searchContainer {
        text-align: center;
        margin: 20px 0;
    }

    #myInput {
        padding: 10px;
        width: 60%;
        font-size: 16px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .container {
            width: 100%;
        }

        .card {
            flex-direction: column;
            align-items: center;
        }

        .card img {
            width: 100%;
            height: auto;
        }

        .card-content {
            text-align: center;
        }

        #myInput {
            width: 80%;
        }

        .button-container {
            flex-direction: column;
            gap: 15px;
        }
    }
</style>
<script>
    function filterEvents() {
        var input, filter, container, cards, cardContent, eventName, i, txtValue;
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        container = document.getElementById("cardContainer");
        cards = container.getElementsByClassName("card");

        for (i = 0; i < cards.length; i++) {
            cardContent = cards[i].getElementsByClassName("card-content")[0];
            eventName = cardContent.getElementsByTagName("h4")[0];
            txtValue = eventName.textContent || eventName.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                cards[i].style.display = "flex";
            } else {
                cards[i].style.display = "none";
            }
        }
    }
</script>
</head>
<body>
<%@include file="facultynavbar.jsp" %>
<div class="content">
<h3 align="center">My Events</h3>

<div id="searchContainer">
    <input type="text" id="myInput" onkeyup="filterEvents()" placeholder="Search for events by name...">
</div>

<div id="cardContainer" class="container">
<h3 align="center" style="color: green">${message}</h3>
    <c:forEach items="${femList}" var="fem">
        <div class="card">
            <img alt="eventimage" src="eventimage?eid=${fem.event.eventid}">
            <div class="card-content">
                <h4><c:out value="${fem.event.name}"/></h4>
                <p><strong>Description:</strong> <c:out value="${fem.event.description}"/></p>
                <p><strong>Category:</strong> <c:out value="${fem.event.category}"/></p>
                <p><strong>Venue:</strong> <c:out value="${fem.event.venue}"/></p>
                <p><strong>Date:</strong> <c:out value="${fem.event.date}"/></p>
                <p><strong>Time:</strong> <c:out value="${fem.event.time}"/></p>
                <p><strong>Available Slots:</strong> <c:out value="${fem.event.availableSlots}"/></p>
                <div class="button-container">
                    <form action="facultyviewstudents" method="post" style="display:inline;">
                        <input type="hidden" value="${fem.event.eventid}" name="eid">
                        <button type="submit" class="btn btn-students">View Students</button>
                    </form>
                    <form action="postattendance" method="post" style="display:inline;">
                        <input type="hidden" value="${fem.event.eventid}" name="eid">
                        <button type="submit" class="btn btn-attendance">Post Attendance</button>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
</div>
</body>
</html>
