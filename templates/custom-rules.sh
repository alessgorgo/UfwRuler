#!/bin/bash

apply_custom_rules() {
    echo -e "${BLUE}Custom Rules Menu${NC}"
    echo "1) MySQL Database Server"
    echo "2) PostgreSQL Database Server"
    echo "3) Game Server (Common Ports)"
    echo "4) VPN Server (OpenVPN)"
    echo "0) Back"
    echo ""
    read -p "Select preset (1-4): " preset_choice
    
    case $preset_choice in
        1)
            # MySQL
            ufw allow 3306/tcp
            echo -e "${GREEN}MySQL port 3306 allowed${NC}"
            ;;
        2)
            # PostgreSQL
            ufw allow 5432/tcp
            echo -e "${GREEN}PostgreSQL port 5432 allowed${NC}"
            ;;
        3)
            # Game Server common ports
            ufw allow 25565/tcp  # Minecraft
            ufw allow 27015/tcp  # Steam
            ufw allow 27015/udp
            ufw allow 27020/tcp # Source engine
            ufw allow 27020/udp
            echo -e "${GREEN}Common game server ports allowed${NC}"
            ;;
        4)
            # OpenVPN
            read -p "Enter OpenVPN port (default 1194): " port
            port=${port:-1194}
            ufw allow $port/udp
            echo -e "${GREEN}OpenVPN port $port/udp allowed${NC}"
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