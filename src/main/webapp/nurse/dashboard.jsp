<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nurse Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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

<body class="min-h-screen" style="background-color: #FEFDFB;">
    <div class="flex flex-col h-screen">
        <jsp:include page="header.jsp" />

        <main class="flex-1 overflow-hidden">
            <div class="max-w-[1400px] mx-auto px-8 h-full py-6">
                <div class="flex gap-6 h-full">
                    <!-- Left Side: Calendar + Queue Container -->
                    <div class="w-[480px] bg-white border border-gray-300 flex flex-col" style="border-radius: 2px;">
                        <!-- Calendar Section -->
                        <div class="p-3 border-b border-gray-200 flex-shrink-0">
                            <div class="flex justify-between items-center mb-2">
                                <button id="prevMonth" class="p-1 hover:bg-gray-100 transition-all"
                                    style="border-radius: 2px;">
                                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M15 19l-7-7 7-7"></path>
                                    </svg>
                                </button>
                                <h2 id="monthYear" class="text-xs font-medium text-gray-800"></h2>
                                <button id="nextMonth" class="p-1 hover:bg-gray-100 transition-all"
                                    style="border-radius: 2px;">
                                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M9 5l7 7-7 7"></path>
                                    </svg>
                                </button>
                            </div>
                            <div class="grid grid-cols-7 gap-1 mb-1.5">
                                <div class="text-center text-[9px] font-medium text-gray-500">Sun</div>
                                <div class="text-center text-[9px] font-medium text-gray-500">Mon</div>
                                <div class="text-center text-[9px] font-medium text-gray-500">Tue</div>
                                <div class="text-center text-[9px] font-medium text-gray-500">Wed</div>
                                <div class="text-center text-[9px] font-medium text-gray-500">Thu</div>
                                <div class="text-center text-[9px] font-medium text-gray-500">Fri</div>
                                <div class="text-center text-[9px] font-medium text-gray-500">Sat</div>
                            </div>
                            <!-- Fixed height calendar grid - always shows 6 rows -->
                            <div id="calendarGrid" class="grid grid-cols-7 grid-rows-6 gap-1"></div>
                        </div>

                        <!-- Queue Section -->
                        <div class="flex-1 flex flex-col overflow-hidden">
                            <div class="px-3 py-2.5 border-b border-gray-200 flex-shrink-0">
                                <div class="flex items-center justify-between">
                                    <h3 class="text-xs font-semibold text-gray-800">Today's Queue</h3>
                                    <span class="text-[10px] text-gray-500">12 patients</span>
                                </div>
                            </div>

                            <!-- Queue Content with Pagination -->
                            <div class="flex-1 flex flex-col overflow-hidden">
                                <!-- Queue Items Container - Hardcoded HTML -->
                                <div class="flex-1 overflow-y-auto px-3 py-2">
                                    <div class="space-y-1.5">
                                        <!-- Queue Item 1 -->
                                        <div class="grid grid-cols-12 gap-1.5 px-2 py-1.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                            style="border-radius: 2px;">
                                            <div class="col-span-1 text-[10px] font-medium text-gray-700">1</div>
                                            <div class="col-span-5 text-[10px] font-medium text-gray-800 truncate">John
                                                Smith</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-red-700 bg-red-50 border border-red-200"
                                                    style="border-radius: 2px;">Urgent</span>
                                            </div>
                                            <div class="col-span-2 text-[10px] text-gray-600 truncate">35 min</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-orange-700 bg-orange-50 border border-orange-200"
                                                    style="border-radius: 2px;">Waiting</span>
                                            </div>
                                        </div>
                                        <!-- Queue Item 2 -->
                                        <div class="grid grid-cols-12 gap-1.5 px-2 py-1.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                            style="border-radius: 2px;">
                                            <div class="col-span-1 text-[10px] font-medium text-gray-700">2</div>
                                            <div class="col-span-5 text-[10px] font-medium text-gray-800 truncate">Sarah
                                                Johnson</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-orange-700 bg-orange-50 border border-orange-200"
                                                    style="border-radius: 2px;">High</span>
                                            </div>
                                            <div class="col-span-2 text-[10px] text-gray-600 truncate">20 min</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-orange-700 bg-orange-50 border border-orange-200"
                                                    style="border-radius: 2px;">Waiting</span>
                                            </div>
                                        </div>
                                        <!-- Queue Item 3 -->
                                        <div class="grid grid-cols-12 gap-1.5 px-2 py-1.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                            style="border-radius: 2px;">
                                            <div class="col-span-1 text-[10px] font-medium text-gray-700">3</div>
                                            <div class="col-span-5 text-[10px] font-medium text-gray-800 truncate">
                                                Michael Brown</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-blue-700 bg-blue-50 border border-blue-200"
                                                    style="border-radius: 2px;">Normal</span>
                                            </div>
                                            <div class="col-span-2 text-[10px] text-gray-600 truncate">5 min</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-green-700 bg-green-50 border border-green-200"
                                                    style="border-radius: 2px;">Active</span>
                                            </div>
                                        </div>
                                        <!-- Queue Item 4 -->
                                        <div class="grid grid-cols-12 gap-1.5 px-2 py-1.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                            style="border-radius: 2px;">
                                            <div class="col-span-1 text-[10px] font-medium text-gray-700">4</div>
                                            <div class="col-span-5 text-[10px] font-medium text-gray-800 truncate">Emily
                                                Davis</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-blue-700 bg-blue-50 border border-blue-200"
                                                    style="border-radius: 2px;">Normal</span>
                                            </div>
                                            <div class="col-span-2 text-[10px] text-gray-600 truncate">2 min</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-orange-700 bg-orange-50 border border-orange-200"
                                                    style="border-radius: 2px;">Waiting</span>
                                            </div>
                                        </div>
                                        <!-- Queue Item 5 -->
                                        <div class="grid grid-cols-12 gap-1.5 px-2 py-1.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                            style="border-radius: 2px;">
                                            <div class="col-span-1 text-[10px] font-medium text-gray-700">5</div>
                                            <div class="col-span-5 text-[10px] font-medium text-gray-800 truncate">David
                                                Wilson</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-orange-700 bg-orange-50 border border-orange-200"
                                                    style="border-radius: 2px;">High</span>
                                            </div>
                                            <div class="col-span-2 text-[10px] text-gray-600 truncate">15 min</div>
                                            <div class="col-span-2">
                                                <span
                                                    class="px-1 py-0.5 text-[8px] font-medium text-orange-700 bg-orange-50 border border-orange-200"
                                                    style="border-radius: 2px;">Waiting</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Pagination -->
                                <div class="flex-shrink-0 px-3 py-2 border-t border-gray-200 bg-gray-50">
                                    <div class="flex items-center justify-between">
                                        <div class="text-[10px] text-gray-600">Page 1 of 3</div>
                                        <div class="flex gap-1">
                                            <button disabled
                                                class="px-2 py-1 text-[10px] font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                                                style="border-radius: 2px;">
                                                Previous
                                            </button>
                                            <button
                                                class="px-2 py-1 text-[10px] font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                                                style="border-radius: 2px;">
                                                Next
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Side: Stats Grid & Medical Team -->
                    <div class="flex-1 flex flex-col gap-4">
                        <!-- Stats Grid -->
                        <div class="grid grid-cols-2 auto-rows-min gap-3">
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex items-center justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div>
                                    <p class="text-xl font-semibold text-gray-800 leading-none mb-1">24</p>
                                    <p class="text-[10px] text-gray-600 font-normal">Total Patients</p>
                                </div>
                                <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                        d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                </svg>
                            </div>
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex items-center justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div>
                                    <p class="text-xl font-semibold text-gray-800 leading-none mb-1">8</p>
                                    <p class="text-[10px] text-gray-600 font-normal">In Queue</p>
                                </div>
                                <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                        d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                </svg>
                            </div>
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex items-center justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div>
                                    <p class="text-xl font-semibold text-gray-800 leading-none mb-1">12</p>
                                    <p class="text-[10px] text-gray-600 font-normal">Appointments</p>
                                </div>
                                <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                        d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                </svg>
                            </div>
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex items-center justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div>
                                    <p class="text-xl font-semibold text-[#DE6143] leading-none mb-1">3</p>
                                    <p class="text-[10px] text-gray-600 font-normal">Urgent Cases</p>
                                </div>
                                <svg class="w-5 h-5 text-[#DE6143]" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                        d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                </svg>
                            </div>
                        </div>

                        <!-- Medical Team Section -->
                        <div class="flex-1 flex flex-col bg-white border border-gray-300 overflow-hidden"
                            style="border-radius: 2px;">
                            <!-- Header -->
                            <div class="px-4 py-3 border-b border-gray-200 flex-shrink-0">
                                <h2 class="text-sm font-semibold text-gray-800">Browse Medical Team</h2>
                            </div>

                            <!-- Search and Filters -->
                            <div class="px-4 py-3 border-b border-gray-200 flex-shrink-0">
                                <div class="flex gap-2">
                                    <div class="flex-1 relative">
                                        <input type="text" id="teamSearch" placeholder="Search by name or license..."
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                            style="border-radius: 2px;">
                                        <svg class="absolute right-3 top-2.5 w-4 h-4 text-gray-400" fill="none"
                                            stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                        </svg>
                                    </div>
                                    <button id="filterAll"
                                        class="px-3 py-2 text-xs font-medium bg-gray-800 text-white border border-gray-800 transition-all"
                                        style="border-radius: 2px;">
                                        All
                                    </button>
                                    <button id="filterGP"
                                        class="px-3 py-2 text-xs font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 transition-all"
                                        style="border-radius: 2px;">
                                        General Practitioners
                                    </button>
                                    <button id="filterSpecialist"
                                        class="px-3 py-2 text-xs font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 transition-all"
                                        style="border-radius: 2px;">
                                        Specialists
                                    </button>
                                </div>
                            </div>

                            <!-- Team Cards Container -->
                            <div class="flex-1 overflow-y-auto px-4 py-3">
                                <div id="teamCardsContainer" class="grid grid-cols-2 gap-3"></div>
                            </div>

                            <!-- Pagination -->
                            <div class="flex-shrink-0 px-4 py-2 border-t border-gray-200 bg-gray-50">
                                <div class="flex items-center justify-between">
                                    <div class="text-[10px] text-gray-600">
                                        Page <span id="teamCurrentPage">1</span> of <span id="teamTotalPages">2</span>
                                    </div>
                                    <div class="flex gap-1">
                                        <button id="teamPrevPage"
                                            class="px-2 py-1 text-[10px] font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                                            style="border-radius: 2px;">
                                            Previous
                                        </button>
                                        <button id="teamNextPage"
                                            class="px-2 py-1 text-[10px] font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                                            style="border-radius: 2px;">
                                            Next
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    </main>
    </div>

    <script>
        let currentDate = new Date();

        function renderCalendar() {
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth();

            const monthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
            ];

            document.getElementById('monthYear').textContent = monthNames[month] + ' ' + year;

            const firstDay = new Date(year, month, 1).getDay();
            const daysInMonth = new Date(year, month + 1, 0).getDate();
            const prevMonthDays = new Date(year, month, 0).getDate();
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            const calendarGrid = document.getElementById('calendarGrid');
            calendarGrid.innerHTML = '';

            // Calculate total cells needed (always 42 for 6 rows)
            const totalCells = 42;
            let cellCount = 0;
            const cellsHTML = [];

            // Previous month days
            for (let i = firstDay - 1; i >= 0; i--) {
                const day = prevMonthDays - i;
                cellsHTML.push('<div class="calendar-day other-month text-center flex items-center justify-center text-[11px] cursor-pointer">' + day + '</div>');
                cellCount++;
            }

            // Current month days
            for (let day = 1; day <= daysInMonth; day++) {
                const currentDateCheck = new Date(year, month, day);
                currentDateCheck.setHours(0, 0, 0, 0);

                const isToday = currentDateCheck.getTime() === today.getTime();
                const todayClass = isToday ? 'today' : '';

                cellsHTML.push('<div class="calendar-day ' + todayClass + ' text-center flex items-center justify-center text-[11px] cursor-pointer font-normal">' + day + '</div>');
                cellCount++;
            }

            let nextMonthDay = 1;
            while (cellCount < totalCells) {
                cellsHTML.push('<div class="calendar-day other-month text-center flex items-center justify-center text-[11px] cursor-pointer">' + nextMonthDay + '</div>');
                nextMonthDay++;
                cellCount++;
            }

            // Set all HTML at once instead of using +=
            calendarGrid.innerHTML = cellsHTML.join('');
        }

        document.getElementById('prevMonth').addEventListener('click', function () {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar();
        });

        document.getElementById('nextMonth').addEventListener('click', function () {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar();
        });

        // Initialize calendar when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', renderCalendar);
        } else {
            renderCalendar();
        }

        // Medical Team Data
        const contextPath = '<%= request.getContextPath() %>';
        const defaultImage = contextPath + '/assets/images/07c4720d19a9e9edad9d0e939eca304a.jpg';

        const medicalTeamData = [
            { id: 1, name: 'Dr. James Wilson', role: 'GP', specialty: null, license: 'GP-45782', image: defaultImage },
            { id: 2, name: 'Dr. Sarah Chen', role: 'Specialist', specialty: 'Cardiology', license: 'SP-89234', image: defaultImage },
            { id: 3, name: 'Dr. Michael Roberts', role: 'GP', specialty: null, license: 'GP-23451', image: defaultImage },
            { id: 4, name: 'Dr. Emily Thompson', role: 'Specialist', specialty: 'Neurology', license: 'SP-67821', image: defaultImage },
            { id: 5, name: 'Dr. David Martinez', role: 'GP', specialty: null, license: 'GP-78234', image: defaultImage },
            { id: 6, name: 'Dr. Lisa Anderson', role: 'Specialist', specialty: 'Orthopedics', license: 'SP-12398', image: defaultImage },
            { id: 7, name: 'Dr. Robert Taylor', role: 'GP', specialty: null, license: 'GP-90123', image: defaultImage },
            { id: 8, name: 'Dr. Jennifer Lee', role: 'Specialist', specialty: 'Dermatology', license: 'SP-45612', image: defaultImage },
            { id: 9, name: 'Dr. William Brown', role: 'GP', specialty: null, license: 'GP-34567', image: defaultImage },
            { id: 10, name: 'Dr. Maria Garcia', role: 'Specialist', specialty: 'Pediatrics', license: 'SP-78945', image: defaultImage }
        ];

        let currentTeamPage = 1;
        let currentFilter = 'all';
        const teamItemsPerPage = 8;

        function getFilteredTeamData() {
            if (currentFilter === 'all') return medicalTeamData;
            if (currentFilter === 'gp') return medicalTeamData.filter(m => m.role === 'GP');
            if (currentFilter === 'specialist') return medicalTeamData.filter(m => m.role === 'Specialist');
            return medicalTeamData;
        }

        function renderTeam() {
            const filteredData = getFilteredTeamData();
            const startIndex = (currentTeamPage - 1) * teamItemsPerPage;
            const endIndex = startIndex + teamItemsPerPage;
            const pageData = filteredData.slice(startIndex, endIndex);
            const totalPages = Math.ceil(filteredData.length / teamItemsPerPage);

            const container = document.getElementById('teamCardsContainer');
            const cardsHTML = [];

            pageData.forEach(function (member) {
                const specialtyHtml = member.specialty
                    ? '<p class="text-[9px] text-gray-500 mb-0.5">' + member.specialty + '</p>'
                    : '';

                cardsHTML.push('<div class="bg-gray-50 border border-gray-300 p-2.5 hover:bg-gray-100 transition-all cursor-pointer" style="border-radius: 2px;">' +
                    '<div class="flex gap-2.5">' +
                    '<img src="' + member.image + '" alt="' + member.name + '" class="w-11 h-11 rounded-full object-cover border-2 border-gray-200" onerror="this.src=\'' + defaultImage + '\'">' +
                    '<div class="flex-1 min-w-0">' +
                    '<h3 class="text-[11px] font-semibold text-gray-800 truncate mb-0.5">' + member.name + '</h3>' +
                    '<p class="text-[9px] font-medium text-gray-600 mb-0.5">' + member.role + '</p>' +
                    specialtyHtml +
                    '<p class="text-[8px] text-gray-500">Lic: ' + member.license + '</p>' +
                    '</div>' +
                    '</div>' +
                    '</div>');
            });

            container.innerHTML = cardsHTML.join('');

            document.getElementById('teamCurrentPage').textContent = currentTeamPage;
            document.getElementById('teamTotalPages').textContent = totalPages || 1;

            document.getElementById('teamPrevPage').disabled = currentTeamPage === 1;
            document.getElementById('teamNextPage').disabled = currentTeamPage === totalPages || totalPages === 0;
        }

        document.getElementById('filterAll').addEventListener('click', function () {
            currentFilter = 'all';
            currentTeamPage = 1;
            updateFilterButtons('filterAll');
            renderTeam();
        });

        document.getElementById('filterGP').addEventListener('click', function () {
            currentFilter = 'gp';
            currentTeamPage = 1;
            updateFilterButtons('filterGP');
            renderTeam();
        });

        document.getElementById('filterSpecialist').addEventListener('click', function () {
            currentFilter = 'specialist';
            currentTeamPage = 1;
            updateFilterButtons('filterSpecialist');
            renderTeam();
        });

        function updateFilterButtons(activeId) {
            ['filterAll', 'filterGP', 'filterSpecialist'].forEach(id => {
                const btn = document.getElementById(id);
                if (id === activeId) {
                    btn.className = 'px-3 py-2 text-xs font-medium bg-gray-800 text-white border border-gray-800 transition-all';
                } else {
                    btn.className = 'px-3 py-2 text-xs font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 transition-all';
                }
            });
        }

        document.getElementById('teamPrevPage').addEventListener('click', function () {
            if (currentTeamPage > 1) {
                currentTeamPage--;
                renderTeam();
            }
        });

        document.getElementById('teamNextPage').addEventListener('click', function () {
            const filteredData = getFilteredTeamData();
            const totalPages = Math.ceil(filteredData.length / teamItemsPerPage);
            if (currentTeamPage < totalPages) {
                currentTeamPage++;
                renderTeam();
            }
        });

        // Initialize team display when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', renderTeam);
        } else {
            renderTeam();
        }
    </script>
</body>

</html>