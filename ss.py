#
# This script aims to provide easy startup for shadowsocks-rust and ssconf links
# Usage:
# - `python ss.py ssconf.key`
# - here ssconf.key is file containing ssconf link
# Dependencies:
# - wget
# - shadowsocks-rust
#

# Where to keep generated config

import os, sys, json

# Program usage and file path
if len(sys.argv) != 2:
    print(f"Usage: python {sys.argv[0]} path/to/ssconf/file")
    exit(1)
path = sys.argv[1]

# Load key from file
key = ''
with open(path, 'r') as f:
    key = f.read().replace('ssconf', 'https')

# Generate new config
os.system(f'ssurl -d `wget {key} -qO -` > sscfg.json')

# Load config
cfg = None
with open('sscfg.json', 'r') as f:
    cfg = json.load(f)

# Modify config
cfg.update({'local_port': 8388})

# Dump config
with open('sscfg.json', 'w') as f:
    json.dump(cfg, f)

# Use config to run server
os.system('sslocal -c sscfg.json')