# attack_tester.sh

## Description

`attack_tester.sh` is a bash script designed for security testing and attack simulations. It automates the process of installing necessary tools, scanning network IPs, selecting targets, and executing various types of attacks, including brute force, MITM, and DDoS attacks.

## Prerequisites

- Ensure you have `sudo` privileges to run the script.
- The script installs and uses the following tools:
  - `hydra`
  - `arp-scan`
  - `ettercap-text-only`
  - `hping3`

## Usage

1. **Run the script as root:**

    ```bash
    sudo ./attack_tester.sh
    ```

2. **Follow the prompts to:**
   - Update the system.
   - Install required tools.
   - Scan and select an active IP on the network.
   - Choose or provide a password and user list.
   - Select the type of attack to perform.

## Features

- **System Update:** Checks and installs updates.
- **Tool Installation:** Installs `hydra`, `arp-scan`, `ettercap-text-only`, and `hping3` if not already present.
- **Network Scanning:** Uses `arp-scan` to identify active IP addresses on the local network.
- **Brute Force Attacks:** Supports FTP, SSH, Telnet, and RDP brute force attacks using `hydra`.
- **MITM Attack:** Executes a MITM attack using `ettercap`.
- **DDoS Attack:** Performs a DDoS attack using `hping3`.
- **Logging:** Logs attack details in `/var/log/attack_tester/attacker.log`.

## Attack Types

1. **FTP Brute Force Attack:** Attempts to crack FTP credentials through repeated guessing.
2. **SSH Brute Force Attack:** Attempts to access SSH by guessing passwords repeatedly.
3. **Telnet Brute Force Attack:** Tries to break into Telnet by repeatedly guessing user credentials.
4. **RDP Brute Force Attack:** Repeatedly attempts to penetrate RDP to gain control.
5. **MITM Attack:** Intercepts communications between two parties to steal or manipulate data.
6. **DDoS Attack:** Overwhelms a target with traffic to disrupt service.
7. **Random Attack:** Chooses any of the above attacks at random.

## Configuration

- **User and Password Lists:**
  - You can choose to provide custom user and password lists or use the default lists located in the `list` directory.

## Note

This script is intended for educational and testing purposes only. Use responsibly and with permission.
