#!/usr/bin/env pwsh
$ErrorActionPreference = 'Stop'

# Set base_url to $BUNW_DL_BASE_URL if it's set, otherwise use the default value
if ($env:BUNW_DL_BASE_URL) {
    $base_url = $env:BUNW_DL_BASE_URL
}
else {
    $base_url = "https://github.com/jcbhmr/bunw/raw/bunw/main/"
}

# Check if the operating system is Windows
Invoke-WebRequest -Uri "${base_url}bunw.bat" -OutFile ./bunw.bat
Invoke-WebRequest -Uri "${base_url}bunw" -OutFile ./bunw

# Determine the Bun version
if ($v) {
  $bun_version = "${v}"
} else {
  $bun_version = (Invoke-RestMethod -Uri "https://api.github.com/repos/oven-sh/bun/releases/latest").tag_name
  $bun_version = $bun_version.Substring(5)
}

# Update the script with the Deno version
(Get-Content ./bunw.bat) -replace '%__BUN_VERSION__%', "$bun_version" | Out-File -Encoding ASCII ./bunw.bat
(Get-Content ./bunw) -replace '$__BUN_VERSION__', "$bun_version" | Out-File -Encoding ASCII ./bunw

Write-Host "Created wrapper! You can use ./bunw to launch Bun."
