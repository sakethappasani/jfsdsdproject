<%@page import="com.klef.jfsd.springboot.model.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 Student s = (Student) session.getAttribute("student");
 if(s == null)
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
.container {
    width: 80%;
    margin: 0 auto;
    display: block;
}

.card {
    width: 100%;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    margin: 15px 0;
    overflow: hidden;
    display: flex;
    align-items: center;
    font-family: Arial, sans-serif;
}

.card img {
    width: 200px;
    height: 200px;
    object-fit: cover;
    border-radius: 8px 0 0 8px;
}

.card-content {
    padding: 15px;
    text-align: left;
    flex: 1;
}

.card-content h4 {
    margin: 5px 0;
    font-size: 20px;
}

.card-content p {
    margin: 5px 0;
    color: #555;
}

.button-container {
    margin-top: 10px;
    display: flex;
    gap: 10px;
}

.btn {
    padding: 8px 16px;
    font-size: 14px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
}

.btn-update {
    background-color: #4CAF50;
    color: white;
}

.btn-delete {
    background-color: #f44336;
    color: white;
}

#searchContainer {
    text-align: center;
    margin: 20px;
}

#myInput {
    padding: 10px;
    width: 60%;
    font-size: 16px;
    border: 1px solid #ddd;
    border-radius: 5px;
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
    <%@include file="studentnavbar.jsp"%>
    <div class="content">
        <h3 align="center">My Events</h3>

        <div id="searchContainer">
            <input type="text" id="myInput" onkeyup="filterEvents()"
                placeholder="Search for events by name...">
        </div>

        <div id="cardContainer" class="container">
            <h3 align="center" style="color: green">${message}</h3>
            <c:forEach items="${regList}" var="regevent">
                <div class="card">
                    <img alt="eventimage"
                        src="eventimage?eid=${regevent.event.eventid}">
                    <div class="card-content">
                        <h4>
                            <c:out value="${regevent.event.name}" />
                        </h4>
                        <p>
                            <strong>Description:</strong>
                            <c:out value="${regevent.event.description}" />
                        </p>
                        <p>
                            <strong>Category:</strong>
                            <c:out value="${regevent.event.category}" />
                        </p>
                        <p>
                            <strong>Venue:</strong>
                            <c:out value="${regevent.event.venue}" />
                        </p>

                        <p>
                            <strong>Date:</strong>
                            <c:out value="${regevent.event.date}" />
                        </p>
                        <p>
                            <strong>Time:</strong>
                            <c:out value="${regevent.event.time}" />
                        </p>
                        <p>
                            <strong>Available Slots:</strong>
                            <c:out value="${regevent.event.availableSlots}" />
                        </p>
                        <c:if test="${regevent.canUnregister}">
                            <div class="button-container">
                                <form action="unregisterevent" method="post"
                                    style="display: inline;">
                                    <input type="hidden" name="eid"
                                        value="${regevent.event.eventid}"> 
                                    <input type="hidden" name="sid" value="${regevent.student.id}">
                                    <button type="submit" class="btn btn-delete">Unregister</button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
	