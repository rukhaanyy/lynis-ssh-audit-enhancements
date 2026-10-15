# Lynis SSH Security Auditing Enhancements

**Cyber Security**  
**Author:** Rukhaany Lakshmipathy  
**Institution:** Vellore Institute of Technology, Chennai

## 1. Project Overview

This project explores SSH security auditing in Kali Linux using Lynis and Bash scripting. It includes a reference copy of the Lynis SSH test script and two standalone Bash enhancements designed to make effective SSH configuration settings easier to inspect and interpret.

The first enhancement displays selected SSH settings, while the second adds custom risk classifications and recommendations.

## 2. Repository Contents

| File | Description |
|---|---|
| `tests_ssh_reference.sh` | Saved reference copy of the Lynis SSH test script |
| `enhancement1.sh` | Displays selected effective SSH configuration settings |
| `enhancement2.sh` | Classifies selected settings and provides recommendations |

## 3. Technologies Used

- Kali Linux
- Lynis security auditing tool
- Bash scripting
- OpenSSH
- GitHub

## 4. Enhancement 1: Effective SSH Configuration Display

**File:** `enhancement1.sh`

This script retrieves the effective SSH daemon configuration and displays three settings:

- `PermitRootLogin`
- `PasswordAuthentication`
- `MaxAuthTries`

### Execution

```bash
bash enhancement1.sh
```

### Observed Configuration

The script was previously tested in Kali Linux and returned these values:

```text
permitrootlogin       prohibit-password
passwordauthentication yes
maxauthtries           6
```

The values may differ on other systems.

## 5. Enhancement 2: Risk Classification and Recommendations

**File:** `enhancement2.sh`

This script examines the selected effective SSH settings and provides custom risk labels and recommendations.

Its features include:

- Reviewing root SSH login restrictions.
- Identifying whether password authentication is enabled.
- Reviewing the maximum number of authentication attempts.
- Calculating a custom demonstration risk score.

### Execution

```bash
bash enhancement2.sh
```

The previous test produced a custom demonstration risk score of `4`. The score is based on this script's own rules and is **not an official Lynis score**.

## 6. Running the Scripts

Open a Kali Linux terminal and navigate to the project directory:

```bash
cd ~/lynis-da3
```

Run the first enhancement:

```bash
bash enhancement1.sh
```

Run the second enhancement:

```bash
bash enhancement2.sh
```

To run the Lynis system audit separately:

```bash
sudo lynis audit system
```

The reference script belongs to the Lynis framework and may depend on framework functions. It should not be assumed to work independently outside that framework.

## 7. Security Considerations

These scripts are intended as auditing aids. They inspect configuration settings and provide recommendations but do not automatically modify the SSH configuration.

The security implications of each setting depend on the system's purpose, authentication requirements and security policy. The custom risk score is illustrative and should not be interpreted as an official security rating.

## 8. Learning Outcomes

This project demonstrates:

- Basic SSH security configuration analysis.
- Retrieving effective SSH daemon settings.
- Automating configuration checks using Bash.
- Interpreting selected authentication-related settings.
- Producing custom risk labels and recommendations.
- Organising and publishing security scripts using GitHub.

## 9. Acknowledgements

I would like to thank the School of Computer Science and Engineering (SCOPE), Vellore Institute of Technology, Chennai, and **Dr. T. Subbulakshmi, Professor, SCOPE, VIT Chennai**, for their guidance throughout the Cyber Security course.

I also acknowledge Michael Boelen, the founder of Lynis, and the Lynis contributors for maintaining this open-source security auditing tool.

---

*Academic project for Cyber Security DA3.*
