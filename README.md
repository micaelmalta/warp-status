# WARP Status Bar

A [SwiftBar](https://swiftbar.app) plugin that shows your Cloudflare WARP connection status in the macOS menu bar, refreshing every 5 seconds.

| State | Menu Bar |
|---|---|
| Connected & healthy | **WARP** in white bold |
| Disconnected or unhealthy | **⚠ WARP** in yellow bold |

Click the menu bar item to see full status details.

## Prerequisites

- macOS
- [Cloudflare WARP](https://1.1.1.1/) installed and running
- [Homebrew](https://brew.sh)

## Install via curl

```bash
curl -fsSL https://raw.githubusercontent.com/micaelmalta/warp-status/main/install.sh | bash
```

This will:
1. Install SwiftBar via Homebrew (if not already installed)
2. Create the plugin directory at `~/.config/swiftbar/plugins`
3. Copy the plugin script into place

## Manual Installation

1. Install SwiftBar:
   ```bash
   brew install swiftbar
   ```

2. Clone the repo:
   ```bash
   git clone https://github.com/micaelmalta/warp-status.git
   cd warp-status
   ```

3. Run the installer:
   ```bash
   bash install.sh
   ```

4. Open SwiftBar and set the plugin directory to `~/.config/swiftbar/plugins`.

## How It Works

The script calls `/usr/local/bin/warp-cli status` every 5 seconds and checks for both `Connected` and `healthy` in the output. No dependencies beyond `warp-cli` itself.

## License

MIT
