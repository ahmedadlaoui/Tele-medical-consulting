<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Login - Hospital Medical Consulting System</title>
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

      .floating-input {
        width: 100%;
        padding: 0.625rem 1rem;
        border: 1px solid #9ca3af;
        background-color: white;
        color: #111827;
        font-size: 0.875rem;
        border-radius: 4px;
        transition: border-color 0.2s ease;
      }

      .floating-input:focus {
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
      .floating-input:not(:placeholder-shown)~.floating-label {
        top: -0.5rem;
        font-size: 0.75rem;
        color: #DE6143;
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
              Consult, connect, and collaborate with general practitioners, specialists, and nurses to deliver
              exceptional patient care
            </p>
          </div>
        </div>
      </div>

      <!-- Right Side - Login Form Section (35%) -->
      <div class="w-full lg:w-[35%] flex items-center justify-center px-8" style="background-color: #FEFDFB;">
        <div class="w-full max-w-sm">

          <!-- Logo -->
          <div class="flex justify-center mb-6">
            <img src="${pageContext.request.contextPath}/assets/images/logo_consulting-removebg-preview.png"
              alt="Medical Consulting Logo" class="h-20 w-20 object-contain">
          </div>

          <!-- Login Title -->
          <div class="text-center mb-8">
            <h2 class="text-xl font-normal text-gray-700" style="font-family: 'Poppins', sans-serif;">Sign in</h2>
          </div>

          <!-- Login Form -->
          <form action="${pageContext.request.contextPath}/login" method="post">

            <!-- Email Field with Floating Label -->
            <div class="floating-label-container">
              <input type="email" id="email" name="email" class="floating-input" placeholder=" " required
                autocomplete="email">
              <label for="email" class="floating-label">Email Address</label>
            </div>

            <!-- Password Field with Floating Label -->
            <div class="floating-label-container">
              <div class="relative">
                <input type="password" id="password" name="password" class="floating-input" placeholder=" " required
                  autocomplete="current-password">
                <label for="password" class="floating-label">Password</label>
                <button type="button" onclick="togglePassword()"
                  class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-500 hover:text-gray-700">
                  <svg id="eyeIcon" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                  </svg>
                  <svg id="eyeSlashIcon" class="w-4 h-4 hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
                  </svg>
                </button>
              </div>
            </div>

            <!-- Remember Me & Forgot Password -->
            <div class="flex items-center justify-between text-sm mb-6">
              <label class="flex items-center gap-2 cursor-pointer">
                <input type="checkbox" id="remember" name="remember" class="w-3.5 h-3.5 border-gray-400"
                  style="accent-color: #DE6143;">
                <span class="text-gray-700 text-sm">Remember me</span>
              </label>
              <a href="#" class="font-normal text-sm" style="color: #DE6143;">
                Forgot password?
              </a>
            </div>

            <!-- Submit Button -->
            <button type="submit"
              class="w-full text-white py-2.5 text-sm font-medium hover:opacity-90 focus:outline-none"
              style="background-color: #DE6143; border-radius: 4px;">
              Sign In
            </button>
          </form>

          <!-- Sign Up Link -->
          <div class="mt-4 text-center">
            <p class="text-sm text-gray-600">
              Don't have an account?
              <a href="${pageContext.request.contextPath}/signup" class="font-medium" style="color: #DE6143;">Sign
                up</a>
            </p>
          </div>

          <!-- Footer Note -->
          <div class="mt-8">
            <p class="text-xs text-gray-600 text-center">
              Authorized hospital staff only. All access is monitored and logged.
            </p>
          </div>
        </div>
      </div>
    </div>

    <script>
      function togglePassword() {
        const passwordInput = document.getElementById('password');
        const eyeIcon = document.getElementById('eyeIcon');
        const eyeSlashIcon = document.getElementById('eyeSlashIcon');

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
    </script>
  </body>

  </html>