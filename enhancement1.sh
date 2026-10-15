#!/bin/bash
# Enhancement 1: Effective SSH Configuration Audit

CONFIG=$(sudo sshd -T 2>/dev/null) || {
    echo "ERROR: Could not evaluate SSH configuration."
    exit 1
}

echo "=== SSH CONFIGURATION SECURITY AUDIT ==="

for setting in permitrootlogin passwordauthentication maxauthtries; do
    value=$(awk -v key="$setting" '$1 == key {print $2; exit}' <<< "$CONFIG")
    printf "%-25s %s\n" "$setting" "${value:-UNKNOWN}"
done

echo
echo "Audit complete."
