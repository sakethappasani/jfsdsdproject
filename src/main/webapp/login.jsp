<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ActivityHub</title>
    <link rel="stylesheet" href="logland.css">
</head>
<body>
    <div class="login-container">
        <!-- Left Image Section -->
        <div class="login-image">
            <img src="https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&q=80" alt="Students collaborating">
            <div class="image-overlay"></div>
        </div>

        <!-- Right Login Section -->
        <div class="login-form-container fade-in">
            <a href="/" class="back-link">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
                Back to Home
            </a>

            <div class="login-form-content">
                <h2>Welcome Back!</h2>
                <p>Please sign in to your account</p>

                <form class="login-form"method="post" action="checklogin">
                    <div class="form-group">
                        <label for="uname">Username</label>
                        <input type="text" id="uname" name="uname" placeholder="Enter your Username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="pwd" placeholder="Enter your password" required>
                    </div>

                    <button type="submit" class="login-button">Sign In</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>