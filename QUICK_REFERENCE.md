# Quick Reference: Copying Folders

## TL;DR - Three Ways to Copy Your Folder

### 1. Simple Copy (Best for small folders, <50MB files)
```bash
cd kura-mrdm-election
cp -r /path/to/your/folder ./my-folder
git add my-folder/
git commit -m "Add my-folder"
git push
```

### 2. Using the Helper Script (Recommended)
```bash
cd kura-mrdm-election
./copy-folder.sh /path/to/your/folder my-folder
# Follow the prompts
```

### 3. With Git LFS (Required for files >100MB)
```bash
cd kura-mrdm-election
git lfs install
git lfs track "*.zip"
git lfs track "*.pdf"
git add .gitattributes
git commit -m "Setup LFS"
cp -r /path/to/your/folder ./my-folder
git add my-folder/
git commit -m "Add my-folder"
git push
```

## Common Commands

### Check folder size before copying
```bash
du -sh /path/to/your/folder
```

### Find large files
```bash
find /path/to/your/folder -type f -size +50M
```

### Copy with progress
```bash
rsync -av --progress /path/to/your/folder/ ./my-folder/
```

### Check what will be committed
```bash
git status
git diff --stat
```

## GitHub File Size Limits

| Limit | Size | Action Required |
|-------|------|----------------|
| Warning | >50MB | Consider Git LFS |
| Hard Limit | 100MB | **Must** use Git LFS |
| Repository Size | 1GB | Consider external storage |

## Troubleshooting

### ❌ "remote: error: File X is 123 MB; this exceeds GitHub's file size limit of 100 MB"
**Fix:** Use Git LFS
```bash
git lfs track "path/to/large/file"
git add .gitattributes
git add path/to/large/file
```

### ❌ "Permission denied"
**Fix:** Check file permissions
```bash
chmod -R u+rw /path/to/folder
```

### ❌ Copy is too slow
**Fix:** Use rsync instead of cp
```bash
rsync -av --progress /source/ ./destination/
```

## Need More Help?

- Full guide: [COPYING_LARGE_FOLDERS.md](COPYING_LARGE_FOLDERS.md)
- Helper script: `./copy-folder.sh`
- Create an issue on GitHub
