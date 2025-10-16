#!/bin/bash

# Helper script to copy a large folder to this repository
# Usage: ./copy-folder.sh <source-path> <destination-name>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check arguments
if [ $# -ne 2 ]; then
    print_error "Usage: $0 <source-path> <destination-name>"
    echo "Example: $0 /path/to/your/folder my-data"
    exit 1
fi

SOURCE_PATH="$1"
DEST_NAME="$2"

# Validate source path
if [ ! -d "$SOURCE_PATH" ]; then
    print_error "Source path does not exist or is not a directory: $SOURCE_PATH"
    exit 1
fi

# Get repository root
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST_PATH="$REPO_ROOT/$DEST_NAME"

print_info "Repository root: $REPO_ROOT"
print_info "Source: $SOURCE_PATH"
print_info "Destination: $DEST_PATH"

# Check if destination already exists
if [ -d "$DEST_PATH" ]; then
    print_warning "Destination already exists: $DEST_PATH"
    read -p "Do you want to continue and merge/overwrite? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Operation cancelled"
        exit 0
    fi
fi

# Check source size
print_info "Calculating source size..."
SOURCE_SIZE=$(du -sh "$SOURCE_PATH" | cut -f1)
FILE_COUNT=$(find "$SOURCE_PATH" -type f | wc -l)
print_info "Source size: $SOURCE_SIZE"
print_info "File count: $FILE_COUNT"

# Check for large files (>50MB)
print_info "Checking for large files (>50MB)..."
LARGE_FILES=$(find "$SOURCE_PATH" -type f -size +50M 2>/dev/null || true)
if [ -z "$LARGE_FILES" ]; then
    LARGE_FILE_COUNT=0
else
    LARGE_FILE_COUNT=$(echo "$LARGE_FILES" | wc -l)
fi

if [ "$LARGE_FILE_COUNT" -gt 0 ]; then
    print_warning "Found $LARGE_FILE_COUNT file(s) larger than 50MB"
    echo "$LARGE_FILES" | head -10
    if [ "$LARGE_FILE_COUNT" -gt 10 ]; then
        print_warning "... and $(($LARGE_FILE_COUNT - 10)) more"
    fi
    
    # Check if Git LFS is available
    if command -v git-lfs &> /dev/null; then
        print_warning "Git LFS is installed. Consider tracking large files."
        print_info "You can set up LFS with: git lfs track '*.ext'"
    else
        print_warning "Git LFS is NOT installed. Large files may cause issues."
        print_info "Install Git LFS: https://git-lfs.github.com/"
    fi
    
    read -p "Do you want to continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Operation cancelled"
        print_info "Please install Git LFS and configure it before copying large files"
        exit 0
    fi
fi

# Copy files
print_info "Copying files..."
if command -v rsync &> /dev/null; then
    print_info "Using rsync for better progress tracking..."
    # Ensure destination directory exists
    mkdir -p "$DEST_PATH"
    rsync -av --progress "$SOURCE_PATH/" "$DEST_PATH/"
else
    print_info "Using cp (rsync not available)..."
    # cp -r will create the destination directory
    cp -r "$SOURCE_PATH" "$DEST_PATH"
fi

print_info "Copy completed!"

# Git operations
print_info "Checking git status..."
cd "$REPO_ROOT"

# Show what will be added
print_info "Files to be added:"
git status --short "$DEST_NAME" | head -20
TOTAL_NEW=$(git status --short "$DEST_NAME" | wc -l)
if [ "$TOTAL_NEW" -gt 20 ]; then
    print_warning "... and $(($TOTAL_NEW - 20)) more files"
fi

# Ask for confirmation
read -p "Do you want to add these files to git? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_info "Files copied but not added to git"
    print_info "You can manually add them with: git add $DEST_NAME/"
    exit 0
fi

# Add to git
print_info "Adding files to git..."
git add "$DEST_NAME/"

# Ask for commit message
read -p "Enter commit message (or press Enter for default): " COMMIT_MSG
if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Add folder: $DEST_NAME"
fi

print_info "Creating commit..."
git commit -m "$COMMIT_MSG"

# Ask about pushing
read -p "Do you want to push to remote? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "Pushing to remote..."
    git push
    print_info "Successfully pushed to remote!"
else
    print_info "Commit created locally. Push later with: git push"
fi

print_info "Done! Folder successfully copied to repository."
