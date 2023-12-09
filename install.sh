#!/bin/sh
set -e

if [ -n "$BUNW_DL_BASE_URL" ]; then
  base_url="$BUNW_DL_BASE_URL"
else
  base_url='https://github.com/jcbhmr/bunw/raw/main/'
fi

# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

if command -v curl > /dev/null 2>&1; then
  curl -fsSL "${base_url}bunw" -o ./bunw
else
  wget -q "${base_url}bunw" -O ./bunw
fi
chmod +x ./bunw

if [ -n "$1" ]; then
  bun_version="$1"
else
  bun_version=$(get_latest_release oven-sh/bun | cut -c 6-)
fi

sed -i.bak "s/\$__BUN_VERSION__/$bun_version/g" ./bunw
rm -f ./bunw.bak

echo "Created wrapper! You can use ./bunw to launch Bun."
