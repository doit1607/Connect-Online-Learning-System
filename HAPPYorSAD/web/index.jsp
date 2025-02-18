<%-- 
    Document   : index
    Created on : Feb 6, 2025, 5:00:26 AM
    Author     : Ann
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Schedule" %>
<%@ page import="com.example.model.Slot" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.DayOfWeek" %>
<%
    List<Schedule> existingSchedules = (List<Schedule>) request.getAttribute("existingSchedules");
    if (existingSchedules == null) {
        existingSchedules = new ArrayList<>();
    }
    String errorMessage = (String) request.getAttribute("error");
    String successMessage = (String) request.getAttribute("message");
%>
<html>
    <head>
        <title>Select Available Slots</title>
    </head>
    <body>

        <h2>Select Available Slots</h2>

        <% if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
        <% } %>
        <% if (successMessage != null) { %>
        <p style="color: green;"><%= successMessage %></p>
        <% } %>

        <form action="MentorAvailabilityServlet" method="post">
            <input type="hidden" name="action" value="saveChanges">

            <h3>Select Available days</h3>
            <div style="display: flex;">
                <% String[] daysOfWeek = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}; %>
                <% for (String day : daysOfWeek) { %>
                <label style="margin-right: 10px;">
                    <input type="checkbox" name="days" value="<%=day%>" > <%=day%>
                </label>
                <% } %>
            </div>

            <%-- Hiển thị khung giờ cho từng ngày --%>
            <% for (String day : daysOfWeek) { %>
            <h3><%= day %></h3>
            <div>
                <div id="timeSlotsContainer_<%=day%>"> <%-- ID container riêng cho từng ngày --%>
                    <div>
                        <label>Start Time:</label>
                        <select name="startTime[]">
                            <option value="09:00">09:00 AM</option>
                            <option value="09:30">09:30 AM</option>
                            <option value="10:00">10:00 AM</option>
                            <option value="10:30">10:30 AM</option>
                            <option value="11:00">11:00 AM</option>
                            <%-- ... thêm các khung giờ khác ... --%>
                        </select>
                        <label>End Time:</label>
                        <select name="endTime[]">
                            <option value="09:30">09:30 AM</option>
                            <option value="10:00">10:00 AM</option>
                            <option value="10:30">10:30 AM</option>
                            <option value="11:00">11:00 AM</option>
                            <option value="11:30">11:30 AM</option>
                            <%-- ... thêm các khung giờ khác ... --%>
                        </select>
                    </div>
                </div>
                <button type="button" onclick="addTimeSlot('<%=day%>')">Add Slots</button> <%-- Truyền day vào hàm JS --%>
            </div>
            <% } %>


            <h3>Appointment Fees ($)</h3>
            <input type="text" name="appointmentFees" value="254" readonly>

            <br/>
            <button type="button" onclick="location.href = '/* URL hủy bỏ */'">Cancel</button>
            <button type="submit">Save Changes</button>
            <button type="submit" name="action" value="deleteAll">Delete Selected Days</button> <%-- Nút Delete cho ngày chọn --%>
        </form>

        <script>
            function addTimeSlot(day) {
                var containerId = "timeSlotsContainer_" + day; // Tạo ID container động
                var container = document.getElementById(containerId);
                var newSlotDiv = document.createElement("div");

                newSlotDiv.innerHTML = `
                    <label>Start Time:</label>
                    <select name="startTime[]">
                        <option value="09:00">09:00 AM</option>
                        <option value="09:30">09:30 AM</option>
                        <option value="10:00">10:00 AM</option>
                        <option value="10:30">10:30 AM</option>
                        <option value="11:00">11:00 AM</option>
            <%-- ... thêm các khung giờ khác ... --%>
                    </select>
                    <label>End Time:</label>
                    <select name="endTime[]">
                        <option value="09:30">09:30 AM</option>
                        <option value="10:00">10:00 AM</option>
                        <option value="10:30">10:30 AM</option>
                        <option value="11:00">11:00 AM</option>
                        <option value="11:30">11:30 AM</option>
            <%-- ... thêm các khung giờ khác ... --%>
                    </select>
                    <button type="button" onclick="removeTimeSlot(this)">Delete</button>
                `;
                container.appendChild(newSlotDiv);
            }

            function removeTimeSlot(button) {
                var slotDiv = button.parentNode;
                slotDiv.parentNode.removeChild(slotDiv);
            }
        </script>

    </body>
</html>