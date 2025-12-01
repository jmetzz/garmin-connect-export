#!/bin/bash
# Setup script to add Garmin export alias to your shell configuration

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ALIAS_LINE="alias garmin-export='python ${SCRIPT_DIR}/gcexport.py'"

# Detect shell configuration file
if [ -f ~/.bash_profile ]; then
    SHELL_RC=~/.bash_profile
elif [ -f ~/.bashrc ]; then
    SHELL_RC=~/.bashrc
elif [ -f ~/.zshrc ]; then
    SHELL_RC=~/.zshrc
else
    echo "Could not find shell configuration file (.bash_profile, .bashrc, or .zshrc)"
    echo "Please manually add this line to your shell configuration:"
    echo "$ALIAS_LINE"
    exit 1
fi

# Check if alias already exists
if grep -q "alias garmin-export=" "$SHELL_RC"; then
    echo "Alias 'garmin-export' already exists in $SHELL_RC"
    echo "Updating it..."
    # Remove old alias and add new one
    grep -v "alias garmin-export=" "$SHELL_RC" > "${SHELL_RC}.tmp"
    mv "${SHELL_RC}.tmp" "$SHELL_RC"
fi

# Add the alias
echo "" >> "$SHELL_RC"
echo "# Garmin Connect Export alias" >> "$SHELL_RC"
echo "$ALIAS_LINE" >> "$SHELL_RC"

echo "✓ Alias added to $SHELL_RC"
echo ""
echo "To use it immediately, run:"
echo "  source $SHELL_RC"
echo ""
echo "Or open a new terminal window."
echo ""
echo "Usage examples:"
echo "  garmin-export --count 10"
echo "  garmin-export --count all -f original -u"
echo ""
echo "Optional: Set environment variables for credentials (more secure):"
echo "  export GARMIN_USERNAME='your_username'"
echo "  export GARMIN_PASSWORD='your_password'"
