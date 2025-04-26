#!/bin/bash

apply_smtp_rules() {
    echo -e "${BLUE}Applying SMTP Mail Server Rules${NC}"
    
    # Allow SSH for management
    ufw allow 22/tcp
    
    # SMTP ports
    ufw allow 25/tcp    # SMTP
    ufw allow 465/tcp   # SMTPS
    ufw allow 587/tcp   # Submission
    
    # IMAP/POP3
    ufw allow 143/tcp   # IMAP
    ufw allow 993/tcp   # IMAPS
    ufw allow 110/tcp   # POP3
    ufw allow 995/tcp   # POP3S
    
    echo -e "${GREEN}SMTP mail server rules applied${NC}"
    sleep 2
}