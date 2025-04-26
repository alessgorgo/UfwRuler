#!/bin/bash

# Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}This script must be run as root${NC}"
    exit 1
fi

# Check if UFW is installed
if ! command -v ufw &> /dev/null; then
    echo -e "${RED}UFW is not installed. Please install it first.${NC}"
    exit 1
fi

# Function to display current UFW status
show_status() {
    clear
    echo -e "${BLUE}=== UFW Rules Status ===${NC}"
    echo ""
    
    # Show UFW status
    ufw_status=$(ufw status | grep "Status")
    if [[ $ufw_status == *"inactive"* ]]; then
        echo -e "${YELLOW}UFW is currently INACTIVE${NC}"
    else
        echo -e "${GREEN}UFW is ACTIVE${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}Current Rules:${NC}"
    ufw status numbered | tail -n +4
    
    echo ""
    echo -e "${BLUE}Allowed Ports:${NC}"
    ufw status | grep "ALLOW" | awk '{print $1}' | sort -u
    
    echo ""
    echo -e "${BLUE}Denied Ports:${NC}"
    ufw status | grep "DENY" | awk '{print $1}' | sort -u
    
    echo ""
}

# Function to apply a template
apply_template() {
    template_dir="$(dirname "$0")/templates"
    
    echo -e "${BLUE}Available Templates:${NC}"
    echo "1) SMTP Mail Server"
    echo "2) SSH/SFTP Only"
    echo "3) Web Server (HTTP/HTTPS)"
    echo "4) Custom Rules"
    echo "0) Back to main menu"
    echo ""
    read -p "Select template (1-4): " template_choice
    
    case $template_choice in
        1)
            source "$template_dir/smtp-rules.sh"
            apply_smtp_rules
            ;;
        2)
            source "$template_dir/ssh-sftp-rules.sh"
            apply_ssh_sftp_rules
            ;;
        3)
            source "$template_dir/web-rules.sh"
            apply_web_rules
            ;;
        4)
            source "$template_dir/custom-rules.sh"
            apply_custom_rules
            ;;
        0)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            sleep 1
            ;;
    esac
}

# Function to add custom rule
add_custom_rule() {
    echo -e "${BLUE}Add Custom Rule${NC}"
    echo "1) Allow a port"
    echo "2) Deny a port"
    echo "3) Allow from specific IP"
    echo "4) Deny from specific IP"
    echo "0) Back to main menu"
    echo ""
    read -p "Select option (1-4): " rule_choice
    
    case $rule_choice in
        1)
            read -p "Enter port number to allow (e.g., 22 or 80/tcp): " port
            ufw allow $port
            echo -e "${GREEN}Port $port allowed${NC}"
            ;;
        2)
            read -p "Enter port number to deny (e.g., 23 or 123/udp): " port
            ufw deny $port
            echo -e "${YELLOW}Port $port denied${NC}"
            ;;
        3)
            read -p "Enter IP address to allow (e.g., 192.168.1.100): " ip
            ufw allow from $ip
            echo -e "${GREEN}IP $ip allowed${NC}"
            ;;
        4)
            read -p "Enter IP address to deny (e.g., 192.168.1.100): " ip
            ufw deny from $ip
            echo -e "${YELLOW}IP $ip denied${NC}"
            ;;
        0)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
    
    sleep 2
}

# Function to delete a rule
delete_rule() {
    show_status
    echo -e "${BLUE}Delete Rule${NC}"
    echo ""
    read -p "Enter rule number to delete (or 0 to cancel): " rule_num
    
    if [ "$rule_num" -ne 0 ]; then
        ufw --force delete $rule_num
        echo -e "${GREEN}Rule $rule_num deleted${NC}"
        sleep 2
    fi
}

# Function to toggle UFW
toggle_ufw() {
    current_status=$(ufw status | grep "Status")
    
    if [[ $current_status == *"inactive"* ]]; then
        ufw --force enable
        echo -e "${GREEN}UFW has been enabled${NC}"
    else
        ufw disable
        echo -e "${YELLOW}UFW has been disabled${NC}"
    fi
    
    sleep 2
}

# Function to reset UFW
reset_ufw() {
    echo -e "${RED}=== WARNING ===${NC}"
    echo -e "${RED}This will reset ALL UFW rules to default${NC}"
    read -p "Are you sure? (y/n): " confirm
    
    if [ "$confirm" == "y" ]; then
        ufw --force reset
        echo -e "${GREEN}UFW has been reset to defaults${NC}"
    else
        echo -e "${YELLOW}Reset cancelled${NC}"
    fi
    
    sleep 2
}

# Main menu
while true; do
    show_status
    
    echo -e "${BLUE}Main Menu:${NC}"
    echo "1) Apply Template Rules"
    echo "2) Add Custom Rule"
    echo "3) Delete Rule"
    echo "4) Toggle UFW (Enable/Disable)"
    echo "5) Reset UFW to Defaults"
    echo "0) Exit"
    echo ""
    read -p "Select option (1-5): " main_choice
    
    case $main_choice in
        1)
            apply_template
            ;;
        2)
            add_custom_rule
            ;;
        3)
            delete_rule
            ;;
        4)
            toggle_ufw
            ;;
        5)
            reset_ufw
            ;;
        0)
            echo -e "${GREEN}Exiting UfwRuler${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            sleep 1
            ;;
    esac
done