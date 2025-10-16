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
                    <!-- Left Side: Queue Section (Full Height) -->
                    <div class="w-[800px] bg-white border border-gray-300 flex flex-col" style="border-radius: 2px;">
                        <!-- Queue Header -->
                        <div class="px-4 py-3 border-b border-gray-200 flex-shrink-0">
                            <div class="flex items-center justify-between">
                                <h2 class="text-sm font-semibold text-gray-800">Today's Queue</h2>
                                <span class="text-[10px] text-gray-500">6 patients</span>
                            </div>
                        </div>

                        <!-- Queue Content -->
                        <div class="flex-1 flex flex-col overflow-hidden">
                            <!-- Queue Items Container -->
                            <div class="flex-1 overflow-y-auto px-4 py-3">
                                <div class="space-y-2">
                                    <!-- Queue Item 1 - High Priority -->
                                    <div class="grid grid-cols-12 gap-2 px-3 py-2.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                        style="border-radius: 2px;">
                                        <div class="col-span-1 flex items-center justify-center">
                                            <div
                                                class="w-7 h-7 rounded-full bg-red-100 text-red-600 flex items-center justify-center text-[10px] font-semibold">
                                                1
                                            </div>
                                        </div>
                                        <div class="col-span-4 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-xs font-semibold text-gray-800 truncate">Sarah Johnson
                                                </p>
                                                <p class="text-[10px] text-gray-500 truncate">ID: PT-2024-001</p>
                                            </div>
                                        </div>
                                        <div class="col-span-3 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-[10px] text-gray-600 truncate">Dr. James Wilson</p>
                                                <p class="text-[9px] text-gray-500 truncate">General Practitioner</p>
                                            </div>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-center">
                                            <span
                                                class="px-2 py-0.5 text-[9px] font-medium text-red-700 bg-red-100 border border-red-200"
                                                style="border-radius: 2px;">
                                                URGENT
                                            </span>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-end">
                                            <span class="text-[10px] text-gray-600">09:30 AM</span>
                                        </div>
                                    </div>

                                    <!-- Queue Item 2 - Medium Priority -->
                                    <div class="grid grid-cols-12 gap-2 px-3 py-2.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                        style="border-radius: 2px;">
                                        <div class="col-span-1 flex items-center justify-center">
                                            <div
                                                class="w-7 h-7 rounded-full bg-orange-100 text-orange-600 flex items-center justify-center text-[10px] font-semibold">
                                                2
                                            </div>
                                        </div>
                                        <div class="col-span-4 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-xs font-semibold text-gray-800 truncate">Michael Chen</p>
                                                <p class="text-[10px] text-gray-500 truncate">ID: PT-2024-002</p>
                                            </div>
                                        </div>
                                        <div class="col-span-3 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-[10px] text-gray-600 truncate">Dr. Sarah Chen</p>
                                                <p class="text-[9px] text-gray-500 truncate">Cardiologist</p>
                                            </div>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-center">
                                            <span
                                                class="px-2 py-0.5 text-[9px] font-medium text-orange-700 bg-orange-100 border border-orange-200"
                                                style="border-radius: 2px;">
                                                HIGH
                                            </span>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-end">
                                            <span class="text-[10px] text-gray-600">10:00 AM</span>
                                        </div>
                                    </div>

                                    <!-- Queue Item 3 - Normal Priority -->
                                    <div class="grid grid-cols-12 gap-2 px-3 py-2.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                        style="border-radius: 2px;">
                                        <div class="col-span-1 flex items-center justify-center">
                                            <div
                                                class="w-7 h-7 rounded-full bg-gray-100 text-gray-600 flex items-center justify-center text-[10px] font-semibold">
                                                3
                                            </div>
                                        </div>
                                        <div class="col-span-4 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-xs font-semibold text-gray-800 truncate">Emma Williams
                                                </p>
                                                <p class="text-[10px] text-gray-500 truncate">ID: PT-2024-003</p>
                                            </div>
                                        </div>
                                        <div class="col-span-3 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-[10px] text-gray-600 truncate">Dr. Michael Roberts</p>
                                                <p class="text-[9px] text-gray-500 truncate">General Practitioner</p>
                                            </div>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-center">
                                            <span
                                                class="px-2 py-0.5 text-[9px] font-medium text-gray-700 bg-gray-100 border border-gray-200"
                                                style="border-radius: 2px;">
                                                NORMAL
                                            </span>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-end">
                                            <span class="text-[10px] text-gray-600">10:30 AM</span>
                                        </div>
                                    </div>

                                    <!-- Queue Item 4 -->
                                    <div class="grid grid-cols-12 gap-2 px-3 py-2.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                        style="border-radius: 2px;">
                                        <div class="col-span-1 flex items-center justify-center">
                                            <div
                                                class="w-7 h-7 rounded-full bg-gray-100 text-gray-600 flex items-center justify-center text-[10px] font-semibold">
                                                4
                                            </div>
                                        </div>
                                        <div class="col-span-4 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-xs font-semibold text-gray-800 truncate">James Anderson
                                                </p>
                                                <p class="text-[10px] text-gray-500 truncate">ID: PT-2024-004</p>
                                            </div>
                                        </div>
                                        <div class="col-span-3 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-[10px] text-gray-600 truncate">Dr. Emily Thompson</p>
                                                <p class="text-[9px] text-gray-500 truncate">Neurologist</p>
                                            </div>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-center">
                                            <span
                                                class="px-2 py-0.5 text-[9px] font-medium text-gray-700 bg-gray-100 border border-gray-200"
                                                style="border-radius: 2px;">
                                                NORMAL
                                            </span>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-end">
                                            <span class="text-[10px] text-gray-600">11:00 AM</span>
                                        </div>
                                    </div>

                                    <!-- Queue Item 5 -->
                                    <div class="grid grid-cols-12 gap-2 px-3 py-2.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                        style="border-radius: 2px;">
                                        <div class="col-span-1 flex items-center justify-center">
                                            <div
                                                class="w-7 h-7 rounded-full bg-orange-100 text-orange-600 flex items-center justify-center text-[10px] font-semibold">
                                                5
                                            </div>
                                        </div>
                                        <div class="col-span-4 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-xs font-semibold text-gray-800 truncate">Olivia Martinez
                                                </p>
                                                <p class="text-[10px] text-gray-500 truncate">ID: PT-2024-005</p>
                                            </div>
                                        </div>
                                        <div class="col-span-3 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-[10px] text-gray-600 truncate">Dr. David Martinez</p>
                                                <p class="text-[9px] text-gray-500 truncate">General Practitioner</p>
                                            </div>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-center">
                                            <span
                                                class="px-2 py-0.5 text-[9px] font-medium text-orange-700 bg-orange-100 border border-orange-200"
                                                style="border-radius: 2px;">
                                                HIGH
                                            </span>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-end">
                                            <span class="text-[10px] text-gray-600">11:30 AM</span>
                                        </div>
                                    </div>

                                    <!-- Queue Item 6 -->
                                    <div class="grid grid-cols-12 gap-2 px-3 py-2.5 border border-gray-200 hover:bg-gray-50 transition-all cursor-pointer"
                                        style="border-radius: 2px;">
                                        <div class="col-span-1 flex items-center justify-center">
                                            <div
                                                class="w-7 h-7 rounded-full bg-gray-100 text-gray-600 flex items-center justify-center text-[10px] font-semibold">
                                                6
                                            </div>
                                        </div>
                                        <div class="col-span-4 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-xs font-semibold text-gray-800 truncate">William Taylor
                                                </p>
                                                <p class="text-[10px] text-gray-500 truncate">ID: PT-2024-006</p>
                                            </div>
                                        </div>
                                        <div class="col-span-3 flex items-center">
                                            <div class="min-w-0">
                                                <p class="text-[10px] text-gray-600 truncate">Dr. Lisa Anderson</p>
                                                <p class="text-[9px] text-gray-500 truncate">Orthopedist</p>
                                            </div>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-center">
                                            <span
                                                class="px-2 py-0.5 text-[9px] font-medium text-gray-700 bg-gray-100 border border-gray-200"
                                                style="border-radius: 2px;">
                                                NORMAL
                                            </span>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-end">
                                            <span class="text-[10px] text-gray-600">12:00 PM</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pagination -->
                            <div class="flex-shrink-0 px-4 py-2.5 border-t border-gray-200 bg-gray-50">
                                <div class="flex items-center justify-between">
                                    <div class="text-[10px] text-gray-600">
                                        Showing 1-6 of 6 patients
                                    </div>
                                    <div class="flex gap-1">
                                        <button disabled
                                            class="px-2 py-1 text-[10px] font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                                            style="border-radius: 2px;">
                                            Previous
                                        </button>
                                        <button disabled
                                            class="px-2 py-1 text-[10px] font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                                            style="border-radius: 2px;">
                                            Next
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Side: Stats Grid & Calendar -->
                    <div class="flex-1 flex flex-col gap-4">
                        <!-- Stats Grid (2x2 Grid) -->
                        <div class="grid grid-cols-2 gap-3">
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex flex-col justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div class="flex items-start justify-between mb-2">
                                    <p class="text-2xl font-semibold text-gray-800 leading-none">24</p>
                                    <svg class="w-4 h-4 text-gray-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                    </svg>
                                </div>
                                <p class="text-[10px] text-gray-600 font-normal">Total Patients</p>
                            </div>
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex flex-col justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div class="flex items-start justify-between mb-2">
                                    <p class="text-2xl font-semibold text-gray-800 leading-none">8</p>
                                    <svg class="w-4 h-4 text-gray-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                    </svg>
                                </div>
                                <p class="text-[10px] text-gray-600 font-normal">In Queue</p>
                            </div>
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex flex-col justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div class="flex items-start justify-between mb-2">
                                    <p class="text-2xl font-semibold text-gray-800 leading-none">12</p>
                                    <svg class="w-4 h-4 text-gray-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                    </svg>
                                </div>
                                <p class="text-[10px] text-gray-600 font-normal">Appointments</p>
                            </div>
                            <div class="bg-gray-50 hover:bg-gray-100 border border-gray-300 px-4 py-3 flex flex-col justify-between transition-colors cursor-pointer"
                                style="border-radius: 2px;">
                                <div class="flex items-start justify-between mb-2">
                                    <p class="text-2xl font-semibold text-[#DE6143] leading-none">3</p>
                                    <svg class="w-4 h-4 text-[#DE6143]" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                    </svg>
                                </div>
                                <p class="text-[10px] text-gray-600 font-normal">Urgent Cases</p>
                            </div>
                        </div>

                        <!-- Calendar Section -->
                        <div class="flex-1 bg-white border border-gray-300 flex flex-col" style="border-radius: 2px;">
                            <div class="p-4 flex-shrink-0">
                                <div class="flex justify-between items-center mb-3">
                                    <h2 class="text-sm font-semibold text-gray-800">Calendar</h2>
                                    <div class="flex items-center gap-2">
                                        <button id="prevMonth" class="p-1 hover:bg-gray-100 transition-all"
                                            style="border-radius: 2px;">
                                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 19l-7-7 7-7"></path>
                                            </svg>
                                        </button>
                                        <h2 id="monthYear"
                                            class="text-xs font-medium text-gray-800 min-w-[100px] text-center"></h2>
                                        <button id="nextMonth" class="p-1 hover:bg-gray-100 transition-all"
                                            style="border-radius: 2px;">
                                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 5l7 7-7 7"></path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                                <div class="grid grid-cols-7 gap-1.5 mb-2">
                                    <div class="text-center text-[9px] font-medium text-gray-500">Sun</div>
                                    <div class="text-center text-[9px] font-medium text-gray-500">Mon</div>
                                    <div class="text-center text-[9px] font-medium text-gray-500">Tue</div>
                                    <div class="text-center text-[9px] font-medium text-gray-500">Wed</div>
                                    <div class="text-center text-[9px] font-medium text-gray-500">Thu</div>
                                    <div class="text-center text-[9px] font-medium text-gray-500">Fri</div>
                                    <div class="text-center text-[9px] font-medium text-gray-500">Sat</div>
                                </div>
                                <!-- Fixed height calendar grid - always shows 6 rows -->
                                <div id="calendarGrid" class="grid grid-cols-7 grid-rows-6 gap-1.5"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Calendar functionality
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
    </script>
</body>

</html>