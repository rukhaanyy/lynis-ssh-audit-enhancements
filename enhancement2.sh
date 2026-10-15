
#!/bin/bash
# Enhancement 2: Risk-Ranked SSH Audit

set -u

CONFIG=$(sudo sshd -T 2>/dev/null) || {
    echo "ERROR: Could not evaluate SSH configuration."
    exit 1
}

get_setting() {
    awk -v key="$1" '$1 == key {print $2; exit}' <<< "$CONFIG"
}

score=0

echo "=== RISK-RANKED SSH SECURITY AUDIT ==="

root_login=$(get_setting permitrootlogin)
password_auth=$(get_setting passwordauthentication)
max_tries=$(get_setting maxauthtries)

echo
echo "1. Root login: ${root_login:-UNKNOWN}"
case "$root_login" in
    yes)
        echo "Risk: HIGH — Direct root login is permitted."
        echo "Recommendation: Consider disabling direct root SSH login."
        score=$((score + 3))
        ;;
    prohibit-password|forced-commands-only|no)
        echo "Risk: LOWER — Password-based root login is restricted."
        ;;
    *)
        echo "Risk: UNKNOWN — Review the effective root login policy."
        ;;
esac

echo
echo "2. Password authentication: ${password_auth:-UNKNOWN}"
if [[ "$password_auth" == "yes" ]]; then
    echo "Risk: REVIEW — Password authentication is enabled."
    echo "Recommendation: Consider key-based authentication where appropriate."
    score=$((score + 2))
elif [[ "$password_auth" == "no" ]]; then
    echo "Risk: LOWER — Password authentication is disabled."
else
    echo "Risk: UNKNOWN — Verify the effective setting."
fi

echo
echo "3. Maximum authentication attempts: ${max_tries:-UNKNOWN}"
if [[ "$max_tries" =~ ^[0-9]+$ ]]; then
    if (( max_tries > 4 )); then
        echo "Risk: MEDIUM — The configured limit exceeds this audit's threshold."
        echo "Recommendation: Consider a lower limit, such as 4."
        score=$((score + 2))
    else
        echo "Risk: LOWER — The configured limit meets this audit's threshold."
    fi
else
    echo "Risk: UNKNOWN — Could not determine the attempt limit."
fi

echo
echo "Custom risk score: $score"
echo "Note: This score is a demonstration metric, not an official Lynis score."

