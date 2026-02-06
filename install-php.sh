#!/bin/bash

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if PHP is installed
check_php_installed() {
    if command -v php &> /dev/null; then
        PHP_VERSION=$(php --version | head -1 | cut -d' ' -f2)
        print_status "PHP is already installed (version: $PHP_VERSION)"
        return 0
    else
        print_warning "PHP is not installed"
        return 1
    fi
}

# Function to detect package manager and install PHP
install_php() {
    print_status "Attempting to install PHP..."

    # Store package manager for later use
    local PKG_MANAGER=""
    local INSTALL_CMD=""

    # Detect package manager
    if command -v apt-get &> /dev/null; then
        PKG_MANAGER="apt"
        INSTALL_CMD="sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
                     sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq php php-cli"
    elif command -v yum &> /dev/null; then
        PKG_MANAGER="yum"
        INSTALL_CMD="sudo yum install -y -q php"
    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
        INSTALL_CMD="sudo dnf install -y -q php"
    elif command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
        INSTALL_CMD="sudo pacman -Sy --noconfirm --needed php"
    elif command -v zypper &> /dev/null; then
        PKG_MANAGER="zypper"
        INSTALL_CMD="sudo zypper --non-interactive install -y php"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        PKG_MANAGER="brew"
        if command -v brew &> /dev/null; then
            INSTALL_CMD="brew install php"
        else
            print_error "Homebrew not found. Please install Homebrew first."
            return 1
        fi
    else
        print_error "Unsupported system. Cannot install PHP automatically."
        return 1
    fi

    print_status "Detected package manager: $PKG_MANAGER"
    print_status "Installing PHP..."

    # Execute installation command
    if eval "$INSTALL_CMD"; then
        print_status "PHP installation completed successfully"
        return 0
    else
        print_error "Failed to install PHP using $PKG_MANAGER"
        return 1
    fi
}

# Main script execution
main() {
    print_status "Starting PHP installation check..."

    if check_php_installed; then
        print_status "PHP is already installed. No action needed."
        exit 0
    else
        print_status "PHP not found. Proceeding with automatic installation..."
        if install_php; then
            # Verify installation after completion
            if check_php_installed; then
                print_status "PHP installation verified successfully"
                exit 0
            else
                print_error "PHP installation appears to have failed"
                exit 1
            fi
        else
            print_error "PHP installation failed"
            exit 1
        fi
    fi
}
main
