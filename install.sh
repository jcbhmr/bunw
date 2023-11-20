#!/bin/sh
set -e

if [ -n "$BUNW_DL_BASE_URL" ]; then
  base_url="$BUNW_DL_BASE_URL"
else
  base_url='https://github.com/jcbhmr/bunw/raw/bunw/main/'
fi

# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

if command -v curl 2> /dev/null; then
  curl -fsSL "${base_url}bunw.bat" -o ./bunw.bat
  curl -fsSL "${base_url}bunw" -o ./bunw
else
  wget "${base_url}bunw.bat" -O ./bunw.bat
  wget "${base_url}bunw" -O ./bunw
fi
chmod +x ./bunw

if [ -n "$1" ]; then
  bun_version="$1"
else
  bun_version=$(get_latest_release oven-sh/bun | cut -c 6-)
fi

sed -i.bak "s/%__BUN_VERSION__%/$bun_version/g" ./bunw.bat
sed -i.bak "s/\$__BUN_VERSION__/$bun_version/g" ./bunw

echo "Created wrapper! You can use ./bunw to launch Bun."
