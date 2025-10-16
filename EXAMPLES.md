# Examples: Copying Folders to This Repository

This document provides real-world examples of copying folders to this repository.

## Example 1: Copying a Small Data Folder

**Scenario:** You have election data in `/home/user/election-data` that you want to add to this repository.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Copy the folder
cp -r /home/user/election-data ./election-data

# Check what was copied
ls -la ./election-data

# Add to git
git add election-data/
git commit -m "Add election data"
git push
```

## Example 2: Using the Helper Script

**Scenario:** Same as above, but using our helper script for better safety checks.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Run the helper script
./copy-folder.sh /home/user/election-data election-data

# The script will:
# 1. Check the folder size
# 2. Warn about large files
# 3. Copy the files
# 4. Prompt for git operations
# 5. Commit and push
```

## Example 3: Copying with Git LFS (Large Files)

**Scenario:** You have a folder with large PDF files and ZIP archives.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Install and initialize Git LFS (one-time setup)
git lfs install

# Track large file types
git lfs track "*.pdf"
git lfs track "*.zip"
git lfs track "*.tar.gz"

# Commit the LFS configuration
git add .gitattributes
git commit -m "Setup Git LFS for large files"

# Now copy your folder
cp -r /home/user/large-documents ./documents

# Add and commit (LFS handles large files automatically)
git add documents/
git commit -m "Add documents folder with LFS"
git push
```

## Example 4: Incremental Copy (Very Large Folder)

**Scenario:** You have a 2GB folder with thousands of files.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Copy and commit in batches
# Batch 1
cp -r /home/user/huge-folder/batch1 ./data/batch1
git add data/batch1
git commit -m "Add data batch 1"
git push

# Batch 2
cp -r /home/user/huge-folder/batch2 ./data/batch2
git add data/batch2
git commit -m "Add data batch 2"
git push

# Continue for remaining batches...
```

## Example 5: Using rsync for Better Progress

**Scenario:** You want to see detailed progress while copying.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Use rsync with progress
rsync -av --progress /home/user/my-data/ ./my-data/

# Check what was copied
du -sh ./my-data

# Add to git
git add my-data/
git commit -m "Add my-data folder"
git push
```

## Example 6: Selective Copy with Exclusions

**Scenario:** Copy a folder but exclude certain file types.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Use rsync with exclusions
rsync -av --progress \
  --exclude='*.log' \
  --exclude='*.tmp' \
  --exclude='node_modules/' \
  /home/user/project-data/ ./project-data/

# Add to git
git add project-data/
git commit -m "Add project data (excluding logs and temp files)"
git push
```

## Example 7: Copy from External Drive

**Scenario:** Copy from a USB drive or external hard drive.

```bash
# First, find your external drive
lsblk
# or
df -h

# Navigate to the repository
cd /home/user/kura-mrdm-election

# Copy from external drive (e.g., mounted at /media/usb)
cp -r /media/usb/my-important-data ./important-data

# Or use rsync for verification
rsync -av --progress --checksum /media/usb/my-important-data/ ./important-data/

# Add to git
git add important-data/
git commit -m "Add important data from external drive"
git push
```

## Example 8: Copy from Network Drive

**Scenario:** Copy from a network-mounted drive.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Copy from network drive (e.g., SMB share)
cp -r /mnt/network-share/shared-data ./shared-data

# Or use rsync
rsync -av --progress /mnt/network-share/shared-data/ ./shared-data/

# Add to git
git add shared-data/
git commit -m "Add shared data from network drive"
git push
```

## Example 9: Verifying Copy Before Commit

**Scenario:** You want to verify files before committing.

```bash
# Navigate to the repository
cd /home/user/kura-mrdm-election

# Copy files
cp -r /home/user/my-folder ./my-folder

# Check what was copied
ls -la ./my-folder
du -sh ./my-folder

# Check git status to see new files
git status

# Review specific files if needed
cat ./my-folder/important-file.txt

# Check for large files
find ./my-folder -type f -size +50M

# If everything looks good, commit
git add my-folder/
git commit -m "Add my-folder"
git push
```

## Example 10: Handling Errors

**Scenario:** You encounter errors during the process.

```bash
# If git rejects large files
[remote: error: File X is 123 MB; exceeds 100 MB limit]

# Solution: Use Git LFS
git lfs install
git lfs track "path/to/large/file"
git add .gitattributes
git add path/to/large/file
git commit --amend --no-edit
git push

# If you accidentally committed unwanted files
# Remove from git (keeps local file)
git rm --cached unwanted-file
git commit -m "Remove unwanted file"
git push

# If you need to undo the last commit (not pushed yet)
git reset --soft HEAD~1
# Make your corrections, then commit again
```

## Tips for Success

1. **Always check folder size first**: `du -sh /path/to/folder`
2. **Use .gitignore**: Add patterns for files you don't want to commit
3. **Test with a small subset first**: Copy a few files to test the workflow
4. **Use meaningful commit messages**: Describe what you're adding
5. **Check GitHub's file size limits**: Individual files >100MB need Git LFS
6. **Use rsync for large transfers**: It's more reliable than cp
7. **Commit frequently**: Don't try to commit everything at once

## Common Patterns

### Pattern: Add data folder with timestamp
```bash
DATE=$(date +%Y%m%d)
cp -r /source/data ./data-${DATE}
git add data-${DATE}/
git commit -m "Add data snapshot ${DATE}"
git push
```

### Pattern: Update existing folder
```bash
rsync -av --delete /source/data/ ./data/
git add data/
git commit -m "Update data folder"
git push
```

### Pattern: Copy multiple folders
```bash
for folder in data1 data2 data3; do
    cp -r /source/${folder} ./${folder}
    git add ${folder}/
    git commit -m "Add ${folder}"
    git push
done
```

## Need Help?

- Main documentation: [COPYING_LARGE_FOLDERS.md](COPYING_LARGE_FOLDERS.md)
- Quick reference: [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
- Helper script: `./copy-folder.sh`
