# 2>NUL & @CLS & PUSHD "%~dp0" & "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -nol -nop -ep bypass "[IO.File]::ReadAllText('%~f0')|iex" & POPD & EXIT /B

# Print a message to indicate the script is starting
Write-Host "Starting the setup process..."

# Check if Python is installed
if (-not (python --version 2>&1)) {
    # Inform the user that Python is not found
    Write-Host "Python not found."

    # Check if Chocolatey is installed
    if (-not (Test-Path -Path "C:\ProgramData\chocolatey\bin\choco.exe")) {
        # Inform the user that Chocolatey is not found and it will be installed
        Write-Host "Chocolatey not found. Installing Chocolatey..."

        # Download and install Chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force; 
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

    # Install Python via Chocolatey
    Write-Host "Installing Python via Chocolatey..."
    choco install python -y
}

# Check if Python is installed after attempting installation
if (-not (python --version 2>&1)) {
    # Inform the user that Python installation failed
    Write-Host "Python installation failed. Exiting script..."
    exit
}

# Inform the user that Git is being checked
Write-Host "Checking if Git is installed..."

# Check if Git is installed
if (-not (Test-Path -Path "C:\Program Files\Git\cmd\git.exe")) {
    # Inform the user that Git is not found and it will be installed
    Write-Host "Git not found. Installing Git..."

    # Download and install Git
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.1/Git-2.35.1-64-bit.exe" -OutFile "$env:TEMP\git-installer.exe"
    Start-Process -FilePath "$env:TEMP\git-installer.exe" -ArgumentList "/VERYSILENT /NORESTART" -Wait
}

# Inform the user that the repository is being cloned
Write-Host "Cloning the repository..."

# Clone the repository
git clone https://github.com/NoorFatimaAfzal/Accord.git

# Change directory to the cloned repository
cd Accord

# Inform the user that Python packages are being installed
Write-Host "Installing required Python packages..."

# Install required Python packages
pip install -r requirements.txt

# Inform the user that the project is being run
Write-Host "Running the project..."

# Run the specified file
python "account pages\loading.py"

# Inform the user that the script has finished
Write-Host "Setup completed successfully!"