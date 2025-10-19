<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GP Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #FEFDFB;
        }

        .calendar-day {
            transition: all 0.15s;
            border-radius: 2px;
            font-weight: 400;
            height: 28px;
            color: #374151;
        }

        .calendar-day:not(.other-month):hover {
            background-color: #F3F4F6;
        }

        .calendar-day.today {
            background-color: #DE6143;
            color: white !important;
            font-weight: 500;
        }

        .calendar-day.other-month {
            color: #D1D5DB !important;
            font-weight: 300;
        }
    </style>
</head>

<body class="min-h-screen flex flex-col">
<jsp:include page="header.jsp"/>
<% String flashMessage = (String) session.getAttribute("flashMessage");
    if (flashMessage != null) {
        session.removeAttribute("flashMessage"); %>
<div class="mb-4 p-3 rounded-md text-sm"
     style="background-color: #D1FAE5; border: 1px solid #10B981; color: #065F46; border-radius: 4px;">
    <div class="flex items-center">
        <svg class="w-4 h-4 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd"
                  d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                  clip-rule="evenodd"/>
        </svg>
        <span>
                  <%= flashMessage %>
                </span>
    </div>
</div>
<% } %>
<main class="flex-1 overflow-auto py-6 px-6">
    <div class="max-w-[1400px] mx-auto flex flex-col gap-6 md:flex-row">
        <!-- Left column: Calendar + Form -->
        <div class="flex-shrink-0 w-full md:w-[420px] bg-white border border-gray-300 rounded p-6 flex flex-col gap-4">
            <!-- Calendar Header -->
            <div class="flex items-center justify-between">
                <h2 class="text-sm font-semibold text-gray-800">Calendar</h2>
                <span id="calendarMonthYear" class="text-xs text-gray-500"></span>
            </div>

            <!-- Calendar Controls -->
            <div class="flex items-center justify-between mb-3">
                <div class="flex items-center gap-2">
                    <button id="prevCal" class="p-1 hover:bg-gray-100 transition-all rounded">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M15 19l-7-7 7-7"></path>
                        </svg>
                    </button>
                    <button id="nextCal" class="p-1 hover:bg-gray-100 transition-all rounded">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M9 5l7 7-7 7"></path>
                        </svg>
                    </button>
                </div>
            </div>

            <!-- Calendar Grid -->
            <div id="gpCalendarGrid" class="grid grid-cols-7 grid-rows-6 gap-1.5 mb-4"></div>

            <!-- Add Time Slot Form -->
            <div class="border-t border-gray-100 pt-4">
                <h3 class="text-xs font-semibold text-gray-800 mb-3">Add Time Slot</h3>
                <form id="timeSlotForm" class="space-y-3" method="POST"
                      action="${pageContext.request.contextPath}/gp/dashboard">
                    <div>
                        <label class="block text-[11px] text-gray-600 mb-1">Start Time</label>
                        <input type="datetime-local" name="startTime" id="startTime"
                               class="w-full text-sm border border-gray-300 rounded px-3 py-2 focus:outline-none focus:border-gray-400">
                    </div>
                    <div>
                        <label class="block text-[11px] text-gray-600 mb-1">End Time</label>
                        <input type="datetime-local" name="endTime" id="endTime"
                               class="w-full text-sm border border-gray-300 rounded px-3 py-2 focus:outline-none focus:border-gray-400">
                    </div>
                    <div>
                        <label class="block text-[11px] text-gray-600 mb-1">Status</label>
                        <select name="status" id="slotStatus"
                                class="w-full text-sm border border-gray-300 rounded px-3 py-2 focus:outline-none focus:border-gray-400">
                            <option value="AVAILABLE">AVAILABLE</option>
                            <option value="BOOKED">BOOKED</option>
                            <option value="CANCELLED">CANCELLED</option>
                        </select>
                    </div>
                    <div class="flex justify-end">
                        <button type="submit" id="addTimeSlotBtn"
                                class="bg-[#DE6143] text-white text-sm font-medium px-3 py-2 rounded hover:bg-[#c6543b] transition-all">
                            Add Slot
                        </button>
                    </div>
                    <p id="timeSlotMsg" class="text-[11px] text-gray-500 mt-1"></p>
                </form>
            </div>
        </div>

        <!-- Right column: Today's Queue -->
        <div class="flex-1 bg-white border border-gray-300 rounded flex flex-col overflow-hidden">
            <div class="px-4 py-3 border-b border-gray-200 flex-shrink-0 flex justify-between items-center">
                <h2 class="text-sm font-semibold text-gray-800">Today's Queue</h2>
                <span class="text-[10px] text-gray-500">3 patients</span>
            </div>
            <div class="flex-1 overflow-y-auto p-4">
                <div class="space-y-2">
                    <!-- Queue items -->
                    <%-- Example queue items --%>
                    <c:forEach var="i" begin="1" end="3">
                        <div class="grid grid-cols-12 gap-2 px-3 py-2.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer rounded">
                            <div class="col-span-1 flex items-center justify-center">
                                <div class="w-7 h-7 rounded-full bg-red-100 text-red-600 flex items-center justify-center text-[10px] font-semibold"></div>
                            </div>
                            <div class="col-span-4 flex items-center">
                                <div class="min-w-0">
                                    <p class="text-xs font-semibold text-gray-800 truncate">Patient</p>
                                    <p class="text-[10px] text-gray-500 truncate">ID: PT-2024-00</p>
                                </div>
                            </div>
                            <div class="col-span-3 flex items-center">
                                <div class="min-w-0">
                                    <p class="text-[10px] text-gray-600 truncate">Dr. John Doe</p>
                                    <p class="text-[9px] text-gray-500 truncate">General Practitioner</p>
                                </div>
                            </div>
                            <div class="col-span-2 flex items-center justify-center">
                                <span class="px-2 py-0.5 text-[9px] font-medium text-red-700 bg-red-100 border border-red-200 rounded">URGENT</span>
                            </div>
                            <div class="col-span-2 flex items-center justify-end">
                                <span class="text-[10px] text-gray-600">09:30 AM</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    let gpCurrentDate = new Date();

    function renderGpCalendar() {
        const year = gpCurrentDate.getFullYear();
        const month = gpCurrentDate.getMonth();
        const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        document.getElementById('calendarMonthYear').textContent = monthNames[month] + ' ' + year;

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const prevMonthDays = new Date(year, month, 0).getDate();
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        const calendarGrid = document.getElementById('gpCalendarGrid');
        calendarGrid.innerHTML = '';
        let cellCount = 0;
        const totalCells = 42;
        const cellsHTML = [];

        for (let i = firstDay - 1; i >= 0; i--) {
            const day = prevMonthDays - i;
            cellsHTML.push('<div class="calendar-day other-month text-center flex items-center justify-center text-[11px] cursor-pointer">' + day + '</div>');
            cellCount++;
        }

        for (let day = 1; day <= daysInMonth; day++) {
            const checkDate = new Date(year, month, day);
            checkDate.setHours(0, 0, 0, 0);
            const todayClass = checkDate.getTime() === today.getTime() ? 'today' : '';
            cellsHTML.push('<div class="calendar-day ' + todayClass + ' text-center flex items-center justify-center text-[11px] cursor-pointer font-normal">' + day + '</div>');
            cellCount++;
        }

        let nextMonthDay = 1;
        while (cellCount < totalCells) {
            cellsHTML.push('<div class="calendar-day other-month text-center flex items-center justify-center text-[11px] cursor-pointer">' + nextMonthDay + '</div>');
            nextMonthDay++;
            cellCount++;
        }

        calendarGrid.innerHTML = cellsHTML.join('');
        const opt = {year: 'numeric', month: 'short', day: 'numeric'};
    }

    document.getElementById('prevCal').addEventListener('click', () => {
        gpCurrentDate.setMonth(gpCurrentDate.getMonth() - 1);
        renderGpCalendar();
    });
    document.getElementById('nextCal').addEventListener('click', () => {
        gpCurrentDate.setMonth(gpCurrentDate.getMonth() + 1);
        renderGpCalendar();
    });
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', renderGpCalendar);
    } else {
        renderGpCalendar();
    }

    document.getElementById('addTimeSlotBtn').addEventListener('click', function () {
        const start = document.getElementById('startTime').value;
        const end = document.getElementById('endTime').value;
        const status = document.getElementById('slotStatus').value;
        const doctor = document.getElementById('doctor').value.trim();
        const msgEl = document.getElementById('timeSlotMsg');
        if (!start || !end) {
            msgEl.textContent = 'Start and End time are required.';
            return;
        }
        if (new Date(start) >= new Date(end)) {
            msgEl.textContent = 'End time must be after start time.';
            return;
        }
        if (!doctor) {
            msgEl.textContent = 'Doctor is required.';
            return;
        }
        msgEl.textContent = 'Time slot (local-only) added: ' + new Date(start).toLocaleString() + ' → ' + new Date(end).toLocaleString() + ' (' + status + ') for ' + doctor + '.';
        document.getElementById('startTime').value = '';
        document.getElementById('endTime').value = '';
        document.getElementById('doctor').value = '';
        document.getElementById('slotStatus').value = 'AVAILABLE';
    });
</script>
</body>
</html>
