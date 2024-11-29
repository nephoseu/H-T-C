# Variables
$HTMLFilePath = "C:\inetpub\wwwroot\index.html"
$HTMLContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HC Company Intranet</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #4CAF50;
            font-size: 2.5em;
        }
        p {
            color: #555555;
            font-size: 1.2em;
            margin-top: 10px;
        }
        footer {
            margin-top: 20px;
            color: #999999;
            font-size: 0.9em;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the HC Company Intranet Website</h1>
        <p>Your one-stop portal for all internal resources and updates.</p>
        <footer>
            &copy; 2024 HC Company | <a href="https://www.hccompany.local">Visit More Resources</a>
        </footer>
    </div>
</body>
</html>
"@

# Install IIS and management tools
Write-Host "Installing IIS with Management Tools..."
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Verify installation
if (!(Get-WindowsFeature -Name Web-Server).Installed) {
    Write-Host "IIS installation failed. Exiting script." -ForegroundColor Red
    exit
}

Write-Host "IIS installed successfully."

# Replace the default IIS welcome page
Write-Host "Replacing default IIS welcome page with a custom intranet page..."
if (Test-Path $HTMLFilePath) {
    Remove-Item -Path $HTMLFilePath -Force
}

Set-Content -Path $HTMLFilePath -Value $HTMLContent

# Restart IIS service to apply changes
Write-Host "Restarting IIS service..."
Restart-Service W3SVC

# Output completion message
Write-Host "IIS setup completed. Custom welcome page deployed successfully!" -ForegroundColor Green
