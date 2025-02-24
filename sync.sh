#!/bin/bash
eval "$(ssh-agent -s)"
# Variables
BITWIG_PRESETS_DIR="$HOME/Documents/Bitwig Studio/Library/Presets" # Path to your Bitwig presets folder
GIT_REPO_PATH="$HOME/repos/bitwig-presets" # Local clone of your GitHub repo
COMMIT_MSG="Sync Bitwig presets on $(date +'%Y-%m-%d %H:%M:%S')"
REMOTE="origin" # Remote name for your GitHub repo
BRANCH="main"   # Default branch (adjust if your default branch is different)

# Colors for messages
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Navigate to the Git repository
echo -e "${GREEN}Navigating to Git repository...${NC}"
cd "$GIT_REPO_PATH" || { echo -e "${RED}Failed to navigate to Git repository.${NC}"; exit 1; }

# Pull the latest changes from the remote repository
echo -e "${GREEN}Pulling latest changes from $REMOTE/$BRANCH...${NC}"
git pull "$REMOTE" "$BRANCH" || { echo -e "${RED}Failed to pull changes.${NC}"; exit 1; }

# Synchronize files
echo -e "${GREEN}Syncing Bitwig presets...${NC}"
rsync -av --exclude=".git/" "$BITWIG_PRESETS_DIR/" "$GIT_REPO_PATH/" || { echo -e "${RED}Failed to sync files.${NC}"; exit 1; }

# Check Git status
echo -e "${GREEN}Checking Git status...${NC}"
git status

# Add changes to Git
echo -e "${GREEN}Adding changes to Git...${NC}"
git add . || { echo -e "${RED}Failed to add changes.${NC}"; exit 1; }

# Commit changes
echo -e "${GREEN}Committing changes...${NC}"
git commit -m "$COMMIT_MSG" || { echo -e "${RED}No changes to commit.${NC}"; exit 0; }

# Push changes to GitHub
echo -e "${GREEN}Pushing changes to $REMOTE/$BRANCH...${NC}"
git push "$REMOTE" "$BRANCH" || { echo -e "${RED}Failed to push changes.${NC}"; exit 1; }

echo -e "${GREEN}Sync completed successfully!${NC}"
