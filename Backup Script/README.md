# Bachup Script

To backup your directory use:

```
"bash backup_script.sh <directory-to-backup> <compression-algorithm> <output-file>"
```
Avalible compressions:
- none
- gzip
- bzip

To extract the backup use:

```
"bash extract_backup.sh <backup-file> <compression-algorithm>"
```
It will be extracted to the current folder