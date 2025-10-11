<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Sign Up - Hospital Medical Consulting System</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
            }

            .floating-label-container {
                position: relative;
                margin-bottom: 1.25rem;
            }

            .floating-input,
            .floating-select {
                width: 100%;
                padding: 0.625rem 1rem;
                border: 1px solid #9ca3af;
                background-color: white;
                color: #111827;
                font-size: 0.875rem;
                border-radius: 4px;
                transition: border-color 0.2s ease;
            }

            .floating-input:focus,
            .floating-select:focus {
                outline: none;
                border-color: #DE6143;
                box-shadow: 0 0 0 1px #DE6143;
            }

            .floating-label {
                position: absolute;
                left: 1rem;
                top: 0.625rem;
                color: #6b7280;
                font-size: 0.875rem;
                font-weight: 400;
                pointer-events: none;
                transition: all 0.2s ease;
                background-color: #FEFDFB;
                padding: 0 0.25rem;
            }

            .floating-input:focus~.floating-label,
            .floating-input:not(:placeholder-shown)~.floating-label,
            .floating-select:focus~.floating-label,
            .floating-select:not([value=""])~.floating-label {
                top: -0.5rem;
                font-size: 0.75rem;
                color: #DE6143;
            }

            .step-indicator {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 2rem;
            }

            .step {
                width: 2rem;
                height: 2rem;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.875rem;
                font-weight: 500;
                background-color: #e5e7eb;
                color: #6b7280;
                transition: all 0.3s ease;
            }

            .step.active {
                background-color: #DE6143;
                color: white;
            }

            .step.completed {
                background-color: #DE6143;
                color: white;
            }

            .step-line {
                width: 3rem;
                height: 2px;
                background-color: #e5e7eb;
                margin: 0 0.5rem;
            }

            .step-line.completed {
                background-color: #DE6143;
            }

            .form-phase {
                display: none;
            }

            .form-phase.active {
                display: block;
            }

            .loading-container {
                display: none;
                text-align: center;
            }

            .loading-container.active {
                display: block;
            }

            .spinner {
                border: 4px solid #f3f4f6;
                border-top: 4px solid #DE6143;
                border-radius: 50%;
                width: 60px;
                height: 60px;
                animation: spin 1s linear infinite;
                margin: 0 auto 1.5rem;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>

    <body class="h-screen overflow-hidden bg-gray-50">
        <div class="flex h-full">
            <!-- Left Side - Image Section (65%) -->
            <div class="hidden lg:flex lg:w-[65%] relative bg-gray-100">
                <img src="https://images.unsplash.com/photo-1631217868264-e5b90bb7e133?w=1920&q=80" alt="Hospital Team"
                    class="w-full h-full object-cover">

                <!-- Dark Overlay -->
                <div class="absolute inset-0 bg-black bg-opacity-50"></div>

                <!-- Content Overlay -->
                <div class="absolute inset-0 flex flex-col justify-center px-20 text-white">
                    <div class="max-w-2xl">
                        <h1 class="text-6xl font-bold tracking-tight mb-6 leading-tight">
                            Welcome to Your Digital Workspace
                        </h1>

                        <p class="text-2xl text-gray-200 font-light leading-relaxed">
                            Consult, connect, and collaborate with general practitioners, specialists, and nurses to
                            deliver exceptional patient care
                        </p>
                    </div>
                </div>
            </div>

            <!-- Right Side - Sign Up Form Section (35%) -->
            <div class="w-full lg:w-[35%] flex items-center justify-center px-8 overflow-y-auto"
                style="background-color: #FEFDFB;">
                <div class="w-full max-w-sm py-8">

                    <!-- Logo -->
                    <div class="flex justify-center mb-6">
                        <img src="${pageContext.request.contextPath}/assets/images/logo_consulting-removebg-preview.png"
                            alt="Medical Consulting Logo" class="h-20 w-20 object-contain">
                    </div>

                    <!-- Sign Up Title -->
                    <div class="text-center mb-8" id="signupTitle">
                        <h2 class="text-xl font-normal text-gray-700" style="font-family: 'Poppins', sans-serif;">Create
                            Account</h2>
                        <p class="text-xs text-gray-500 mt-2">Join our medical team</p>
                    </div>

                    <!-- Loading Title (Hidden by default) -->
                    <div class="text-center mb-8 loading-container" id="loadingTitle">
                        <h2 class="text-xl font-normal text-gray-700" style="font-family: 'Poppins', sans-serif;">
                            Welcome</h2>
                    </div>

                    <!-- Step Indicator -->
                    <div class="step-indicator" id="stepIndicator">
                        <div class="step active" id="step1">1</div>
                        <div class="step-line" id="line1"></div>
                        <div class="step" id="step2">2</div>
                        <div class="step-line" id="line2"></div>
                        <div class="step" id="step3">3</div>
                    </div>

                    <% String flashMessage=(String) session.getAttribute("flashMessage"); if (flashMessage !=null) {
                        session.removeAttribute("flashMessage"); %>
                        <div class="mb-4 p-3 rounded-md text-sm"
                            style="background-color: #FEE2E2; border: 1px solid #EF4444; color: #991B1B; border-radius: 4px;">
                            <div class="flex items-center">
                                <svg class="w-4 h-4 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd"
                                        d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                        clip-rule="evenodd" />
                                </svg>
                                <span>
                                    <%= flashMessage %>
                                </span>
                            </div>
                        </div>
                        <% } %>

                            <!-- Loading Container -->
                            <div class="loading-container" id="loadingContainer">
                                <div class="spinner"></div>
                                <p class="text-sm text-gray-700 font-medium">Your request is being processed</p>
                                <p class="text-xs text-gray-500 mt-2">Please wait...</p>
                            </div>

                            <!-- Sign Up Form -->
                            <form action="${pageContext.request.contextPath}/signup" method="post" id="signupForm"
                                onsubmit="showLoading(event)">

                                <!-- Phase 1: Personal Information -->
                                <div class="form-phase active" id="phase1">
                                    <h3 class="text-sm font-medium text-gray-700 mb-4">Personal Information</h3>

                                    <!-- First Name & Last Name -->
                                    <div class="flex gap-3">
                                        <div class="floating-label-container flex-1">
                                            <input type="text" id="firstName" name="firstName" class="floating-input"
                                                placeholder=" " required>
                                            <label for="firstName" class="floating-label">First Name</label>
                                        </div>

                                        <div class="floating-label-container flex-1">
                                            <input type="text" id="lastName" name="lastName" class="floating-input"
                                                placeholder=" " required>
                                            <label for="lastName" class="floating-label">Last Name</label>
                                        </div>
                                    </div>

                                    <!-- Phone Number -->
                                    <div class="floating-label-container">
                                        <input type="tel" id="phoneNumber" name="phoneNumber" class="floating-input"
                                            placeholder=" ">
                                        <label for="phoneNumber" class="floating-label">Phone Number</label>
                                    </div>

                                    <!-- Next Button -->
                                    <button type="button" onclick="nextPhase(2)"
                                        class="w-full text-white py-2.5 text-sm font-medium hover:opacity-90 focus:outline-none"
                                        style="background-color: #DE6143; border-radius: 4px;">
                                        Next
                                    </button>
                                </div>

                                <!-- Phase 2: Account Details -->
                                <div class="form-phase" id="phase2">
                                    <h3 class="text-sm font-medium text-gray-700 mb-4">Account Details</h3>

                                    <!-- Email -->
                                    <div class="floating-label-container">
                                        <input type="email" id="email" name="email" class="floating-input"
                                            placeholder=" " required>
                                        <label for="email" class="floating-label">Email Address</label>
                                    </div>

                                    <!-- Password -->
                                    <div class="floating-label-container">
                                        <div class="relative">
                                            <input type="password" id="password" name="password" class="floating-input"
                                                placeholder=" " required>
                                            <label for="password" class="floating-label">Password</label>
                                            <button type="button"
                                                onclick="togglePassword('password', 'eyeIcon1', 'eyeSlashIcon1')"
                                                class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-500 hover:text-gray-700">
                                                <svg id="eyeIcon1" class="w-4 h-4" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                                <svg id="eyeSlashIcon1" class="w-4 h-4 hidden" fill="none"
                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
                                                </svg>
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Navigation Buttons -->
                                    <div class="flex gap-3">
                                        <button type="button" onclick="prevPhase(1)"
                                            class="w-1/3 text-gray-700 py-2.5 text-sm font-medium hover:bg-gray-100 focus:outline-none border border-gray-300"
                                            style="border-radius: 4px;">
                                            Back
                                        </button>
                                        <button type="button" onclick="nextPhase(3)"
                                            class="w-2/3 text-white py-2.5 text-sm font-medium hover:opacity-90 focus:outline-none"
                                            style="background-color: #DE6143; border-radius: 4px;">
                                            Next
                                        </button>
                                    </div>
                                </div>

                                <!-- Phase 3: Professional Information -->
                                <div class="form-phase" id="phase3">
                                    <h3 class="text-sm font-medium text-gray-700 mb-4">Professional Information</h3>

                                    <!-- Role Selection -->
                                    <div class="mb-5">
                                        <label class="block text-xs font-medium text-gray-700 mb-3">Select Your
                                            Role</label>
                                        <div class="flex gap-2">
                                            <!-- General Practitioner -->
                                            <label
                                                class="flex-1 flex flex-col p-2.5 border border-gray-300 cursor-pointer transition-all hover:border-gray-400"
                                                style="border-radius: 4px;"
                                                onclick="selectRole('GENERAL_PRACTITIONER', this)">
                                                <input type="radio" name="role" value="GENERAL_PRACTITIONER"
                                                    class="hidden">
                                                <div class="flex items-start mb-1.5">
                                                    <div class="role-checkbox w-4 h-4 border-2 border-gray-400 flex items-center justify-center mr-2 mt-0.5 transition-all flex-shrink-0"
                                                        style="border-radius: 4px;">
                                                        <svg class="w-3 h-3 text-white hidden" fill="currentColor"
                                                            viewBox="0 0 12 12">
                                                            <path
                                                                d="M10.28 2.28L4.5 8.06 1.72 5.28l.56-.56L4.5 6.94l5.22-5.22z" />
                                                        </svg>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-800 leading-tight">
                                                            General
                                                            Practitioner</p>
                                                    </div>
                                                </div>
                                                <p class="text-[10px] text-gray-500 leading-tight ml-6">Primary care
                                                    physician
                                                </p>
                                            </label>

                                            <!-- Specialist -->
                                            <label
                                                class="flex-1 flex flex-col p-2.5 border border-gray-300 cursor-pointer transition-all hover:border-gray-400"
                                                style="border-radius: 4px;" onclick="selectRole('SPECIALIST', this)">
                                                <input type="radio" name="role" value="SPECIALIST" class="hidden">
                                                <div class="flex items-start mb-1.5">
                                                    <div class="role-checkbox w-4 h-4 border-2 border-gray-400 flex items-center justify-center mr-2 mt-0.5 transition-all flex-shrink-0"
                                                        style="border-radius: 4px;">
                                                        <svg class="w-3 h-3 text-white hidden" fill="currentColor"
                                                            viewBox="0 0 12 12">
                                                            <path
                                                                d="M10.28 2.28L4.5 8.06 1.72 5.28l.56-.56L4.5 6.94l5.22-5.22z" />
                                                        </svg>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-800 leading-tight">
                                                            Specialist
                                                        </p>
                                                    </div>
                                                </div>
                                                <p class="text-[10px] text-gray-500 leading-tight ml-6">Specialized
                                                    practitioner
                                                </p>
                                            </label>

                                            <!-- Nurse -->
                                            <label
                                                class="flex-1 flex flex-col p-2.5 border border-gray-300 cursor-pointer transition-all hover:border-gray-400"
                                                style="border-radius: 4px;" onclick="selectRole('NURSE', this)">
                                                <input type="radio" name="role" value="NURSE" class="hidden">
                                                <div class="flex items-start mb-1.5">
                                                    <div class="role-checkbox w-4 h-4 border-2 border-gray-400 flex items-center justify-center mr-2 mt-0.5 transition-all flex-shrink-0"
                                                        style="border-radius: 4px;">
                                                        <svg class="w-3 h-3 text-white hidden" fill="currentColor"
                                                            viewBox="0 0 12 12">
                                                            <path
                                                                d="M10.28 2.28L4.5 8.06 1.72 5.28l.56-.56L4.5 6.94l5.22-5.22z" />
                                                        </svg>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-800 leading-tight">
                                                            Nurse</p>
                                                    </div>
                                                </div>
                                                <p class="text-[10px] text-gray-500 leading-tight ml-6">Healthcare
                                                    support</p>
                                            </label>
                                        </div>
                                    </div>

                                    <!-- License Number -->
                                    <div class="floating-label-container">
                                        <input type="text" id="licenseNumber" name="licenseNumber"
                                            class="floating-input" placeholder=" " required>
                                        <label for="licenseNumber" class="floating-label">License Number</label>
                                    </div>

                                    <!-- Navigation Buttons -->
                                    <div class="flex gap-3">
                                        <button type="button" onclick="prevPhase(2)"
                                            class="w-1/3 text-gray-700 py-2.5 text-sm font-medium hover:bg-gray-100 focus:outline-none border border-gray-300"
                                            style="border-radius: 4px;">
                                            Back
                                        </button>
                                        <button type="submit"
                                            class="w-2/3 text-white py-2.5 text-sm font-medium hover:opacity-90 focus:outline-none"
                                            style="background-color: #DE6143; border-radius: 4px;">
                                            Create Account
                                        </button>
                                    </div>
                                </div>

                            </form>

                            <!-- Sign In Link -->
                            <div class="mt-4 text-center" id="signInLink">
                                <p class="text-sm text-gray-600">
                                    Already have an account?
                                    <a href="${pageContext.request.contextPath}/login" class="font-medium"
                                        style="color: #DE6143;">Sign in</a>
                                </p>
                            </div>

                </div>
            </div>
        </div>

        <script>
            let currentPhase = 1;

            function selectRole(role, labelElement) {
                // Remove selection from all role options
                const allRoleLabels = document.querySelectorAll('label[onclick*="selectRole"]');
                allRoleLabels.forEach(label => {
                    const checkbox = label.querySelector('.role-checkbox');
                    checkbox.style.borderColor = '#9ca3af';
                    checkbox.style.backgroundColor = 'white';
                    const checkmark = checkbox.querySelector('svg');
                    checkmark.classList.add('hidden');
                });

                // Add selection to clicked option - only change checkbox
                const checkbox = labelElement.querySelector('.role-checkbox');
                checkbox.style.borderColor = '#DE6143';
                checkbox.style.backgroundColor = '#DE6143';
                const checkmark = checkbox.querySelector('svg');
                checkmark.classList.remove('hidden');
            }

            function validatePhase(phase) {
                if (phase === 1) {
                    // Validate Phase 1: First Name, Last Name (Phone is optional)
                    const firstName = document.getElementById('firstName').value.trim();
                    const lastName = document.getElementById('lastName').value.trim();

                    if (!firstName || !lastName) {
                        alert('Please fill in all required fields');
                        return false;
                    }
                } else if (phase === 2) {
                    // Validate Phase 2: Email and Password
                    const email = document.getElementById('email').value.trim();
                    const password = document.getElementById('password').value.trim();

                    if (!email || !password) {
                        alert('Please fill in all required fields');
                        return false;
                    }

                    // Basic email validation
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(email)) {
                        alert('Please enter a valid email address');
                        return false;
                    }
                } else if (phase === 3) {
                    // Validate Phase 3: Role and License Number
                    const role = document.querySelector('input[name="role"]:checked');
                    const licenseNumber = document.getElementById('licenseNumber').value.trim();

                    if (!role) {
                        alert('Please select your role');
                        return false;
                    }

                    if (!licenseNumber) {
                        alert('Please enter your license number');
                        return false;
                    }
                }
                return true;
            }

            function nextPhase(phase) {
                // Validate current phase before proceeding
                if (!validatePhase(currentPhase)) {
                    return;
                }

                // Hide current phase
                document.getElementById('phase' + currentPhase).classList.remove('active');

                // Mark current step as completed
                document.getElementById('step' + currentPhase).classList.add('completed');
                document.getElementById('step' + currentPhase).classList.remove('active');

                // Mark line as completed
                if (currentPhase < 3) {
                    document.getElementById('line' + currentPhase).classList.add('completed');
                }

                // Show next phase
                currentPhase = phase;
                document.getElementById('phase' + currentPhase).classList.add('active');
                document.getElementById('step' + currentPhase).classList.add('active');
            }

            function prevPhase(phase) {
                // Hide current phase
                document.getElementById('phase' + currentPhase).classList.remove('active');

                // Remove active from current step
                document.getElementById('step' + currentPhase).classList.remove('active');

                // Remove completed from previous line
                if (phase < 3) {
                    document.getElementById('line' + phase).classList.remove('completed');
                }

                // Show previous phase
                currentPhase = phase;
                document.getElementById('phase' + currentPhase).classList.add('active');

                // Remove completed and add active to previous step
                document.getElementById('step' + currentPhase).classList.remove('completed');
                document.getElementById('step' + currentPhase).classList.add('active');
            }

            function togglePassword(inputId, eyeIconId, eyeSlashIconId) {
                const passwordInput = document.getElementById(inputId);
                const eyeIcon = document.getElementById(eyeIconId);
                const eyeSlashIcon = document.getElementById(eyeSlashIconId);

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    eyeIcon.classList.add('hidden');
                    eyeSlashIcon.classList.remove('hidden');
                } else {
                    passwordInput.type = 'password';
                    eyeIcon.classList.remove('hidden');
                    eyeSlashIcon.classList.add('hidden');
                }
            }

            function showLoading(event) {
                if (!validatePhase(3)) {
                    event.preventDefault();
                    return false;
                }

                document.getElementById('signupTitle').style.display = 'none';
                document.getElementById('stepIndicator').style.display = 'none';
                document.getElementById('signupForm').style.display = 'none';
                document.getElementById('signInLink').style.display = 'none';
                document.getElementById('loadingTitle').classList.add('active');
                document.getElementById('loadingContainer').classList.add('active');

                return true;
            }
        </script>
    </body>

    </html>