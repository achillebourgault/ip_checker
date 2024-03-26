#!/bin/bash

print_time() {
    echo "$(date '+(%H:%M:%S | %d/%m/%y)')"
}

# Help
show_help() {
    echo "Usage: ip_checker.sh [-t <seconds>] [-h]"
    echo " -t or --time <number>: Interval in seconds to check the IP. Without this option, only display the public IP."
    echo " -h or --help: Display this help message."
}

# Check if curl is installed
command -v curl >/dev/null 2>&1 || { echo >&2 "This script requires 'curl' but it's not installed.  Aborting."; exit 1; }

time_interval=0
current_ip=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -t|--time) time_interval="$2"; shift ;;
        -h|--help) show_help; exit ;;
        *) echo "Unknown option: $1" >&2; show_help; exit 1 ;;
    esac
    shift
done

get_public_ip() {
    echo $(curl -s https://ipinfo.io/ip)
}

spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Display the IP once at the start
current_ip=$(get_public_ip)
echo "$(print_time) Your public IP is: $current_ip"

# Loop to check the IP at regular intervals
if [[ $time_interval -ne 0 ]]; then
    while true; do
        (sleep "$time_interval" & spinner)

        new_ip=$(get_public_ip)

        # Every 30 minutes, display a message
        if [[ $(($(date +%s) % 1800)) -lt $time_interval ]]; then
            echo "$(print_time) Pinging $(hostname) to stay awake.."
            echo "No IP update\n\n$new_ip\n\n"
        fi

        # Check if the IP has changed
        if [[ "$new_ip" != "$current_ip" ]]; then
            echo "$(print_time) Public IP changed!\nNew IP: $new_ip \n"
            current_ip=$new_ip
        fi
    done
fi

