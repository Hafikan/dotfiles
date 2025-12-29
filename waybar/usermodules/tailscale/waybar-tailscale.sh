#!/usr/bin/env bash

# Tailscale durumu JSON formatında çek
status_json=$(tailscale status --json 2>/dev/null)

if [ $? -ne 0 ]; then
    echo '{"text": "TS ❌", "tooltip": "Tailscale not running", "class": "stopped"}'
    exit 0
fi

# Backend durumunu al (Running, Stopped, NeedsLogin)
backend_state=$(echo "$status_json" | jq -r '.BackendState')

# Self node'u bul
self=$(echo "$status_json" | jq -r '.Self')

# Tailscale IP adreslerini al
ips=$(echo "$self" | jq -r '.TailscaleIPs[]?' | tr '\n' ' ')

if [[ -z "$ips" ]]; then
    ips="No IP"
fi

# Duruma göre icon + class
case "$backend_state" in
    "Running")
        echo "{\"text\": \"󰖂 $ips\"}"
        ;;
    "NeedsLogin")
        echo "{\"text\": \"󰖂 ⛔ Not Logged In\"}"
        ;;
    "Stopped")
        echo "{\"text\": \"󰖂 ● Stopped\"}"
        ;;
    *)
        echo "{\"text\": \"󰖂 …\", \"tooltip\": \"State: $backend_state\", \"class\": \"unknown\"}"
        ;;
esac