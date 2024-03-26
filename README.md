# IP Checker Script

## Introduction

I developed the `ip_checker.sh` script as a personal utility tool to address a specific need in my workflow. Working remotely, I often found myself connected to the internet via a mobile hotspot. This setup made me curious about the frequency of changes to my public IP address, especially since my company's VPN required IP validation. Monitoring my public IP became essential to ensure seamless access to work resources.

## Purpose

The primary purpose of this script is to monitor and log changes to the public IP address of a computer connected to the internet. It is particularly useful in situations where the internet connection is provided through a dynamic source, such as a mobile hotspot, where the IP address might change frequently.

## Features

- **Display Current Public IP:** The script fetches and displays the current public IP address of the machine.
- **Continuous Monitoring:** Option to set an interval for regularly checking the public IP address.
- **Change Notification:** Notifies the user if the public IP changes from the previous check.
- **Animated Loader:** Includes an animated spinner for better user interaction during wait times.

## How to Use

### Prerequisites

- Ensure `curl` is installed on your machine.
- The script is intended for use on macOS or Linux environments.

### Installation

1. Save the `ip_checker.sh` script on your computer.
2. Make the script executable: 
   ```bash
   chmod +x ip_checker.sh
   ```

### Usage

- To simply display the current public IP:
  ```bash
  ./ip_checker.sh
  ```
- To monitor IP changes at specified intervals (in seconds):
  ```bash
  ./ip_checker.sh -t <seconds>
  ```
- For help and usage instructions:
  ```bash
  ./ip_checker.sh -h
  ```

## Conclusion

This script has been a useful tool for me, especially in maintaining uninterrupted access to my company's VPN while working remotely with a dynamic IP address. I hope it can be equally beneficial for others facing similar situations.

---
