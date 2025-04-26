#!/bin/bash

apply_web_rules() {
    echo -e "${BLUE}Applying Web Server Rules${NC}"
    
    # Allow SSH for management
    ufw allow 22/tcp
    
    # Web ports
    ufw allow 80/tcp    # HTTP
    ufw allow 443/tcp   # HTTPS
    
    # Common web-related ports
    ufw allow 21/tcp    # FTP
    ufw allow 53/tcp    # DNS
    ufw allow 53/udp
    ufw allow 123/udp   # NTP
    
    echo -e "${GREEN}Web server rules applied${NC}"
    sleep 2
}