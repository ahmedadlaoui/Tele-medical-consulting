<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String currentPage=request.getRequestURI(); boolean isDashboard=currentPage.contains("/dashboard.jsp") ||
        currentPage.endsWith("/dashboard"); boolean isPatients=currentPage.contains("/patients.jsp") ||
        currentPage.contains("/patients"); boolean isQueue=currentPage.contains("/queue.jsp"); boolean
        isSettings=currentPage.contains("/settings.jsp"); %>
        <header class="bg-white border-b border-gray-200">
            <div class="max-w-[1400px] mx-auto flex items-center justify-between px-8 py-3">
                <!-- Left: Logo -->
                <div class="flex items-center gap-2 ml-4">
                    <img src="${pageContext.request.contextPath}/assets/images/logo_consulting-removebg-preview.png"
                        alt="Logo" class="h-10 w-10 object-contain">
                    <span class="text-sm font-semibold text-gray-800"
                        style="font-family: 'Poppins', sans-serif;">Medical
                        Consulting</span>
                </div>

                <!-- Center: Navigation Links -->
                <nav class="flex items-center gap-1">
                    <a href="${pageContext.request.contextPath}/dashboard"
                        class="px-4 py-2 text-xs font-medium <%= isDashboard ? " text-white"
                        : "text-gray-600 hover:bg-gray-100" %> rounded transition-all"
                        style="<%= isDashboard ? "background-color: #DE6143;" : "" %> font-family: 'Poppins',
                            sans-serif;">
                            Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/nurse/patients"
                        class="px-4 py-2 text-xs font-medium <%= isPatients ? " text-white"
                        : "text-gray-600 hover:bg-gray-100" %> rounded transition-all"
                        style="<%= isPatients ? "background-color: #DE6143;" : "" %> font-family: 'Poppins',
                            sans-serif;">
                            Patients
                    </a>
                </nav>

                <!-- Right: Notification Icon + Profile -->
                <div class="flex items-center gap-4 mr-4">
                    <!-- Notification Icon -->
                    <button class="relative p-2 text-gray-600 hover:bg-gray-100 rounded-full transition-all">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                        </svg>
                        <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                    </button>

                    <!-- Profile with Dropdown -->
                    <div class="relative">
                        <button id="profileMenuBtn"
                            class="flex items-center gap-2 hover:bg-gray-50 rounded px-2 py-1 transition-all"
                            style="border-radius: 2px;">
                            <img src="${pageContext.request.contextPath}/assets/images/07c4720d19a9e9edad9d0e939eca304a.jpg"
                                alt="Profile" class="w-8 h-8 rounded-full object-cover border border-gray-200">
                            <span class="text-xs font-medium text-gray-700" style="font-family: 'Poppins', sans-serif;">
                                <%= session.getAttribute("userName") %>
                            </span>
                            <svg class="w-3 h-3 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M19 9l-7 7-7-7" />
                            </svg>
                        </button>

                        <!-- Dropdown Menu -->
                        <div id="profileMenu"
                            class="hidden absolute right-0 top-11 w-36 bg-white border border-gray-300 py-1 z-50"
                            style="border-radius: 2px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                            <a href="${pageContext.request.contextPath}/logout"
                                class="flex items-center gap-2 px-3 py-2 text-xs font-medium text-gray-700 hover:bg-gray-50 transition-all">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                                </svg>
                                Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <script>
            const profileMenuBtn = document.getElementById('profileMenuBtn');
            const profileMenu = document.getElementById('profileMenu');

            if (profileMenuBtn && profileMenu) {
                profileMenuBtn.addEventListener('click', function (e) {
                    e.stopPropagation();
                    profileMenu.classList.toggle('hidden');
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function () {
                    profileMenu.classList.add('hidden');
                });

                // Prevent closing when clicking inside the menu
                profileMenu.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            }
        </script>