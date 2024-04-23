#!/bin/bash

# Print a message to indicate the script is starting
echo "Starting the setup process..."

# Install Git if not already installed
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing Git..."
    sudo apt update
    sudo apt install git -y
fi

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/NoorFatimaAfzal/Accord.git

# Change directory to the cloned repository
cd Accord

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    # Install Python if not already installed
    echo "Python not found. Installing Python..."
    sudo apt update
    sudo apt install python3 -y
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    # Install pip if not already installed
    echo "Pip not found. Installing Pip..."
    sudo apt update
    sudo apt install python3-pip -y
fi

# Install required Python packages
echo "Installing required Python packages..."
pip3 install -r requirements.txt

# Run the specified file
echo "Running the project..."
python3 "Accord/account pages/loading.py"

# Print a message to indicate the script has finished
echo "Setup completed successfully!"
