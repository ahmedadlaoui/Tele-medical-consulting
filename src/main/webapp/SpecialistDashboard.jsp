<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Specialist Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>

<body class="bg-white min-h-screen">
    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto text-center">
            <h1 class="text-4xl font-bold text-gray-800 mb-4">Specialist Dashboard</h1>
            <p class="text-gray-600 text-lg">Welcome, <%= session.getAttribute("userName") %></p>
            <div class="mt-8">
                <a href="${pageContext.request.contextPath}/logout"
                    class="inline-block px-6 py-3 text-white font-medium rounded-md hover:opacity-90"
                    style="background-color: #DE6143;">
                    Logout
                </a>
            </div>
        </div>
    </div>
</body>

</html>
