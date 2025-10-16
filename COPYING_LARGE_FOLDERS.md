# Guide: Copying Large Folders to This Repository

This guide explains how to copy large folders from your local drive to this repository.

## Method 1: Basic Copy (For Small to Medium Folders)

### Step 1: Navigate to the Repository
```bash
cd /path/to/kura-mrdm-election
```

### Step 2: Copy Your Folder
```bash
# Copy a folder from your local drive
cp -r /path/to/your/large/folder ./destination-name

# Or use rsync for better progress tracking
rsync -av --progress /path/to/your/large/folder/ ./destination-name/
```

### Step 3: Add to Git
```bash
# Check what will be added
git status

# Add the folder
git add destination-name/

# Commit the changes
git commit -m "Add large folder: destination-name"

# Push to repository
git push
```

## Method 2: For Very Large Files (Using Git LFS)

If your folder contains files larger than 50-100 MB, you should use Git Large File Storage (LFS).

### Step 1: Install Git LFS
```bash
# On Ubuntu/Debian
sudo apt-get install git-lfs

# On macOS
brew install git-lfs

# On Windows
# Download from: https://git-lfs.github.com/
```

### Step 2: Initialize Git LFS
```bash
cd /path/to/kura-mrdm-election
git lfs install
```

### Step 3: Track Large File Types
```bash
# Track specific file types (examples)
git lfs track "*.zip"
git lfs track "*.tar.gz"
git lfs track "*.pdf"
git lfs track "*.mp4"
git lfs track "*.psd"
git lfs track "*.bin"
git lfs track "*.exe"

# Or track all files in a specific folder
git lfs track "large-data/**"
```

### Step 4: Add .gitattributes
```bash
git add .gitattributes
git commit -m "Configure Git LFS tracking"
```

### Step 5: Copy and Add Your Files
```bash
# Copy your folder
cp -r /path/to/your/large/folder ./destination-name

# Add to git (LFS will handle large files automatically)
git add destination-name/
git commit -m "Add large folder with LFS"
git push
```

## Method 3: Incremental Copy (For Very Large Folders)

For extremely large folders, copy and commit in batches:

```bash
# Copy first batch
cp -r /path/to/your/folder/batch1 ./destination-name/batch1
git add destination-name/batch1
git commit -m "Add batch 1"
git push

# Copy second batch
cp -r /path/to/your/folder/batch2 ./destination-name/batch2
git add destination-name/batch2
git commit -m "Add batch 2"
git push

# Continue for remaining batches...
```

## Important Considerations

### .gitignore Configuration
Before copying, configure `.gitignore` to exclude unnecessary files:

```gitignore
# Common exclusions
node_modules/
.env
*.log
.DS_Store
Thumbs.db

# Build artifacts
dist/
build/
*.o
*.so
*.dll

# Temporary files
*.tmp
*.temp
~*

# IDE files
.vscode/
.idea/
*.swp
```

### File Size Limits
- **GitHub**: Free tier has 1GB repository limit, 100MB per file limit
- **Git LFS**: Gives 1GB free storage and bandwidth per month
- Files over 100MB **must** use Git LFS or they'll be rejected

### Performance Tips
1. **Use rsync instead of cp** for better progress tracking
2. **Compress before copying** if possible
3. **Split large files** into smaller chunks if not using LFS
4. **Use .gitignore** to avoid copying unnecessary files

## Example: Complete Workflow

```bash
# 1. Navigate to repository
cd /path/to/kura-mrdm-election

# 2. Create/update .gitignore
echo "*.log" >> .gitignore
echo "*.tmp" >> .gitignore

# 3. Copy your folder
rsync -av --progress /path/to/your/data/ ./election-data/

# 4. Check what was copied
du -sh ./election-data/
git status

# 5. Add and commit
git add .gitignore election-data/
git commit -m "Add election data folder"

# 6. Push to GitHub
git push
```

## Troubleshooting

### Error: "File size exceeds 100 MB"
- **Solution**: Use Git LFS (see Method 2)

### Error: "Repository size limit exceeded"
- **Solution**: Use Git LFS or consider external storage

### Slow Performance
- **Solution**: Use incremental commits (Method 3)
- **Solution**: Exclude unnecessary files with .gitignore

### Permission Denied
- **Solution**: Check file permissions: `chmod -R u+rw /path/to/folder`

## Alternative: External Storage

For very large datasets, consider:
1. **Git LFS** (recommended for files up to a few GB)
2. **Cloud storage** (Google Drive, Dropbox) with links in repository
3. **Data versioning tools** (DVC, Git Annex)
4. **Dedicated storage** (AWS S3, Azure Blob) with documentation in repo

## Need Help?

If you encounter issues:
1. Check file sizes: `du -sh /path/to/folder`
2. Count files: `find /path/to/folder -type f | wc -l`
3. Identify large files: `find /path/to/folder -type f -size +50M`
4. Review `.gitignore` to ensure it's configured correctly

For repository-specific questions, please open an issue on GitHub.
