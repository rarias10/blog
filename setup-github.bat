@echo off
echo Initializing Git repository...
git init
git add .
git commit -m "Initial commit: Blog microservices application"

echo.
echo Next steps:
echo 1. Create a new repository on GitHub
echo 2. Run: git remote add origin https://github.com/yourusername/your-repo-name.git
echo 3. Run: git branch -M main
echo 4. Run: git push -u origin main