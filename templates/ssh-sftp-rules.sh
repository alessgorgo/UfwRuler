#!/bin/bash

apply_ssh_sftp_rules() {
    echo -e "${BLUE}Applying SSH/SFTP Only Rules${NC}"
    
    # Allow SSH
    ufw allow 22/tcp
    
    # Allow SFTP (uses SSH port)
    
    # Deny all other incoming
    ufw default deny incoming
    
    # Allow all outgoing
    ufw default allow outgoing
    
    echo -e "${GREEN}SSH/SFTP only rules applied${NC}"
    sleep 2
}