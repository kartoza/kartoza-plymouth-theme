#!/usr/bin/env bash

# Colors and styling
CYAN='\033[38;2;83;161;203m'
GREEN='\033[92m'
RED='\033[91m'
RESET='\033[0m'
ORANGE='\033[38;2;237;177;72m'
GRAY='\033[90m'
# Clear screen and show welcome banner
clear
echo -e "$RESET$ORANGE"
# Kartoza Logo Banner using chafa
chafa ./img/KartozaNixOS.png --size=30x80 --colors=256 | sed 's/^/                  /'
# Quick tips with icons
echo -e "$RESET$ORANGE \n__________________________________________________________________\n"
echo -e "Quick Commands:$RESET"
echo -e "   $GRAY▶$RESET  $CYAN nix build .#kartoza-plymouth$RESET - build the package"
echo -e "   $GRAY▶$RESET  $CYAN nix flake show$RESET               - Show available configurations"
echo -e "   $GRAY▶$RESET  $CYAN nix flake check$RESET              - Run all checks"
echo -e "$RESET$ORANGE \n__________________________________________________________________\n"
if command -v pre-commit &>/dev/null; then
    echo -e "${ORANGE}Running pre-commit checks...${RESET}"
    # Verify key tools are available before running pre-commit
    if command -v markdownlint &>/dev/null && command -v shellcheck &>/dev/null; then
        pre-commit run --all-files
    else
        echo -e "${RED}Some pre-commit tools not yet available. Skipping checks.${RESET}"
    fi
else
    echo -e "${RED}pre-commit not found. Skipping checks.${RESET}"
fi
echo -e "$RESET$ORANGE \n__________________________________________________________________\n"
# Animated status indicator
animate_success_message() {
    local message="           ✅ Environment activated! Happy coding! 🎉          "
    local width
    width=$(tput cols 2>/dev/null || echo 80)
    local msg_length=${#message}

    # Clear the line
    printf "\r%*s\r" "$width" ""

    # Stage 1: Animate hyphens from left
    for ((i = 1; i <= msg_length; i++)); do
        printf "\r${CYAN}%s${RESET}" "$(printf '%*s' "$i" "" | tr ' ' '-')"
        sleep 0.01
    done

    # Stage 2: Replace hyphens with slashes
    for ((i = 1; i <= msg_length; i++)); do
        local hyphens
        local slashes
        hyphens="$(printf '%*s' $((msg_length - i)) "" | tr ' ' '-')"
        slashes="$(printf '%*s' "$i" "" | tr ' ' '/')"
        printf "\r${ORANGE}%s${CYAN}%s${RESET}" "$slashes" "$hyphens"
        sleep 0.01
    done

    # Stage 3: Replace slashes with actual message
    for ((i = 1; i <= msg_length; i++)); do
        local slashes
        slashes="$(printf '%*s' $((msg_length - i)) "" | tr ' ' '/')"
        printf "\r${GREEN}%s${ORANGE}%s${RESET}" "${message:0:i}" "$slashes"
        sleep 0.01
    done

    echo
}

