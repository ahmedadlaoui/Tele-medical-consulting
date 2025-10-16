<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Patients - Nurse Dashboard</title>
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

                    /* Force 2-column grid layout - NEVER change to 1 column */
                    .fixed-grid-2 {
                        display: grid !important;
                        grid-template-columns: repeat(2, 1fr) !important;
                        gap: 1rem !important;
                        min-width: 0 !important;
                        max-width: 100% !important;
                    }

                    /* Ensure grid items don't break the layout */
                    .fixed-grid-2>* {
                        min-width: 0 !important;
                        max-width: 100% !important;
                        width: 100% !important;
                        box-sizing: border-box !important;
                    }

                    /* Force all inputs to stay within bounds */
                    .fixed-grid-2 input,
                    .fixed-grid-2 select,
                    .fixed-grid-2 textarea {
                        max-width: 100% !important;
                        width: 100% !important;
                        box-sizing: border-box !important;
                    }

                    /* Fix scrollable container */
                    .modal-body-scroll {
                        max-height: calc(90vh - 220px);
                        overflow-y: auto !important;
                        overflow-x: hidden !important;
                        width: 100% !important;
                    }

                    /* Prevent ANY responsive breakpoints from affecting grid */
                    @media (max-width: 9999px) {
                        .fixed-grid-2 {
                            grid-template-columns: repeat(2, 1fr) !important;
                        }
                    }

                    /* Prevent layout shift on autofill */
                    input:-webkit-autofill,
                    input:-webkit-autofill:hover,
                    input:-webkit-autofill:focus,
                    input:-webkit-autofill:active {
                        -webkit-box-shadow: 0 0 0px 1000px white inset !important;
                        box-shadow: 0 0 0px 1000px white inset !important;
                        transition: background-color 5000s ease-in-out 0s !important;
                    }

                    /* Override any inline styles that fake fillers might add */
                    #step1 *[style*="display"],
                    #step2 *[style*="display"] {
                        display: initial !important;
                    }

                    #step1 .fixed-grid-2[style],
                    #step2 .fixed-grid-2[style] {
                        display: grid !important;
                        grid-template-columns: repeat(2, 1fr) !important;
                    }
                </style>
            </head>

            <body class="min-h-screen" style="background-color: #FEFDFB;">
                <div class="flex flex-col h-screen">
                    <jsp:include page="header.jsp" />

                    <main class="flex-1 overflow-y-auto">
                        <div class="max-w-[1400px] mx-auto px-8 py-6">

                            <!-- Page Title with Messages -->
                            <div class="mb-4 flex items-center justify-between gap-4">
                                <div>
                                    <h1 class="text-2xl font-semibold text-gray-800">Patients Management</h1>
                                    <p class="text-xs text-gray-600 mt-1">View and manage all registered patients</p>
                                </div>

                                <!-- Success/Error Messages -->
                                <div class="flex-shrink-0 max-w-md">
                                    <c:if test="${param.success == 'registered'}">
                                        <div class="px-4 py-2.5 bg-green-50 border border-green-200 text-green-800 text-xs flex items-center gap-2"
                                            style="border-radius: 2px;">
                                            <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M5 13l4 4L19 7" />
                                            </svg>
                                            <span>Patient registered successfully!</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${param.error != null}">
                                        <div class="px-4 py-2.5 bg-red-50 border border-red-200 text-red-800 text-xs flex items-center gap-2"
                                            style="border-radius: 2px;">
                                            <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                            <span>
                                                <c:choose>
                                                    <c:when test="${param.error == 'registration_failed'}">Failed to
                                                        register
                                                        patient. Please try again.</c:when>
                                                    <c:when test="${param.error == 'invalid_input'}">Invalid input data.
                                                        Please
                                                        check all fields.</c:when>
                                                    <c:when test="${param.error == 'exception'}">System error occurred.
                                                        Please
                                                        contact administrator.</c:when>
                                                    <c:otherwise>An error occurred. Please try again.</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Main Content Card -->
                            <div class="flex flex-col bg-white border border-gray-300" style="border-radius: 2px;">

                                <!-- Header with Title -->
                                <div class="px-4 py-3 border-b border-gray-200 flex-shrink-0">
                                    <div class="flex items-center justify-between">
                                        <h2 class="text-sm font-semibold text-gray-800">All Patients</h2>
                                        <button id="registerPatientBtn"
                                            class="px-4 py-2 text-xs font-medium text-white border transition-all hover:opacity-90"
                                            style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                            <div class="flex items-center gap-2">
                                                <svg class="w-4 h-4" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M12 4v16m8-8H4" />
                                                </svg>
                                                Register Patient
                                            </div>
                                        </button>
                                    </div>
                                </div>

                                <!-- Search and Filters -->
                                <div class="px-4 py-3 border-b border-gray-200 flex-shrink-0">
                                    <form action="${pageContext.request.contextPath}/nurse/patients" method="get"
                                        class="flex gap-2">
                                        <div class="flex-1 relative">
                                            <input type="text" name="search" id="patientSearch" value="${param.search}"
                                                placeholder="Search by name, CIN, or phone..."
                                                class="w-full px-3 py-2 pr-10 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                                style="border-radius: 2px;">
                                            <button type="submit"
                                                class="absolute right-3 top-2.5 text-gray-400 hover:text-gray-600 transition-colors">
                                                <svg class="w-4 h-4" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                                </svg>
                                            </button>
                                        </div>
                                        <c:if test="${not empty param.search}">
                                            <a href="${pageContext.request.contextPath}/nurse/patients"
                                                class="px-4 py-2 text-xs font-medium text-gray-700 border border-gray-300 hover:bg-gray-100 transition-all"
                                                style="border-radius: 2px;">
                                                Clear
                                            </a>
                                        </c:if>
                                    </form>
                                </div>

                                <!-- Patients Cards Container - Fixed min-height to prevent collapse -->
                                <div class="px-4 py-4" style="min-height: 450px;">
                                    <c:choose>
                                        <c:when test="${empty patients}">
                                            <!-- No Patients Message -->
                                            <div
                                                class="flex flex-col items-center justify-center h-full text-center py-12">
                                                <svg class="w-16 h-16 text-gray-300 mb-3" fill="none"
                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                                </svg>
                                                <c:choose>
                                                    <c:when test="${not empty param.search}">
                                                        <p class="text-sm text-gray-500 font-medium">No patients found
                                                        </p>
                                                        <p class="text-xs text-gray-400 mt-1">No results matching
                                                            "${param.search}"</p>
                                                        <a href="${pageContext.request.contextPath}/nurse/patients"
                                                            class="mt-4 px-4 py-2 text-xs font-medium text-white border transition-all hover:opacity-90"
                                                            style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                                            View All Patients
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="text-sm text-gray-500 font-medium">No patients
                                                            registered yet</p>
                                                        <p class="text-xs text-gray-400 mt-1">Click "Register Patient"
                                                            to add your first patient</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Patient Cards Grid -->
                                            <div
                                                class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-3">
                                                <c:forEach var="patient" items="${patients}">
                                                    <a href="${pageContext.request.contextPath}/nurse/patient-detail?id=${patient.id}"
                                                        class="bg-gray-50 border border-gray-300 p-3 hover:bg-gray-100 hover:shadow-sm transition-all cursor-pointer block"
                                                        style="border-radius: 2px; text-decoration: none; color: inherit;">
                                                        <div class="flex gap-3">
                                                            <c:choose>
                                                                <c:when test="${not empty patient.profilePicture}">
                                                                    <img src="${pageContext.request.contextPath}${patient.profilePicture}"
                                                                        alt="${patient.firstName} ${patient.lastName}"
                                                                        class="w-12 h-12 rounded-full object-cover border-2 border-gray-200 flex-shrink-0">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div
                                                                        class="w-12 h-12 rounded-full bg-gray-300 border-2 border-gray-200 flex items-center justify-center flex-shrink-0">
                                                                        <span
                                                                            class="text-gray-600 font-semibold text-sm">
                                                                            ${fn:substring(patient.firstName, 0,
                                                                            1)}${fn:substring(patient.lastName, 0, 1)}
                                                                        </span>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <div class="flex-1 min-w-0">
                                                                <h3
                                                                    class="text-xs font-semibold text-gray-800 truncate mb-1">
                                                                    ${patient.firstName} ${patient.lastName}
                                                                </h3>
                                                                <div class="space-y-0.5">
                                                                    <p class="text-[10px] text-gray-600">
                                                                        <span class="font-medium">CIN:</span>
                                                                        ${patient.cin}
                                                                    </p>
                                                                    <c:if test="${not empty patient.phoneNumber}">
                                                                        <p class="text-[10px] text-gray-600">
                                                                            <span class="font-medium">Phone:</span>
                                                                            ${patient.phoneNumber}
                                                                        </p>
                                                                    </c:if>
                                                                    <c:if test="${not empty patient.dateOfBirth}">
                                                                        <p class="text-[10px] text-gray-600">
                                                                            <span class="font-medium">DOB:</span>
                                                                            ${patient.dateOfBirth}
                                                                        </p>
                                                                    </c:if>
                                                                    <p class="text-[10px] text-gray-600">
                                                                        <span class="font-medium">Gender:</span>
                                                                        ${patient.gender}
                                                                    </p>
                                                                    <c:if test="${not empty patient.registrationDate}">
                                                                        <p class="text-[9px] text-gray-500 mt-1">
                                                                            Registered:
                                                                            ${fn:substring(patient.registrationDate, 0,
                                                                            10)}
                                                                        </p>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Pagination -->
                                <c:set var="searchQuery"
                                    value="${not empty param.search ? '&search='.concat(param.search) : ''}" />
                                <div class="flex-shrink-0 px-4 py-2.5 border-t border-gray-200 bg-white">
                                    <div class="flex items-center justify-between">
                                        <!-- Pagination Info (Left) -->
                                        <div class="text-xs text-gray-600">
                                            <c:if test="${totalPages > 0}">
                                                <span class="font-medium text-gray-700">Page ${currentPage} of
                                                    ${totalPages}</span>
                                                <span class="mx-2 text-gray-400">•</span>
                                                <span class="text-gray-500">Total: ${totalPatients} patients</span>
                                            </c:if>
                                        </div>

                                        <!-- Pagination Controls (Right) -->
                                        <c:if test="${totalPages > 1}">
                                            <div class="flex items-center gap-1">
                                                <!-- Previous Button -->
                                                <c:choose>
                                                    <c:when test="${currentPage > 1}">
                                                        <a href="${pageContext.request.contextPath}/nurse/patients?page=${currentPage - 1}${searchQuery}"
                                                            class="px-2 py-1 text-xs border border-gray-300 bg-white hover:bg-gray-100 transition-colors"
                                                            style="border-radius: 2px;">
                                                            <svg class="w-3 h-3" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2" d="M15 19l-7-7 7-7" />
                                                            </svg>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="px-2 py-1 text-xs border border-gray-200 bg-gray-100 text-gray-400 cursor-not-allowed"
                                                            style="border-radius: 2px;">
                                                            <svg class="w-3 h-3" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2" d="M15 19l-7-7 7-7" />
                                                            </svg>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>

                                                <!-- Page Numbers -->
                                                <c:choose>
                                                    <c:when test="${totalPages <= 7}">
                                                        <!-- Show all pages if 7 or less -->
                                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                                            <c:choose>
                                                                <c:when test="${i == currentPage}">
                                                                    <span
                                                                        class="px-2.5 py-1 text-xs font-semibold text-white border"
                                                                        style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                                                        ${i}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="${pageContext.request.contextPath}/nurse/patients?page=${i}${searchQuery}"
                                                                        class="px-2.5 py-1 text-xs border border-gray-300 bg-white hover:bg-gray-100 transition-colors"
                                                                        style="border-radius: 2px;">
                                                                        ${i}
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Show truncated pagination for more than 7 pages -->

                                                        <!-- Always show first page -->
                                                        <c:choose>
                                                            <c:when test="${currentPage == 1}">
                                                                <span
                                                                    class="px-2.5 py-1 text-xs font-semibold text-white border"
                                                                    style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                                                    1
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${pageContext.request.contextPath}/nurse/patients?page=1${searchQuery}"
                                                                    class="px-2.5 py-1 text-xs border border-gray-300 bg-white hover:bg-gray-100 transition-colors"
                                                                    style="border-radius: 2px;">
                                                                    1
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <!-- Show ellipsis if needed -->
                                                        <c:if test="${currentPage > 3}">
                                                            <span class="px-2 text-xs text-gray-500">...</span>
                                                        </c:if>

                                                        <!-- Show pages around current page -->
                                                        <c:forEach var="i"
                                                            begin="${currentPage - 1 > 1 ? currentPage - 1 : 2}"
                                                            end="${currentPage + 1 < totalPages ? currentPage + 1 : totalPages - 1}">
                                                            <c:if test="${i > 1 && i < totalPages}">
                                                                <c:choose>
                                                                    <c:when test="${i == currentPage}">
                                                                        <span
                                                                            class="px-2.5 py-1 text-xs font-semibold text-white border"
                                                                            style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                                                            ${i}
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="${pageContext.request.contextPath}/nurse/patients?page=${i}${searchQuery}"
                                                                            class="px-2.5 py-1 text-xs border border-gray-300 bg-white hover:bg-gray-100 transition-colors"
                                                                            style="border-radius: 2px;">
                                                                            ${i}
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:if>
                                                        </c:forEach>

                                                        <!-- Show ellipsis if needed -->
                                                        <c:if test="${currentPage < totalPages - 2}">
                                                            <span class="px-2 text-xs text-gray-500">...</span>
                                                        </c:if>

                                                        <!-- Always show last page -->
                                                        <c:choose>
                                                            <c:when test="${currentPage == totalPages}">
                                                                <span
                                                                    class="px-2.5 py-1 text-xs font-semibold text-white border"
                                                                    style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                                                    ${totalPages}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${pageContext.request.contextPath}/nurse/patients?page=${totalPages}${searchQuery}"
                                                                    class="px-2.5 py-1 text-xs border border-gray-300 bg-white hover:bg-gray-100 transition-colors"
                                                                    style="border-radius: 2px;">
                                                                    ${totalPages}
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>

                                                <!-- Next Button -->
                                                <c:choose>
                                                    <c:when test="${currentPage < totalPages}">
                                                        <a href="${pageContext.request.contextPath}/nurse/patients?page=${currentPage + 1}${searchQuery}"
                                                            class="px-2 py-1 text-xs border border-gray-300 bg-white hover:bg-gray-100 transition-colors"
                                                            style="border-radius: 2px;">
                                                            <svg class="w-3 h-3" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2" d="M9 5l7 7-7 7" />
                                                            </svg>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="px-2 py-1 text-xs border border-gray-200 bg-gray-100 text-gray-400 cursor-not-allowed"
                                                            style="border-radius: 2px;">
                                                            <svg class="w-3 h-3" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2" d="M9 5l7 7-7 7" />
                                                            </svg>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>

                <!-- Registration Modal -->
                <div id="registrationModal"
                    class="hidden fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4">
                    <div class="bg-white border border-gray-300 w-full max-w-2xl max-h-[90vh] overflow-hidden flex flex-col"
                        style="border-radius: 2px;">
                        <!-- Modal Header -->
                        <div class="px-6 py-4 border-b border-gray-200 flex items-center justify-between flex-shrink-0">
                            <div>
                                <h2 class="text-lg font-semibold text-gray-800">Register New Patient</h2>
                                <p class="text-xs text-gray-600 mt-1">Step <span id="currentStep">1</span> of 2</p>
                            </div>
                            <button id="closeModal" type="button"
                                class="text-gray-400 hover:text-gray-600 transition-colors">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>

                        <!-- Progress Bar -->
                        <div class="px-6 py-3 border-b border-gray-200 flex-shrink-0">
                            <div class="flex gap-2">
                                <div class="flex-1 h-1 rounded-full transition-all" id="progress1"
                                    style="background-color: #DE6143;"></div>
                                <div class="flex-1 h-1 bg-gray-200 rounded-full transition-all" id="progress2"></div>
                            </div>
                        </div>

                        <!-- Form Container -->
                        <form id="patientForm" method="post" action="${pageContext.request.contextPath}/nurse/patients"
                            enctype="multipart/form-data">
                            <!-- Modal Body - Scrollable with FIXED height -->
                            <div class="modal-body-scroll px-6 py-4">
                                <!-- Step 1: Personal Information (REQUIRED FIELDS from Patient entity) -->
                                <div id="step1" class="space-y-4">
                                    <h3 class="text-sm font-semibold text-gray-800 mb-4">Personal Information</h3>

                                    <!-- Profile Picture Upload (Optional - NOT required to proceed) -->
                                    <div class="mb-6">
                                        <label class="block text-xs font-medium text-gray-700 mb-2">
                                            Profile Picture (Optional)
                                        </label>
                                        <div class="flex items-center gap-4">
                                            <div id="profilePreview"
                                                class="w-20 h-20 flex-shrink-0 rounded-full bg-gray-200 border-2 border-gray-300 flex items-center justify-center overflow-hidden">
                                                <svg class="w-10 h-10 text-gray-400" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                </svg>
                                                <img id="profileImage" class="hidden w-full h-full object-cover"
                                                    alt="Profile preview">
                                            </div>
                                            <div class="flex-shrink-0">
                                                <input type="file" id="profilePicture" name="profilePicture"
                                                    accept="image/*" class="hidden">
                                                <button type="button" id="uploadBtn"
                                                    class="px-3 py-1.5 text-xs font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 transition-all"
                                                    style="border-radius: 2px;">
                                                    Choose Photo
                                                </button>
                                                <p class="text-[10px] text-gray-500 mt-1">JPG, PNG or GIF (Max 2MB)</p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- FIXED 2-column grid -->
                                    <div class="fixed-grid-2">
                                        <div>
                                            <label class="block text-xs font-medium text-gray-700 mb-1">
                                                First Name <span class="text-red-500">*</span>
                                            </label>
                                            <input type="text" id="firstName" name="firstName" autocomplete="off"
                                                class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                                style="border-radius: 2px;" placeholder="Enter first name">
                                        </div>
                                        <div>
                                            <label class="block text-xs font-medium text-gray-700 mb-1">
                                                Last Name <span class="text-red-500">*</span>
                                            </label>
                                            <input type="text" id="lastName" name="lastName" autocomplete="off"
                                                class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                                style="border-radius: 2px;" placeholder="Enter last name">
                                        </div>
                                    </div>

                                    <div class="fixed-grid-2">
                                        <div>
                                            <label class="block text-xs font-medium text-gray-700 mb-1">
                                                Date of Birth <span class="text-red-500">*</span>
                                            </label>
                                            <input type="date" id="dateOfBirth" name="dateOfBirth" autocomplete="off"
                                                class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                                style="border-radius: 2px;">
                                        </div>
                                        <div>
                                            <label class="block text-xs font-medium text-gray-700 mb-1">
                                                Gender <span class="text-red-500">*</span>
                                            </label>
                                            <select id="gender" name="gender" autocomplete="off"
                                                class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                                style="border-radius: 2px;">
                                                <option value="">Select gender</option>
                                                <option value="MALE">Male</option>
                                                <option value="FEMALE">Female</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="fixed-grid-2">
                                        <div>
                                            <label class="block text-xs font-medium text-gray-700 mb-1">
                                                CIN <span class="text-red-500">*</span>
                                            </label>
                                            <input type="text" id="cin" name="cin" autocomplete="off"
                                                class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                                style="border-radius: 2px;" placeholder="AB123456">
                                        </div>
                                        <div>
                                            <label class="block text-xs font-medium text-gray-700 mb-1">Phone
                                                Number</label>
                                            <input type="tel" id="phoneNumber" name="phoneNumber" autocomplete="off"
                                                class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                                style="border-radius: 2px;" placeholder="0612345678">
                                        </div>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-medium text-gray-700 mb-1">Address</label>
                                        <textarea id="address" name="address" rows="2" autocomplete="off"
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400 resize-none"
                                            style="border-radius: 2px;" placeholder="Enter full address"></textarea>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-medium text-gray-700 mb-1">Emergency
                                            Contact</label>
                                        <input type="tel" id="emergencyContact" name="emergencyContact"
                                            autocomplete="off"
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                            style="border-radius: 2px;" placeholder="Emergency contact number">
                                    </div>

                                    <div>
                                        <label class="block text-xs font-medium text-gray-700 mb-1">Social Security
                                            Number</label>
                                        <input type="text" id="socialSecurityNumber" name="socialSecurityNumber"
                                            autocomplete="off"
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                            style="border-radius: 2px;" placeholder="Social security number">
                                    </div>
                                </div>

                                <!-- Step 2: Medical Information (OPTIONAL FIELDS from Patient entity) -->
                                <div id="step2" class="hidden space-y-4">
                                    <h3 class="text-sm font-semibold text-gray-800 mb-4">Medical Information</h3>

                                    <div>
                                        <label class="block text-xs font-medium text-gray-700 mb-1">Insurance
                                            Provider</label>
                                        <input type="text" id="insuranceProvider" name="insuranceProvider"
                                            autocomplete="off"
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400"
                                            style="border-radius: 2px;" placeholder="Insurance provider name">
                                    </div>

                                    <div>
                                        <label class="block text-xs font-medium text-gray-700 mb-1">Medical
                                            History</label>
                                        <textarea id="medicalHistory" name="medicalHistory" rows="3" autocomplete="off"
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400 resize-none"
                                            style="border-radius: 2px;"
                                            placeholder="Previous diagnoses, surgeries, chronic conditions..."></textarea>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-medium text-gray-700 mb-1">Allergies</label>
                                        <textarea id="allergies" name="allergies" rows="2" autocomplete="off"
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400 resize-none"
                                            style="border-radius: 2px;"
                                            placeholder="Known allergies (medications, food, environmental)..."></textarea>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-medium text-gray-700 mb-1">Current
                                            Treatments</label>
                                        <textarea id="currentTreatments" name="currentTreatments" rows="3"
                                            autocomplete="off"
                                            class="w-full px-3 py-2 text-xs border border-gray-300 focus:outline-none focus:border-gray-400 resize-none"
                                            style="border-radius: 2px;"
                                            placeholder="Current medications, dosages, ongoing treatments..."></textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal Footer -->
                            <div class="px-6 py-4 border-t border-gray-200 flex justify-between flex-shrink-0">
                                <button type="button" id="prevStepBtn"
                                    class="hidden px-4 py-2 text-xs font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 transition-all"
                                    style="border-radius: 2px;">
                                    <div class="flex items-center gap-1">
                                        <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M15 19l-7-7 7-7" />
                                        </svg>
                                        Previous
                                    </div>
                                </button>
                                <div class="flex gap-2 ml-auto">
                                    <button type="button" id="cancelBtn"
                                        class="px-4 py-2 text-xs font-medium text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 transition-all"
                                        style="border-radius: 2px;">
                                        Cancel
                                    </button>
                                    <button type="button" id="nextStepBtn"
                                        class="px-4 py-2 text-xs font-medium text-white border transition-all hover:opacity-90"
                                        style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                        <div class="flex items-center gap-1">
                                            Next
                                            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 5l7 7-7 7" />
                                            </svg>
                                        </div>
                                    </button>
                                    <button type="button" id="submitBtn"
                                        class="hidden px-4 py-2 text-xs font-medium text-white border transition-all hover:opacity-90"
                                        style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                        Register Patient
                                    </button>
                                </div>
                            </div>
                    </div>
                    </form>
                </div>

                <script>
                    // STRICT TWO-STEP FORM - ABSOLUTELY NO STEP SKIPPING
                    let currentStep = 1;
                    let canGoToStep2 = false; // FLAG: Only true when Next is clicked
                    let profilePictureFile = null; // Store the selected profile picture
                    let layoutProtectionActive = false; // Track if protection is active

                    // Get all DOM elements
                    const modal = document.getElementById('registrationModal');
                    const registerBtn = document.getElementById('registerPatientBtn');
                    const closeModalBtn = document.getElementById('closeModal');
                    const cancelBtn = document.getElementById('cancelBtn');
                    const nextStepBtn = document.getElementById('nextStepBtn');
                    const prevStepBtn = document.getElementById('prevStepBtn');
                    const submitBtn = document.getElementById('submitBtn');
                    const patientForm = document.getElementById('patientForm');
                    const step1Div = document.getElementById('step1');
                    const step2Div = document.getElementById('step2');
                    const currentStepSpan = document.getElementById('currentStep');
                    const progress1 = document.getElementById('progress1');
                    const progress2 = document.getElementById('progress2');

                    // Function to force grid layout integrity
                    function enforceGridLayout() {
                        const grids = document.querySelectorAll('.fixed-grid-2');
                        grids.forEach(grid => {
                            // Force grid properties even if something tries to change them
                            grid.style.setProperty('display', 'grid', 'important');
                            grid.style.setProperty('grid-template-columns', 'repeat(2, 1fr)', 'important');
                            grid.style.setProperty('gap', '1rem', 'important');

                            // Remove any conflicting classes that might have been added
                            const classList = Array.from(grid.classList);
                            classList.forEach(className => {
                                if (className.includes('flex') || className.includes('block') ||
                                    className.includes('col-span') || className.includes('w-full')) {
                                    if (className !== 'fixed-grid-2') {
                                        console.log('Removing conflicting class:', className);
                                        grid.classList.remove(className);
                                    }
                                }
                            });
                        });
                    }

                    // Setup MutationObserver to watch for DOM changes from fake fillers
                    function setupLayoutProtection() {
                        if (layoutProtectionActive) return;
                        layoutProtectionActive = true;

                        const observer = new MutationObserver((mutations) => {
                            let needsEnforcement = false;

                            mutations.forEach((mutation) => {
                                // Check if fake filler modified classes or styles
                                if (mutation.type === 'attributes' &&
                                    (mutation.attributeName === 'class' ||
                                        mutation.attributeName === 'style')) {
                                    console.log('DOM change detected:', mutation.target, mutation.attributeName);
                                    needsEnforcement = true;
                                }
                            });

                            if (needsEnforcement) {
                                enforceGridLayout();
                            }
                        });

                        // Watch the entire form for changes
                        const step1 = document.getElementById('step1');
                        const step2 = document.getElementById('step2');

                        if (step1) {
                            observer.observe(step1, {
                                attributes: true,
                                childList: true,
                                subtree: true,
                                attributeFilter: ['class', 'style']
                            });
                        }

                        if (step2) {
                            observer.observe(step2, {
                                attributes: true,
                                childList: true,
                                subtree: true,
                                attributeFilter: ['class', 'style']
                            });
                        }

                        console.log('Layout protection activated');
                    }

                    // Profile picture elements
                    const profilePictureInput = document.getElementById('profilePicture');
                    const uploadBtn = document.getElementById('uploadBtn');
                    const profileImage = document.getElementById('profileImage');
                    const profilePreview = document.getElementById('profilePreview');

                    // Profile picture upload functionality (OPTIONAL - not required)
                    uploadBtn.addEventListener('click', function () {
                        profilePictureInput.click();
                    });

                    profilePictureInput.addEventListener('change', function (e) {
                        const file = e.target.files[0];
                        if (file) {
                            // Validate file size (max 2MB)
                            if (file.size > 2 * 1024 * 1024) {
                                alert('File size must be less than 2MB');
                                profilePictureInput.value = '';
                                return;
                            }

                            // Validate file type
                            if (!file.type.match('image.*')) {
                                alert('Please select an image file');
                                profilePictureInput.value = '';
                                return;
                            }

                            profilePictureFile = file;

                            // Show preview
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                profileImage.src = e.target.result;
                                profileImage.classList.remove('hidden');
                                profilePreview.querySelector('svg').classList.add('hidden');
                            };
                            reader.readAsDataURL(file);
                        }
                    });

                    // Open modal - ALWAYS starts at step 1
                    registerBtn.addEventListener('click', function () {
                        modal.classList.remove('hidden');
                        currentStep = 1;
                        canGoToStep2 = false; // Reset the flag
                        showStep(1);

                        // Enable layout protection when modal opens
                        setupLayoutProtection();
                        enforceGridLayout();

                        // Add input event listeners to detect fake filler
                        setTimeout(() => {
                            const allInputs = document.querySelectorAll('#step1 input, #step1 select, #step1 textarea, #step2 input, #step2 select, #step2 textarea');
                            allInputs.forEach(input => {
                                input.addEventListener('input', function () {
                                    // If any input changes, enforce layout immediately
                                    enforceGridLayout();
                                }, { passive: true });
                            });
                            console.log('Input listeners attached for fake filler detection');
                        }, 100);
                    });

                    // Close modal functions - CLEARS ALL DATA
                    function closeModalFunc() {
                        modal.classList.add('hidden');
                        clearAllFields();
                        currentStep = 1;
                        canGoToStep2 = false;
                        showStep(1);
                    }

                    closeModalBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        closeModalFunc();
                    });

                    cancelBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        closeModalFunc();
                    });

                    // Click OUTSIDE modal - CLOSES and CLEARS
                    modal.addEventListener('click', function (e) {
                        if (e.target === modal) {
                            e.preventDefault();
                            e.stopPropagation();
                            closeModalFunc();
                        }
                    });

                    // Prevent clicks inside form from closing modal
                    patientForm.addEventListener('click', function (e) {
                        e.stopPropagation();
                    });

                    // Show specific step ONLY - with STRICT FLAG CHECK
                    function showStep(stepNumber) {
                        // CRITICAL: Cannot go to step 2 unless Next button was clicked
                        if (stepNumber === 2 && !canGoToStep2) {
                            console.log('BLOCKED: Cannot go to step 2 without clicking Next');
                            stepNumber = 1;
                        }

                        currentStep = stepNumber;

                        // Hide both steps
                        step1Div.classList.add('hidden');
                        step2Div.classList.add('hidden');

                        // Show only the current step
                        if (stepNumber === 1) {
                            step1Div.classList.remove('hidden');
                            prevStepBtn.classList.add('hidden');
                            nextStepBtn.classList.remove('hidden');
                            submitBtn.classList.add('hidden');
                            progress1.style.backgroundColor = '#DE6143';
                            progress2.style.backgroundColor = '#E5E7EB';
                        } else if (stepNumber === 2) {
                            step2Div.classList.remove('hidden');
                            prevStepBtn.classList.remove('hidden');
                            nextStepBtn.classList.add('hidden');
                            submitBtn.classList.remove('hidden');
                            progress1.style.backgroundColor = '#DE6143';
                            progress2.style.backgroundColor = '#DE6143';
                        }

                        currentStepSpan.textContent = stepNumber;
                    }

                    // Validate Step 1 - ONLY REQUIRED fields (profile picture is NOT required)
                    function validateStep1() {
                        const firstName = document.getElementById('firstName').value.trim();
                        const lastName = document.getElementById('lastName').value.trim();
                        const dateOfBirth = document.getElementById('dateOfBirth').value.trim();
                        const cin = document.getElementById('cin').value.trim();
                        const gender = document.getElementById('gender').value;

                        // Profile picture is OPTIONAL - no validation needed

                        if (!firstName) {
                            alert('First Name is required');
                            document.getElementById('firstName').focus();
                            return false;
                        }
                        if (!lastName) {
                            alert('Last Name is required');
                            document.getElementById('lastName').focus();
                            return false;
                        }
                        if (!dateOfBirth) {
                            alert('Date of Birth is required');
                            document.getElementById('dateOfBirth').focus();
                            return false;
                        }
                        if (!cin) {
                            alert('CIN is required');
                            document.getElementById('cin').focus();
                            return false;
                        }
                        if (!gender) {
                            alert('Gender is required');
                            document.getElementById('gender').focus();
                            return false;
                        }

                        return true;
                    }

                    // NEXT button - THE ONLY WAY to go to step 2
                    nextStepBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        e.stopPropagation();

                        if (currentStep === 1 && validateStep1()) {
                            canGoToStep2 = true; // SET THE FLAG - Now allowed to go to step 2
                            currentStep = 2;
                            showStep(2);
                        }
                    });

                    // PREVIOUS button - go back to step 1
                    prevStepBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        e.stopPropagation();

                        if (currentStep === 2) {
                            currentStep = 1;
                            showStep(1);
                        }
                    });

                    // SUBMIT button - Create form and submit
                    submitBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        e.stopPropagation();

                        // Double-check validation before submitting
                        if (!validateStep1()) {
                            canGoToStep2 = false;
                            currentStep = 1;
                            showStep(1);
                            return;
                        }

                        // Disable button to prevent double submission
                        submitBtn.disabled = true;
                        submitBtn.textContent = 'Registering...';

                        console.log('=== Submitting Patient Registration ===');

                        // Submit the form normally (no AJAX)
                        patientForm.submit();
                    });

                    // Clear all input fields
                    function clearAllFields() {
                        document.getElementById('firstName').value = '';
                        document.getElementById('lastName').value = '';
                        document.getElementById('dateOfBirth').value = '';
                        document.getElementById('gender').value = '';
                        document.getElementById('cin').value = '';
                        document.getElementById('phoneNumber').value = '';
                        document.getElementById('address').value = '';
                        document.getElementById('emergencyContact').value = '';
                        document.getElementById('socialSecurityNumber').value = '';
                        document.getElementById('insuranceProvider').value = '';
                        document.getElementById('medicalHistory').value = '';
                        document.getElementById('allergies').value = '';
                        document.getElementById('currentTreatments').value = '';
                        profilePictureInput.value = '';
                        profilePictureFile = null;
                        profileImage.src = '';
                        profileImage.classList.add('hidden');
                        profilePreview.querySelector('svg').classList.remove('hidden');

                        submitBtn.disabled = false;
                        submitBtn.textContent = 'Register Patient';
                        canGoToStep2 = false;
                    }

                    // Prevent Enter key from causing issues
                    document.addEventListener('keydown', function (e) {
                        if (!modal.classList.contains('hidden') && e.key === 'Enter') {
                            e.preventDefault();
                            e.stopPropagation();

                            // If on step 1 and Next button is visible, trigger it
                            if (currentStep === 1 && !nextStepBtn.classList.contains('hidden')) {
                                nextStepBtn.click();
                            }
                            return false;
                        }
                    });

                    // Prevent any automatic step changes from autofill or fake fillers
                    setInterval(function () {
                        // Force stay on correct step
                        if (currentStep === 1 && step1Div.classList.contains('hidden')) {
                            console.log('PROTECTION: Forcing step 1 visibility');
                            showStep(1);
                        } else if (currentStep === 2 && step2Div.classList.contains('hidden') && canGoToStep2) {
                            console.log('PROTECTION: Forcing step 2 visibility');
                            showStep(2);
                        }

                        // Continuously enforce grid layout when modal is open
                        if (!modal.classList.contains('hidden')) {
                            enforceGridLayout();
                        }
                    }, 50); // Check every 50ms for faster response

                    // Additional protection: Watch for window resize or any layout changes
                    window.addEventListener('resize', function () {
                        if (!modal.classList.contains('hidden')) {
                            enforceGridLayout();
                        }
                    });

                    // Log when page loads
                    console.log('Patient registration form initialized with layout protection');
                </script>
            </body>

            </html>