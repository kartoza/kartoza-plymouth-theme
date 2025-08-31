#!/usr/bin/env bash

GREEN='\033[92m'
RED='\033[91m'
# Colors for output
NC='\033[0m' # No Color

echo -e "${GREEN}Package Setup Script${NC}"
echo "====================="
echo

# Check if gum is available
if ! command -v gum &>/dev/null; then
    echo -e "${RED}Error: gum is not installed. Please install gum first.${NC}"
    echo "You can install it with: nix-env -iA nixpkgs.gum"
    exit 1
fi

# Prompt for package name
PACKAGE_NAME=$(gum input --placeholder "Enter the package name...")
if [ -z "$PACKAGE_NAME" ]; then
    echo -e "${RED}Error: Package name cannot be empty${NC}"
    exit 1
fi

# Prompt for package description
PACKAGE_DESCRIPTION=$(gum input --placeholder "Enter the package description...")
if [ -z "$PACKAGE_DESCRIPTION" ]; then
    echo -e "${RED}Error: Package description cannot be empty${NC}"
    exit 1
fi

echo
gum style --foreground 83 --bold "Package Name:" " $PACKAGE_NAME"
gum style --foreground 237 --bold "Package Description:" " $PACKAGE_DESCRIPTION"
echo

# Confirm before proceeding
if ! gum confirm "Do you want to proceed with these values?"; then
    echo "Operation cancelled."
    exit 0
fi

echo
echo "Searching for files containing placeholders..."

# Find all files containing the placeholders (excluding this script and .git directory)
FILES_WITH_PLACEHOLDERS=$(grep -r -l "\[PACKAGE NAME\]\|\[PACKAGE DESCRIPTION\]" . \
    --exclude="$(basename "$0")" \
    --exclude-dir=".git" \
    --exclude-dir=".svn" \
    --exclude-dir=".hg" 2>/dev/null)

if [ -z "$FILES_WITH_PLACEHOLDERS" ]; then
    gum style --foreground 196 "No files found containing [PACKAGE NAME] or [PACKAGE DESCRIPTION] placeholders."
    exit 0
fi

echo "Found files with placeholders:"
echo "$FILES_WITH_PLACEHOLDERS" | while read -r file; do
    echo "  - $file"
done
echo

# Create backup directory
BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "Creating backups in: $BACKUP_DIR"

# Process each file
PROCESSED_COUNT=0
echo "$FILES_WITH_PLACEHOLDERS" | while read -r file; do
    if [ -f "$file" ]; then
        # Create backup
        cp "$file" "$BACKUP_DIR/$(basename "$file")"

        # Replace placeholders
        sed -i "s/\[PACKAGE NAME\]/$PACKAGE_NAME/g" "$file"
        sed -i "s/\[PACKAGE DESCRIPTION\]/$PACKAGE_DESCRIPTION/g" "$file"

        echo "  ✓ Processed: $file"
        PROCESSED_COUNT=$((PROCESSED_COUNT + 1))
    fi
done

echo

# Handle packages/PACKAGE_NAME folder rename and update
PACKAGE_TEMPLATE_DIR="./packages/PACKAGE_NAME"
NEW_PACKAGE_DIR="./packages/$PACKAGE_NAME"

if [ -d "$PACKAGE_TEMPLATE_DIR" ]; then
    echo "Processing package template directory..."

    # Create backup of the template directory
    cp -r "$PACKAGE_TEMPLATE_DIR" "$BACKUP_DIR/"

    # Move/rename the directory using git mv
    if git status &>/dev/null; then
        echo "  ✓ Using git mv to rename package directory"
        git mv "$PACKAGE_TEMPLATE_DIR" "$NEW_PACKAGE_DIR"
    else
        echo "  ✓ Renaming package directory (not a git repository)"
        mv "$PACKAGE_TEMPLATE_DIR" "$NEW_PACKAGE_DIR"
    fi

    # Update default.nix in the renamed package directory
    if [ -f "$NEW_PACKAGE_DIR/default.nix" ]; then
        echo "  ✓ Updating $NEW_PACKAGE_DIR/default.nix"
        sed -i "s/\[PACKAGE NAME\]/$PACKAGE_NAME/g" "$NEW_PACKAGE_DIR/default.nix"
        sed -i "s/\[PACKAGE DESCRIPTION\]/$PACKAGE_DESCRIPTION/g" "$NEW_PACKAGE_DIR/default.nix"
        # Also replace any remaining PACKAGE_NAME references
        sed -i "s/PACKAGE_NAME/$PACKAGE_NAME/g" "$NEW_PACKAGE_DIR/default.nix"
    fi

    # Update README.md in the renamed package directory
    if [ -f "$NEW_PACKAGE_DIR/README.md" ]; then
        echo "  ✓ Updating $NEW_PACKAGE_DIR/README.md"
        sed -i "s/\[PACKAGE NAME\]/$PACKAGE_NAME/g" "$NEW_PACKAGE_DIR/README.md"
        sed -i "s/\[PACKAGE DESCRIPTION\]/$PACKAGE_DESCRIPTION/g" "$NEW_PACKAGE_DIR/README.md"
    fi

    echo "  ✓ Package directory renamed to: $NEW_PACKAGE_DIR"
else
    echo "  ⚠ Package template directory not found: $PACKAGE_TEMPLATE_DIR"
fi

echo
gum style --foreground 237 --bold "Successfully processed files!"
echo "Backups saved to: $BACKUP_DIR"
echo
gum style --bold "Summary:"
echo "  - Package Name: '$PACKAGE_NAME'"
echo "  - Package Description: '$PACKAGE_DESCRIPTION'"
echo "  - Files processed: Check above output"
if [ -d "$NEW_PACKAGE_DIR" ]; then
    echo "  - Package directory: $NEW_PACKAGE_DIR"
fi
echo
gum style --foreground 244 "Note: If you need to undo these changes, restore from the backup directory."
