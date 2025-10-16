# 🚀 START HERE: Copying Large Folders

**Welcome!** This guide will help you copy large folders from your local drive to this repository.

## 📋 What You Need

- The folder you want to copy (on your local computer)
- This repository cloned to your local machine
- Git installed (you already have this if you cloned the repo)
- Optional: Git LFS (for files larger than 100MB)

## ⚡ Quick Start (3 Steps)

### 1️⃣ Clone This Repository (if you haven't already)

```bash
git clone https://github.com/absulysuly/kura-mrdm-election.git
cd kura-mrdm-election
```

### 2️⃣ Run the Helper Script

```bash
./copy-folder.sh /path/to/your/folder destination-name
```

**Example:**
```bash
# Copy your election data folder
./copy-folder.sh ~/Documents/election-data election-data
```

The script will:
- ✅ Check the folder size
- ✅ Warn you about large files
- ✅ Copy the files with progress tracking
- ✅ Add them to git
- ✅ Commit and push to GitHub

### 3️⃣ Done! ✨

Your folder is now in the repository and pushed to GitHub.

---

## 🤔 Which Method Should I Use?

### Small Folders (< 100MB total, all files < 50MB)
→ **Use the helper script** (recommended)
```bash
./copy-folder.sh /path/to/folder my-data
```

### Large Files (any file > 100MB)
→ **Must use Git LFS first**
1. Install Git LFS: `brew install git-lfs` (macOS) or `sudo apt-get install git-lfs` (Linux)
2. Initialize: `git lfs install`
3. Track large files: `git lfs track "*.zip"` (adjust for your file types)
4. Commit LFS config: `git add .gitattributes && git commit -m "Setup LFS" && git push`
5. Then use the helper script

### Very Large Folders (> 1GB)
→ **See detailed guide**: [COPYING_LARGE_FOLDERS.md](COPYING_LARGE_FOLDERS.md)

---

## 📚 Documentation Guide

We've created comprehensive documentation to help you:

| File | Purpose | When to Use |
|------|---------|-------------|
| **[START_HERE.md](START_HERE.md)** | You are here! Quick overview | First time, need direction |
| **[README.md](README.md)** | Repository overview | Quick reference |
| **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** | TL;DR commands | Need quick command lookup |
| **[WORKFLOW.md](WORKFLOW.md)** | Visual decision trees | Need to choose a method |
| **[EXAMPLES.md](EXAMPLES.md)** | 10 real-world scenarios | Looking for similar example |
| **[COPYING_LARGE_FOLDERS.md](COPYING_LARGE_FOLDERS.md)** | Complete guide | Need detailed instructions |
| **[copy-folder.sh](copy-folder.sh)** | Helper script | Want automated assistance |

---

## 💡 Common Scenarios

### Scenario 1: "I have a folder with election data"
```bash
./copy-folder.sh ~/election-data election-data
# Follow the prompts
```

### Scenario 2: "My folder has large PDF files"
```bash
# First, setup Git LFS for PDFs
git lfs install
git lfs track "*.pdf"
git add .gitattributes
git commit -m "Setup LFS for PDFs"
git push

# Then copy your folder
./copy-folder.sh ~/documents documents
```

### Scenario 3: "I have data on a USB drive"
```bash
# Mount your USB drive (it will appear in /media/ or /Volumes/)
# Then copy from it
./copy-folder.sh /media/usb-drive/my-data my-data
```

### Scenario 4: "I want to copy manually"
```bash
cd kura-mrdm-election
cp -r /path/to/your/folder ./my-folder
git add my-folder/
git commit -m "Add my-folder"
git push
```

---

## 🆘 Troubleshooting

### ❌ Error: "File exceeds 100MB limit"
**Fix:** You must use Git LFS for files over 100MB.
```bash
git lfs install
git lfs track "*.ext"  # replace .ext with your file extension
git add .gitattributes
# Try again
```

### ❌ Error: "Permission denied"
**Fix:** Check file permissions
```bash
chmod -R u+rw /path/to/folder
```

### ❌ Error: "Not a directory"
**Fix:** Make sure the path is correct
```bash
ls -la /path/to/folder  # Verify the folder exists
```

### ❌ Script won't run: "Permission denied"
**Fix:** Make the script executable
```bash
chmod +x copy-folder.sh
```

---

## 📏 GitHub Size Limits

| Type | Size | Action |
|------|------|--------|
| Individual file (warning) | > 50MB | **Should** use Git LFS |
| Individual file (hard limit) | > 100MB | **Must** use Git LFS |
| Repository size (soft limit) | > 1GB | Consider alternatives |

**Note:** GitHub rejects files over 100MB unless they're tracked with Git LFS.

---

## 🎯 Recommended Workflow

```
1. Read this START_HERE.md (you're here! ✓)
   ↓
2. Check your folder size: du -sh /path/to/folder
   ↓
3a. Small folder (< 1GB, no files > 50MB)
    → Use helper script: ./copy-folder.sh /source dest
    ↓
3b. Large files present (any file > 100MB)
    → Setup Git LFS first
    → Then use helper script
    ↓
4. Verify on GitHub
   → Visit: https://github.com/absulysuly/kura-mrdm-election
   ↓
5. Done! ✨
```

---

## 🤓 Advanced Topics

For advanced use cases, see:
- **Incremental copying**: [COPYING_LARGE_FOLDERS.md](COPYING_LARGE_FOLDERS.md#method-3-incremental-copy-for-very-large-folders)
- **Network drives**: [EXAMPLES.md](EXAMPLES.md#example-8-copy-from-network-drive)
- **External drives**: [EXAMPLES.md](EXAMPLES.md#example-7-copy-from-external-drive)
- **Selective copying**: [EXAMPLES.md](EXAMPLES.md#example-6-selective-copy-with-exclusions)

---

## 📞 Need More Help?

1. **Check the docs**: Most questions are answered in the documentation
2. **Look at examples**: [EXAMPLES.md](EXAMPLES.md) has 10 scenarios
3. **Use the script**: It has built-in checks and warnings
4. **Create an issue**: If you're still stuck, open a GitHub issue

---

## ✅ Success Checklist

Before you start:
- [ ] Repository cloned to my local machine
- [ ] Know the path to my folder
- [ ] Checked folder size with `du -sh /path/to/folder`
- [ ] Know if I have files > 100MB (if yes, need Git LFS)

After copying:
- [ ] Files appear in repository locally
- [ ] Successfully committed to git
- [ ] Successfully pushed to GitHub
- [ ] Files visible on GitHub website

---

## 🎉 You're Ready!

Run this command to get started:
```bash
./copy-folder.sh /path/to/your/folder destination-name
```

Good luck! 🚀

---

**Pro tip:** The helper script is designed to be safe and will ask for confirmation before making changes. Don't worry about breaking anything - it's got your back! 😊
