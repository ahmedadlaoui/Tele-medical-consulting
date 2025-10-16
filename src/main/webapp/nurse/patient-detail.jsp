<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Patient Details - Nurse Dashboard</title>
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
                </style>
            </head>

            <body class="min-h-screen" style="background-color: #FEFDFB;">
                <div class="flex flex-col h-screen">
                    <!-- Header -->
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

                            <!-- Center: Back Button -->
                            <div class="flex items-center gap-3">
                                <a href="${pageContext.request.contextPath}/nurse/patients"
                                    class="flex items-center gap-2 px-4 py-2 text-xs font-medium text-gray-700 border border-gray-300 hover:bg-gray-100 transition-all"
                                    style="border-radius: 2px;">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M15 19l-7-7 7-7" />
                                    </svg>
                                    Back to Patients
                                </a>
                            </div>

                            <!-- Right: Profile -->
                            <div class="flex items-center gap-4 mr-4">
                                <!-- Notification Icon -->
                                <button
                                    class="relative p-2 text-gray-600 hover:bg-gray-100 rounded-full transition-all">
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
                                    <span class="text-xs font-medium text-gray-700"
                                        style="font-family: 'Poppins', sans-serif;">
                                        <%= session.getAttribute("userName") %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </header>

                    <main class="flex-1 overflow-y-auto">
                        <div class="max-w-[1400px] mx-auto px-8 py-6">

                            <!-- Success Message -->
                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="mb-4 px-4 py-3 bg-green-50 border border-green-200 text-green-800 text-sm flex items-center gap-2"
                                    style="border-radius: 2px;">
                                    <svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M5 13l4 4L19 7" />
                                    </svg>
                                    <span>${sessionScope.successMessage}</span>
                                </div>
                                <c:remove var="successMessage" scope="session" />
                            </c:if>

                            <!-- Error Message -->
                            <c:if test="${not empty sessionScope.errorMessage}">
                                <div class="mb-4 px-4 py-3 bg-red-50 border border-red-200 text-red-800 text-sm flex items-center gap-2"
                                    style="border-radius: 2px;">
                                    <svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                    <span>${sessionScope.errorMessage}</span>
                                </div>
                                <c:remove var="errorMessage" scope="session" />
                            </c:if>

                            <!-- Main Grid Layout -->
                            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                                <!-- Left Column: Patient Info + Medical History -->
                                <div class="lg:col-span-2 space-y-6">
                                    <!-- Patient Information Card -->
                                    <div class="bg-white border border-gray-300" style="border-radius: 2px;">
                                        <div class="px-4 py-3 border-b border-gray-200">
                                            <h2 class="text-sm font-semibold text-gray-800">Patient Information</h2>
                                        </div>
                                        <div class="p-6">
                                            <div class="flex items-start gap-6 mb-6">
                                                <!-- Profile Picture -->
                                                <div class="flex-shrink-0">
                                                    <c:choose>
                                                        <c:when test="${not empty patient.profilePicture}">
                                                            <img src="${pageContext.request.contextPath}${patient.profilePicture}"
                                                                alt="${patient.firstName} ${patient.lastName}"
                                                                class="w-24 h-24 rounded-full object-cover border-2 border-gray-200">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div
                                                                class="w-24 h-24 rounded-full bg-gray-300 border-2 border-gray-200 flex items-center justify-center">
                                                                <span class="text-gray-600 font-semibold text-2xl">
                                                                    ${fn:substring(patient.firstName, 0,
                                                                    1)}${fn:substring(patient.lastName, 0, 1)}
                                                                </span>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <!-- Basic Info -->
                                                <div class="flex-1">
                                                    <h3 class="text-xl font-bold text-gray-800 mb-2">
                                                        ${patient.firstName} ${patient.lastName}</h3>
                                                    <div class="grid grid-cols-2 gap-x-6 gap-y-3">
                                                        <div>
                                                            <p class="text-xs text-gray-500 mb-0.5">CIN</p>
                                                            <p class="text-sm font-medium text-gray-800">${patient.cin}
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500 mb-0.5">Date of Birth</p>
                                                            <p class="text-sm font-medium text-gray-800">
                                                                ${patient.dateOfBirth}</p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500 mb-0.5">Gender</p>
                                                            <p class="text-sm font-medium text-gray-800">
                                                                ${patient.gender}</p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500 mb-0.5">Phone Number</p>
                                                            <p class="text-sm font-medium text-gray-800">
                                                                <c:choose>
                                                                    <c:when test="${not empty patient.phoneNumber}">
                                                                        ${patient.phoneNumber}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-gray-400">N/A</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <div class="col-span-2">
                                                            <p class="text-xs text-gray-500 mb-0.5">Address</p>
                                                            <p class="text-sm font-medium text-gray-800">
                                                                <c:choose>
                                                                    <c:when test="${not empty patient.address}">
                                                                        ${patient.address}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-gray-400">N/A</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500 mb-0.5">Emergency Contact
                                                            </p>
                                                            <p class="text-sm font-medium text-gray-800">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty patient.emergencyContact}">
                                                                        ${patient.emergencyContact}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-gray-400">N/A</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500 mb-0.5">Registration Date
                                                            </p>
                                                            <p class="text-sm font-medium text-gray-800">
                                                                ${fn:substring(patient.registrationDate, 0, 10)}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Insurance Information -->
                                            <div class="border-t border-gray-200 pt-4">
                                                <h4 class="text-xs font-semibold text-gray-700 mb-3">Insurance
                                                    Information</h4>
                                                <div class="grid grid-cols-2 gap-x-6 gap-y-3">
                                                    <div>
                                                        <p class="text-xs text-gray-500 mb-0.5">Social Security Number
                                                        </p>
                                                        <p class="text-sm font-medium text-gray-800">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${not empty patient.socialSecurityNumber}">
                                                                    ${patient.socialSecurityNumber}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-gray-400">N/A</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs text-gray-500 mb-0.5">Insurance Provider</p>
                                                        <p class="text-sm font-medium text-gray-800">
                                                            <c:choose>
                                                                <c:when test="${not empty patient.insuranceProvider}">
                                                                    ${patient.insuranceProvider}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-gray-400">N/A</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Medical History Card -->
                                    <div class="bg-white border border-gray-300" style="border-radius: 2px;">
                                        <div class="px-4 py-3 border-b border-gray-200">
                                            <h2 class="text-sm font-semibold text-gray-800">Medical History</h2>
                                        </div>
                                        <div class="p-6">
                                            <div class="space-y-4">
                                                <div>
                                                    <h4 class="text-xs font-semibold text-gray-700 mb-2">Medical History
                                                    </h4>
                                                    <p class="text-sm text-gray-600">
                                                        <c:choose>
                                                            <c:when test="${not empty patient.medicalHistory}">
                                                                ${patient.medicalHistory}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-gray-400">No medical history
                                                                    recorded</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                                <div>
                                                    <h4 class="text-xs font-semibold text-gray-700 mb-2">Allergies</h4>
                                                    <p class="text-sm text-gray-600">
                                                        <c:choose>
                                                            <c:when test="${not empty patient.allergies}">
                                                                ${patient.allergies}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-gray-400">No allergies recorded</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                                <div>
                                                    <h4 class="text-xs font-semibold text-gray-700 mb-2">Current
                                                        Treatments</h4>
                                                    <p class="text-sm text-gray-600">
                                                        <c:choose>
                                                            <c:when test="${not empty patient.currentTreatments}">
                                                                ${patient.currentTreatments}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-gray-400">No current treatments
                                                                    recorded</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Vital Signs History Card -->
                                    <div class="bg-white border border-gray-300" style="border-radius: 2px;">
                                        <div class="px-4 py-3 border-b border-gray-200">
                                            <h2 class="text-sm font-semibold text-gray-800">Vital Signs History</h2>
                                        </div>
                                        <div class="p-6">
                                            <div class="space-y-3">
                                                <!-- Sample Vital Signs Entry -->
                                                <div class="bg-gray-50 p-4 border border-gray-200"
                                                    style="border-radius: 2px;">
                                                    <div class="flex justify-between items-start mb-3">
                                                        <p class="text-xs font-semibold text-gray-700">October 15, 2025
                                                            - 10:30 AM</p>
                                                    </div>
                                                    <div class="grid grid-cols-3 gap-4">
                                                        <div>
                                                            <p class="text-xs text-gray-500">Temperature</p>
                                                            <p class="text-sm font-medium text-gray-800">36.5°C</p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500">Blood Pressure</p>
                                                            <p class="text-sm font-medium text-gray-800">120/80 mmHg</p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500">Pulse Rate</p>
                                                            <p class="text-sm font-medium text-gray-800">72 bpm</p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500">Respiratory Rate</p>
                                                            <p class="text-sm font-medium text-gray-800">16 /min</p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500">O2 Saturation</p>
                                                            <p class="text-sm font-medium text-gray-800">98%</p>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs text-gray-500">Weight</p>
                                                            <p class="text-sm font-medium text-gray-800">75 kg</p>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Empty State -->
                                                <div class="text-center py-6 text-gray-500 text-sm hidden">
                                                    <svg class="w-12 h-12 mx-auto mb-2 text-gray-300" fill="none"
                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                                                    </svg>
                                                    <p>No vital signs recorded yet</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Right Column: Actions -->
                                <div class="space-y-6">
                                    <!-- Record Vital Signs Card -->
                                    <div class="bg-white border border-gray-300" style="border-radius: 2px;">
                                        <div class="px-4 py-3 border-b border-gray-200">
                                            <h2 class="text-sm font-semibold text-gray-800">Record Vital Signs</h2>
                                        </div>
                                        <div class="p-4">
                                            <form action="${pageContext.request.contextPath}/nurse/record-vital-signs"
                                                method="post" class="space-y-4">
                                                <input type="hidden" name="patientId" value="${patient.id}">

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Temperature (°C) <span class="text-red-500">*</span>
                                                    </label>
                                                    <input type="number" name="temperature" step="0.1" min="30" max="45"
                                                        placeholder="36.5" required
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                </div>

                                                <div class="grid grid-cols-2 gap-3">
                                                    <div>
                                                        <label class="block text-xs font-medium text-gray-700 mb-1">
                                                            Systolic <span class="text-red-500">*</span>
                                                        </label>
                                                        <input type="number" name="bloodPressureSystolic" min="50"
                                                            max="250" placeholder="120" required
                                                            class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                            style="border-radius: 2px;">
                                                    </div>
                                                    <div>
                                                        <label class="block text-xs font-medium text-gray-700 mb-1">
                                                            Diastolic <span class="text-red-500">*</span>
                                                        </label>
                                                        <input type="number" name="bloodPressureDiastolic" min="30"
                                                            max="150" placeholder="80" required
                                                            class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                            style="border-radius: 2px;">
                                                    </div>
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Pulse Rate (bpm) <span class="text-red-500">*</span>
                                                    </label>
                                                    <input type="number" name="pulseRate" min="30" max="250"
                                                        placeholder="72" required
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Respiratory Rate (/min)
                                                    </label>
                                                    <input type="number" name="respiratoryRate" min="5" max="60"
                                                        placeholder="16"
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        O2 Saturation (%)
                                                    </label>
                                                    <input type="number" name="oxygenSaturation" min="0" max="100"
                                                        placeholder="98"
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Weight (kg)
                                                    </label>
                                                    <input type="number" name="weight" step="0.1" min="0" max="500"
                                                        placeholder="75"
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Height (cm)
                                                    </label>
                                                    <input type="number" name="height" step="0.1" min="0" max="300"
                                                        placeholder="175"
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Notes
                                                    </label>
                                                    <textarea name="notes" rows="3"
                                                        placeholder="Additional observations..."
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;"></textarea>
                                                </div>

                                                <button type="submit"
                                                    class="w-full px-4 py-2.5 text-sm font-medium text-white border transition-all hover:opacity-90"
                                                    style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                                    Save Vital Signs
                                                </button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Assign to Queue Card -->
                                    <div class="bg-white border border-gray-300" style="border-radius: 2px;">
                                        <div class="px-4 py-3 border-b border-gray-200">
                                            <h2 class="text-sm font-semibold text-gray-800">Assign to Queue</h2>
                                        </div>
                                        <div class="p-4">
                                            <form class="space-y-4">
                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Select General Practitioner <span class="text-red-500">*</span>
                                                    </label>
                                                    <select required
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                        <option value="">-- Select GP --</option>
                                                        <option value="1">Dr. Ahmed Bennani</option>
                                                        <option value="2">Dr. Sarah El Alaoui</option>
                                                        <option value="3">Dr. Mohammed Tahiri</option>
                                                        <option value="4">Dr. Fatima Zahra Idrissi</option>
                                                    </select>
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Priority Level <span class="text-red-500">*</span>
                                                    </label>
                                                    <select required
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;">
                                                        <option value="NORMAL">Normal</option>
                                                        <option value="URGENT">Urgent</option>
                                                        <option value="CRITICAL">Critical</option>
                                                    </select>
                                                </div>

                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">
                                                        Notes
                                                    </label>
                                                    <textarea rows="3" placeholder="Reason for visit, symptoms..."
                                                        class="w-full px-3 py-2 text-sm border border-gray-300 focus:outline-none focus:border-gray-400"
                                                        style="border-radius: 2px;"></textarea>
                                                </div>

                                                <button type="submit"
                                                    class="w-full px-4 py-2.5 text-sm font-medium text-white border transition-all hover:opacity-90"
                                                    style="background-color: #DE6143; border-color: #DE6143; border-radius: 2px;">
                                                    Add to Queue
                                                </button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Current Queue Status (if assigned) -->
                                    <div class="bg-white border border-gray-300" style="border-radius: 2px;">
                                        <div class="px-4 py-3 border-b border-gray-200">
                                            <h2 class="text-sm font-semibold text-gray-800">Queue Status</h2>
                                        </div>
                                        <div class="p-4">
                                            <!-- Not in Queue State -->
                                            <div class="text-center py-4 text-gray-500 text-sm">
                                                <svg class="w-12 h-12 mx-auto mb-2 text-gray-300" fill="none"
                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                </svg>
                                                <p>Patient not in queue</p>
                                            </div>

                                            <!-- In Queue State (Hidden by default, shown when patient is in queue) -->
                                            <div class="hidden">
                                                <div class="space-y-3">
                                                    <div class="flex justify-between items-center">
                                                        <span class="text-xs font-medium text-gray-700">Status</span>
                                                        <span
                                                            class="px-2 py-1 text-xs font-medium bg-yellow-100 text-yellow-800"
                                                            style="border-radius: 2px;">Waiting</span>
                                                    </div>
                                                    <div class="flex justify-between items-center">
                                                        <span class="text-xs font-medium text-gray-700">Assigned
                                                            GP</span>
                                                        <span class="text-xs text-gray-600">Dr. Ahmed Bennani</span>
                                                    </div>
                                                    <div class="flex justify-between items-center">
                                                        <span class="text-xs font-medium text-gray-700">Priority</span>
                                                        <span
                                                            class="px-2 py-1 text-xs font-medium bg-blue-100 text-blue-800"
                                                            style="border-radius: 2px;">Normal</span>
                                                    </div>
                                                    <div class="flex justify-between items-center">
                                                        <span class="text-xs font-medium text-gray-700">Arrival
                                                            Time</span>
                                                        <span class="text-xs text-gray-600">10:30 AM</span>
                                                    </div>
                                                    <div class="flex justify-between items-center">
                                                        <span class="text-xs font-medium text-gray-700">Est. Wait
                                                            Time</span>
                                                        <span class="text-xs text-gray-600">15 minutes</span>
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
            </body>

            </html>