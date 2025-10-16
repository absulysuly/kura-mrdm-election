# Workflow: Copying Large Folders

This document provides a visual workflow for copying folders to this repository.

## Decision Tree

```
Do you need to copy a folder to this repository?
│
├─ YES → Is the folder on your local computer?
│   │
│   ├─ YES → Continue below
│   │
│   └─ NO → Where is it?
│       ├─ External Drive → Mount drive, then continue below
│       ├─ Network Share → Mount share, then continue below
│       └─ Cloud Storage → Download first, then continue below
│
└─ NO → You're done! ✓

Step 1: Check Folder Size
│
├─ Run: du -sh /path/to/folder
│
└─ Is total size > 1GB?
    │
    ├─ YES → Consider external storage or data versioning tools
    │   └─ See: COPYING_LARGE_FOLDERS.md (Alternative Storage section)
    │
    └─ NO → Continue to Step 2

Step 2: Check for Large Files
│
├─ Run: find /path/to/folder -type f -size +50M
│
└─ Are there files > 100MB?
    │
    ├─ YES → Must use Git LFS
    │   └─ Go to: "Workflow with Git LFS" below
    │
    ├─ Files between 50-100MB → Should use Git LFS
    │   └─ Recommended: "Workflow with Git LFS" below
    │
    └─ All files < 50MB → Go to: "Simple Workflow" below
```

## Simple Workflow (Files < 50MB)

```
┌─────────────────────────────────────────────────────┐
│ Step 1: Navigate to Repository                     │
│                                                     │
│ $ cd /path/to/kura-mrdm-election                   │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 2: Option A - Use Helper Script (Recommended) │
│                                                     │
│ $ ./copy-folder.sh /source/folder destination-name │
│ Then follow the prompts                            │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 2: Option B - Manual Copy                     │
│                                                     │
│ $ cp -r /source/folder ./destination-name          │
│ or                                                  │
│ $ rsync -av --progress /source/ ./destination/     │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 3: Review What Will Be Added                  │
│                                                     │
│ $ git status                                        │
│ $ ls -la destination-name/                         │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 4: Add to Git                                  │
│                                                     │
│ $ git add destination-name/                        │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 5: Commit                                      │
│                                                     │
│ $ git commit -m "Add destination-name folder"      │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 6: Push to GitHub                             │
│                                                     │
│ $ git push                                          │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
                    ✓ Done!
```

## Workflow with Git LFS (Files > 50MB)

```
┌─────────────────────────────────────────────────────┐
│ Step 1: Install Git LFS (One-time Setup)           │
│                                                     │
│ Ubuntu/Debian: $ sudo apt-get install git-lfs     │
│ macOS: $ brew install git-lfs                      │
│ Windows: Download from git-lfs.github.com          │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 2: Navigate to Repository                     │
│                                                     │
│ $ cd /path/to/kura-mrdm-election                   │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 3: Initialize Git LFS                         │
│                                                     │
│ $ git lfs install                                   │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 4: Track Large File Types                     │
│                                                     │
│ $ git lfs track "*.zip"                            │
│ $ git lfs track "*.pdf"                            │
│ $ git lfs track "*.mp4"                            │
│ (Add patterns for your file types)                 │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 5: Commit LFS Configuration                   │
│                                                     │
│ $ git add .gitattributes                           │
│ $ git commit -m "Setup Git LFS"                    │
│ $ git push                                          │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 6: Copy Your Folder                           │
│                                                     │
│ $ cp -r /source/folder ./destination-name          │
│ or                                                  │
│ $ rsync -av --progress /source/ ./destination/     │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 7: Add and Commit (LFS handles large files)   │
│                                                     │
│ $ git add destination-name/                        │
│ $ git commit -m "Add destination-name folder"      │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ Step 8: Push to GitHub                             │
│                                                     │
│ $ git push                                          │
│                                                     │
│ Note: First push with LFS may take longer          │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
                    ✓ Done!
```

## Incremental Workflow (Very Large Folders)

For folders that are extremely large (multiple GB), copy in batches:

```
┌─────────────────────────────────────────────────────┐
│ Prepare: Split folder into logical batches         │
│                                                     │
│ Example structure:                                  │
│ /source/folder/                                     │
│   ├── batch1/ (500MB)                              │
│   ├── batch2/ (500MB)                              │
│   ├── batch3/ (500MB)                              │
│   └── batch4/ (500MB)                              │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│ For each batch:                                     │
│                                                     │
│ $ cp -r /source/folder/batch1 ./data/batch1        │
│ $ git add data/batch1/                             │
│ $ git commit -m "Add data batch 1"                 │
│ $ git push                                          │
│                                                     │
│ (Repeat for batch2, batch3, etc.)                  │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
                    ✓ Done!
```

## Troubleshooting Workflow

```
Did you get an error?
│
├─ "File exceeds 100MB limit"
│   └─ Solution: Use Git LFS workflow above
│
├─ "Permission denied"
│   └─ Solution: $ chmod -R u+rw /path/to/folder
│
├─ "Repository size limit exceeded"
│   └─ Solution: Use external storage or Git LFS
│
├─ "Push rejected (too large)"
│   └─ Solution: Use incremental workflow above
│
└─ Other error
    └─ See: COPYING_LARGE_FOLDERS.md (Troubleshooting section)
```

## Quick Commands Reference

### Check sizes
```bash
du -sh /path/to/folder                    # Total folder size
find /path/to/folder -type f -size +50M   # Find large files
du -h /path/to/folder | sort -h           # List all sizes
```

### Copy commands
```bash
cp -r /source/ ./dest/                    # Basic copy
rsync -av --progress /source/ ./dest/     # Copy with progress
./copy-folder.sh /source dest             # Use helper script
```

### Git commands
```bash
git status                                 # Check status
git add folder/                            # Stage folder
git commit -m "message"                    # Commit
git push                                   # Push to remote
```

### Git LFS commands
```bash
git lfs install                            # Initialize LFS
git lfs track "*.ext"                      # Track file type
git lfs ls-files                           # List LFS files
git lfs status                             # Check LFS status
```

## Visual Summary

```
┌──────────────────────────────────────────────────────────┐
│                   Folder Size Decision                   │
└──────────────────────────────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
      Small             Medium              Large
    (<100MB)         (100MB-1GB)           (>1GB)
        │                  │                  │
        ▼                  ▼                  ▼
  Simple Copy       Use Git LFS      Use Git LFS +
  (cp or rsync)                      Incremental
                                     or External
                                     Storage

┌──────────────────────────────────────────────────────────┐
│                    File Size Decision                    │
└──────────────────────────────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
      Small            Warning              Blocked
    (<50MB)          (50-100MB)            (>100MB)
        │                  │                  │
        ▼                  ▼                  ▼
   Regular Git      Should use            Must use
                     Git LFS              Git LFS
```

## Additional Resources

- **Detailed Guide**: [COPYING_LARGE_FOLDERS.md](COPYING_LARGE_FOLDERS.md)
- **Quick Reference**: [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
- **Examples**: [EXAMPLES.md](EXAMPLES.md)
- **Helper Script**: `./copy-folder.sh`

## Getting Help

1. Check the documentation files above
2. Run the helper script for guided assistance
3. Create an issue on GitHub
4. Review GitHub's documentation on Git LFS

## Summary

The key steps are:
1. **Check sizes** - Know what you're working with
2. **Choose method** - Simple, LFS, or incremental
3. **Copy files** - Use cp, rsync, or helper script
4. **Git operations** - Add, commit, push
5. **Verify** - Ensure everything uploaded correctly

Good luck! 🚀
