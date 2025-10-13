<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <header class="bg-white border-b border-gray-200">
        <div class="max-w-[1400px] mx-auto flex items-center justify-between px-8 py-3">
            <!-- Left: Logo -->
            <div class="flex items-center gap-2 ml-4">
                <img src="${pageContext.request.contextPath}/assets/images/logo_consulting-removebg-preview.png"
                    alt="Logo" class="h-10 w-10 object-contain">
                <span class="text-sm font-semibold text-gray-800" style="font-family: 'Poppins', sans-serif;">Medical
                    Consulting</span>
            </div>

            <!-- Center: Navigation Links -->
            <nav class="flex items-center gap-1">
                <a href="${pageContext.request.contextPath}/dashboard"
                    class="px-4 py-2 text-xs font-medium text-white rounded transition-all"
                    style="background-color: #DE6143; font-family: 'Poppins', sans-serif;">
                    Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/nurse/patients.jsp"
                    class="px-4 py-2 text-xs font-medium text-gray-600 rounded hover:bg-gray-100 transition-all"
                    style="font-family: 'Poppins', sans-serif;">
                    Patients
                </a>
                <a href="${pageContext.request.contextPath}/nurse/queue.jsp"
                    class="px-4 py-2 text-xs font-medium text-gray-600 rounded hover:bg-gray-100 transition-all"
                    style="font-family: 'Poppins', sans-serif;">
                    Queue
                </a>
                <a href="${pageContext.request.contextPath}/nurse/settings.jsp"
                    class="px-4 py-2 text-xs font-medium text-gray-600 rounded hover:bg-gray-100 transition-all"
                    style="font-family: 'Poppins', sans-serif;">
                    Settings
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

                <!-- Profile -->
                <div class="flex items-center gap-2">
                    <img src="${pageContext.request.contextPath}/assets/images/07c4720d19a9e9edad9d0e939eca304a.jpg"
                        alt="Profile" class="w-8 h-8 rounded-full object-cover border border-gray-200">
                    <span class="text-xs font-medium text-gray-700" style="font-family: 'Poppins', sans-serif;">
                        <%= session.getAttribute("userName") %>
                    </span>
                </div>
            </div>
        </div>
    </header>

    <div id="profileMenu"
        class="hidden absolute right-6 top-16 w-48 bg-white rounded shadow-lg border border-gray-200 py-2 z-50">
        <a href="${pageContext.request.contextPath}/nurse/settings.jsp"
            class="flex items-center gap-3 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 transition-all">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            Settings
        </a>
        <hr class="my-2 border-gray-200">
        <a href="${pageContext.request.contextPath}/logout"
            class="flex items-center gap-3 px-4 py-2 text-sm text-red-600 hover:bg-red-50 transition-all">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
            </svg>
            Logout
        </a>
    </div>

    <script>
        const profileMenuBtn = document.getElementById('profileMenuBtn');
        const profileMenu = document.getElementById('profileMenu');

        if (profileMenuBtn) {
            profileMenuBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                profileMenu.classList.toggle('hidden');
            });

            document.addEventListener('click', function () {
                profileMenu.classList.add('hidden');
            });

            profileMenu.addEventListener('click', function (e) {
                e.stopPropagation();
            });
        }
    </script>   