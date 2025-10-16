# kura-mrdm-election
mardm

## Copying Large Folders to This Repository

Need to copy a large folder from your local drive to this repository? We've got you covered!

### Quick Start

**Option 1: Use the Helper Script**
```bash
./copy-folder.sh /path/to/your/folder destination-name
```

**Option 2: Manual Copy**
```bash
cp -r /path/to/your/folder ./destination-name
git add destination-name/
git commit -m "Add folder"
git push
```

### For Large Files (>50MB)

If your folder contains large files, use Git LFS:
```bash
git lfs install
git lfs track "*.zip"  # or other large file types
git add .gitattributes
# Then copy and commit as usual
```

### Documentation

For detailed instructions, see [COPYING_LARGE_FOLDERS.md](COPYING_LARGE_FOLDERS.md)

This guide covers:
- Basic file copying
- Git LFS setup for large files
- Incremental copying for very large folders
- Troubleshooting common issues
- Best practices
