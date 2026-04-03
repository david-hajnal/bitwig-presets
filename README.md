# bitwig-presets

## Sync script

`sync.sh` uses `BITWIG_PRESETS_DIR` when it is set; otherwise it falls back to:

```bash
$HOME/Documents/Bitwig Studio/Library/Presets
```

Example:

```bash
BITWIG_PRESETS_DIR="$HOME/Library/Application Support/Bitwig Studio/Library/Presets" ./sync.sh
```
