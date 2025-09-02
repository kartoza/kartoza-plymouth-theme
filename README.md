# ❄️ NixOS Kartoza Plymouth Theme [![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

> ## 👋 Welcome to the Kartoza Plymouth Theme
>
> **This repository hosts a beautiful animated Plymouth boot splash theme for NixOS/Linux systems:**
>
> Here you'll find everything you need to **build, install, and use** this custom Plymouth theme with Kartoza branding.
>
> ### ⚠️ About this Project
>
> **This repository provides a professionally designed Plymouth theme** that displays an animated Kartoza logo during system boot. The theme includes:
>
> - 🎬 **Smooth animated boot sequence** with 120 frames of animation
> - 🎨 **Kartoza brand colors** (Orange #DF9E2F, Blue #569FC6, White background)
> - 📱 **Responsive scaling** that adapts to different screen resolutions
> - 🔧 **Easy NixOS integration** via Nix flakes
> - 🛠️ **Development tools** for customizing colors and creating previews

<!-- TABLE OF CONTENTS -->
<h2 id="table-of-contents"> 📖 Table of Contents</h2>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#-project-overview"> 🚀 Project Overview </a></li>
    <li><a href="#-qa-status"> 🚥 QA Status </a></li>
    <li><a href="#-license"> 📜 License </a></li>
    <li><a href="#-folder-structure"> 📂 Folder Structure </a></li>
    <li><a href="#-installation-and-usage"> 🔧 Installation and Usage </a></li>
    <li><a href="#-previewing-the-theme"> 🎬 Previewing the Theme </a></li>
    <li><a href="#-utilities-overview"> 🛠️ Theme Features & Customization </a></li>
    <li><a href="#-using-the-nix-shell"> 🧊 Using the Nix Shell </a></li>
    <li><a href="#-adding-to-your-own-flake"> 📦 Adding to Your Own Flake </a></li>
    <li><a href="#-contributing"> ✨ Contributing </a></li>
    <li><a href="#-have-questions"> 🙋 Have Questions? </a></li>
    <li><a href="#-contributors"> 🧑‍💻👩‍💻 Contributors </a></li>
  </ol>
</details>

## 🚀 Project Overview

The Kartoza Plymouth Theme is a custom boot splash screen theme designed specifically for NixOS systems. Plymouth is the boot splash screen framework used by many Linux distributions to provide a smooth, graphical boot experience.

**Key Features:**

- 🎬 **120-frame animation sequence** featuring the Kartoza logo
- 🎨 **Professional branding** with authentic Kartoza colors
- 📱 **Adaptive scaling** that works on any screen resolution
- ⚡ **Performance optimized** for fast boot times
- 🔧 **Easy customization** with included color-changing tools
- 📦 **Nix packaging** for seamless NixOS integration

**What you get:**

- Animated Plymouth theme files
- Development tools for customization
- Preview utilities for testing
- Complete NixOS integration examples

## 🚥 QA Status

### 🪪 Badges

| Badge | Description |
|-------|-------------|
| ![License](https://img.shields.io/github/license/timlinux/kartoza-plymouth-theme.svg) | Repository license |
| ![Open Issues](https://img.shields.io/github/issues/timlinux/kartoza-plymouth-theme.svg) | Open issues count |
| ![Closed Issues](https://img.shields.io/github/issues-closed/timlinux/kartoza-plymouth-theme.svg) | Closed issues count |
| ![Open PRs](https://img.shields.io/github/issues-pr/timlinux/kartoza-plymouth-theme.svg) | Open pull requests count |
| ![Closed PRs](https://img.shields.io/github/issues-pr-closed/timlinux/kartoza-plymouth-theme.svg) | Closed pull requests count |

### ⭐️ Project Stars

![Stars](https://starchart.cc/timlinux/kartoza-plymouth-theme.svg)

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## 📂 Folder Structure

```plaintext
kartoza-plymouth-theme/
  ├── ❄️  flake.nix                    # Main Nix flake configuration
  ├── 🔒  flake.lock                   # Lock file for reproducible builds
  ├── 📦  packages/                    # Package definitions
  │   └── kartoza-plymouth-theme/      # Main theme package
  │       ├── ⚙️  default.nix          # Package build configuration
  │       └── 🎨  src/                 # Theme source files
  │           └── kartoza/             # Plymouth theme directory
  │               ├── 🎬  kartoza.script      # Animation script
  │               ├── ⚙️  kartoza.plymouth    # Theme configuration
  │               ├── 🎨  images/             # Theme assets
  │               │   ├── bar-background.png  # Progress bar background
  │               │   ├── bar-progress.png    # Progress bar fill
  │               │   ├── input.png           # Password input field
  │               │   ├── lock.png            # Lock icon
  │               │   └── animation/          # 120 animation frames
  │               │       ├── kartoza-plymouth.0.png
  │               │       ├── kartoza-plymouth.1.png
  │               │       └── ... (120 frames total)
  │               ├── �️  change-color.sh     # Color customization tool
  │               ├── 🎬  preview.sh          # Theme preview utility
  │               ├── 🗜️  compress-images.sh  # Image optimization tool
  │               └── 📹  make-movie.sh       # Animation preview tool
  ├── 📜  LICENSE                      # MIT license file
  ├── 📖  README.md                    # This file
  └── �  vscode.sh                    # VSCode setup script
```

## 🔧 Installation and Usage

### 🏠 Local Installation & Testing

Clone the repository and test the theme locally:

```bash
git clone https://github.com/timlinux/kartoza-plymouth-theme.git
cd kartoza-plymouth-theme

# Build the theme package
nix build

# Test the theme (requires Plymouth installed)
nix develop
cd packages/kartoza-plymouth-theme/src/kartoza
./preview.sh  # Preview the theme animation in terminal
./make-movie.sh  # Create video preview (optional)
```

### 🌐 Remote Usage

Build directly from GitHub without cloning:

```bash
# Build the Plymouth theme package
nix build github:timlinux/kartoza-plymouth-theme

# The theme files will be available in result/share/plymouth/themes/kartoza/
```

### 🔧 Development Environment

Enter the development shell with all dependencies and tools:

```bash
nix develop
```

This provides access to:

- **VSCode** with Plymouth development extensions
- **Image tools** (chafa for ASCII preview)
- **Development utilities** (git, pre-commit hooks)
- **Theme customization scripts**

### 💻 NixOS System Integration

The most common way to use this theme is to integrate it into your NixOS configuration.

## 🛠️ Theme Features & Customization

### 🎨 Visual Features

- **Smooth Animation**: 120 high-quality frames creating fluid motion
- **Adaptive Scaling**: Automatically adjusts to screen resolution (maintains aspect ratio)
- **Progress Indicators**: Beautiful progress bars and password input fields
- **Professional Branding**: Authentic Kartoza colors and styling

### ⚙️ Customization Options

The theme includes several customization scripts:

```bash
# Enter development environment
nix develop
cd packages/kartoza-plymouth-theme/src/kartoza

# Change theme colors
./change-color.sh background "#FFFFFF"    # Set background color
./change-color.sh main "#DF9E2F"          # Set primary color (orange)
./change-color.sh secondary "#569FC6"     # Set secondary color (blue)

# Preview your changes
./preview.sh

# Create animation preview video
./make-movie.sh

# Optimize images for size
./compress-images.sh
```

### 📐 Scaling Configuration

Edit `kartoza.script` to adjust scaling behavior:

```javascript
LOGO.max_height_percent = 0.4;  // 40% of screen height
LOGO.max_width_percent = 0.4;   // 40% of screen width
LOGO.keep_aspect_ratio = 1;     // Maintain aspect ratio
LOGO.min_size = 200;            // Minimum size in pixels
```

## 🧊 Using the Nix Shell

### Development Environment

The flake provides a comprehensive development environment for theme customization:

```bash
# Enter the development shell
nix develop

# Available commands in the shell:
🚀 nix build           # Build the Plymouth theme package
👀 nix flake show .    # Show all the flake outputs
🔍 nix flake update    # Update the flake dependencies
🩻 nix flake check     # Validate the flake configuration
🆚 ./vscode.sh         # Open VSCode with Plymouth extensions
```

### Development Tools Available

The development shell includes:

- **Plymouth development tools** for theme testing
- **Image manipulation utilities** (chafa for ASCII preview)
- **Code quality tools** (shellcheck, markdownlint, pre-commit)
- **Version control** (git with pre-commit hooks)
- **Editor integration** (VSCode with relevant extensions)

## ✨ Contributing

We welcome contributions! Here's how you can help improve the Kartoza Plymouth Theme:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes**: Edit theme files, improve animations, or add new features
4. **Test your changes**: Run `nix flake check` and test the theme with `./preview.sh`
5. **Commit your changes**: `git commit -m 'Add amazing feature'`
6. **Push to the branch**: `git push origin feature/amazing-feature`
7. **Open a Pull Request**

### 📝 Development Guidelines

- **Follow Plymouth best practices** for theme development
- **Test on multiple resolutions** to ensure proper scaling
- **Optimize image assets** using the provided compression tools
- **Update documentation** for new features or configuration options
- **Maintain backward compatibility** when possible
- **Use the development environment** (`nix develop`) for consistent tooling

### 🎨 Contributing Ideas

- **New animations**: Create alternative animation sequences
- **Color schemes**: Add new color variations or themes
- **Performance improvements**: Optimize image assets or script performance
- **Documentation**: Improve setup guides or troubleshooting info
- **Testing**: Add automated tests for different screen resolutions

## 🙋 Have Questions?

Have questions or feedback about the Kartoza Plymouth Theme? We'd love to help!

- 🐛 **Bug Reports**: Use the issue tracker to report theme rendering issues or bugs
- 💡 **Feature Requests**: Suggest new animations, colors, or Plymouth features
- 📖 **Documentation**: Help improve our setup guides and troubleshooting docs
- 💬 **Discussions**: Join conversations about Plymouth theming and NixOS integration
- 🎨 **Theme Requests**: Request custom themes or branding variations

### 🔧 Troubleshooting

**Common Issues:**

- **Theme not showing**: Ensure Plymouth is enabled in your NixOS configuration
- **Scaling issues**: Check your `kartoza.script` scaling parameters
- **Performance**: Use the image compression tools for better boot times
- **Color problems**: Verify color codes are valid hex values in customization scripts

## 🎬 Previewing the Theme

### 🖥️ Local Preview (Recommended)

The easiest way to preview the theme is using the built-in preview script:

```bash
# Clone and enter the repository
git clone https://github.com/timlinux/kartoza-plymouth-theme.git
cd kartoza-plymouth-theme

# Enter development environment
nix develop

# Navigate to theme directory
cd packages/kartoza-plymouth-theme/src/kartoza

# Run the preview script
./preview.sh
```

This will show you the animation frames in your terminal using ASCII art conversion.

### 🎥 Video Preview

Create a video preview of the entire animation sequence:

```bash
# In the theme directory (after nix develop)
cd packages/kartoza-plymouth-theme/src/kartoza

# Generate animation video (requires ffmpeg)
./make-movie.sh

# This creates kartoza-animation.mp4 showing the full boot sequence
```

### 🖼️ Individual Frame Preview

View specific animation frames:

```bash
# Navigate to animation frames
cd packages/kartoza-plymouth-theme/src/kartoza/images/animation

# View frames with image viewer
feh kartoza-plymouth.*.png  # If feh is installed
# Or use any image viewer to browse the 120 frames (0-119)

# ASCII preview in terminal with chafa (available in nix develop)
chafa kartoza-plymouth.0.png
chafa kartoza-plymouth.59.png  # Middle of animation
chafa kartoza-plymouth.119.png # Last frame
```

### 🧪 Plymouth System Testing

Advanced: Test with actual Plymouth (requires root access).

```bash
# Build the theme first
nix build github:timlinux/kartoza-plymouth-theme

# Install theme temporarily for testing
sudo mkdir -p /usr/share/plymouth/themes/
sudo cp -r result/share/plymouth/themes/kartoza /usr/share/plymouth/themes/

# Test Plymouth theme
sudo plymouthd --debug --debug-file=/tmp/plymouth.log &
sudo plymouth --show-splash &

# Wait a few seconds to see the animation, then stop
sleep 5
sudo plymouth quit
sudo killall plymouthd

# Check debug output
cat /tmp/plymouth.log
```

### 🎨 Preview After Customization

After making color changes or other customizations:

```bash
# Make your changes
./change-color.sh main "#FF6600"  # Example: change to orange

# Preview the updated theme
./preview.sh

# Or create a new video with your changes
./make-movie.sh
```

### 📱 Testing Different Screen Resolutions

The theme automatically scales, but you can test scaling behavior:

```bash
# View how the theme looks at different sizes
chafa --size=80x24 images/animation/kartoza-plymouth.0.png   # Small terminal
chafa --size=120x40 images/animation/kartoza-plymouth.0.png  # Medium terminal
chafa --size=160x50 images/animation/kartoza-plymouth.0.png  # Large terminal
```

**Note:** The actual Plymouth theme will scale much better than terminal ASCII preview, as it uses the full graphics capabilities of your system.

## 🧑‍💻👩‍💻 Contributors

- [Tim Sutton](https://github.com/timlinux) – Original author and maintainer
- [Contributors](https://github.com/timlinux/kartoza-plymouth-theme/graphs/contributors) – See the full list of amazing contributors who have helped make this theme possible.

**Special Thanks:**

- [Hugopikachu](https://github.com/Hugopikachu/plymouth-theme-chain) – For the original chain animation script that inspired this theme

## 📦 Adding to Your Own Flake

You can easily include the Kartoza Plymouth Theme in your own NixOS configuration or flake.

### 🔧 Adding as Flake Input

Add the theme to your `flake.nix` inputs section:

```nix
{
  description = "Your NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Add Kartoza Plymouth Theme as an input
    kartoza-plymouth-theme.url = "github:timlinux/kartoza-plymouth-theme";
    # Other inputs...
  };

  outputs = { self, nixpkgs, kartoza-plymouth-theme, ... }@inputs: {
    # Your configuration here...
  };
}
```

### 🏠 Using in NixOS Configuration

There are several ways to integrate the theme into your NixOS system:

#### Method 1: Direct Plymouth Configuration (Recommended)

```nix
{ config, pkgs, inputs, ... }: {

  # Enable Plymouth
  boot.plymouth.enable = true;

  # Set the Kartoza theme
  boot.plymouth.themePackages = [
    inputs.kartoza-plymouth-theme.packages.${pkgs.system}.default
  ];
  boot.plymouth.theme = "kartoza";

  # Optional: Enable silent boot for cleaner experience
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
}
```

#### Method 2: Include in System Packages

```nix
{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    # Your other packages...
    inputs.kartoza-plymouth-theme.packages.${pkgs.system}.default
  ];

  # Then manually configure Plymouth to use the theme
  boot.plymouth.enable = true;
  boot.plymouth.theme = "kartoza";
}
```

### 🛠️ Using in Development Shell

Include the theme package in your development environment for customization:

```nix
{
  devShells.default = pkgs.mkShell {
    buildInputs = with pkgs; [
      # Your development tools...
      inputs.kartoza-plymouth-theme.packages.${pkgs.system}.default
      plymouth  # For testing Plymouth themes
    ];

    shellHook = ''
      echo "Kartoza Plymouth Theme available!"
      echo "Theme files: ${inputs.kartoza-plymouth-theme.packages.${pkgs.system}.default}/share/plymouth/themes/kartoza/"
    '';
  };
}
```

### 🚀 Using the Theme

Once installed and configured, the theme will automatically display during system boot. You can also:

```bash
# Preview the theme (requires Plymouth)
sudo plymouthd --debug --debug-file=/tmp/plymouth.log
sudo plymouth --show-splash
# ... wait a moment to see animation ...
sudo plymouth quit

# Test theme in a window (if supported)
plymouth-set-default-theme kartoza
sudo update-initramfs -u  # On Debian/Ubuntu-based systems
# On NixOS, rebuild your system: sudo nixos-rebuild switch
```

### 🎨 Customizing After Installation

After installation, you can customize the theme:

```bash
# Access the theme source for customization
cd $(nix build github:timlinux/kartoza-plymouth-theme --print-out-paths)/share/plymouth/themes/kartoza/

# Or if using in a flake, the development shell provides access to source
nix develop github:timlinux/kartoza-plymouth-theme
cd $SRC_DIR/kartoza  # Source directory is available in development shell
```

### 📋 Complete NixOS Configuration Example

Here's a complete example showing how to integrate the theme into a NixOS configuration:

```nix
{
  description = "My NixOS configuration with Kartoza Plymouth Theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    kartoza-plymouth-theme.url = "github:timlinux/kartoza-plymouth-theme";
  };

  outputs = { self, nixpkgs, kartoza-plymouth-theme }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ... }: {
          # Plymouth configuration
          boot.plymouth.enable = true;
          boot.plymouth.themePackages = [
            kartoza-plymouth-theme.packages.${pkgs.system}.default
          ];
          boot.plymouth.theme = "kartoza";

          # Silent boot configuration
          boot.consoleLogLevel = 0;
          boot.initrd.verbose = false;
          boot.kernelParams = [
            "quiet"
            "splash"
            "loglevel=3"
            "rd.systemd.show_status=false"
            "rd.udev.log_level=3"
            "udev.log_priority=3"
          ];

          # Your other system configuration...
        })
      ];
    };
  };
}
```

The theme will be available system-wide and will display the beautiful Kartoza animation during every boot, providing a professional and branded boot experience.

---

**Made with ❤️ and ❄️ by Tim Sutton (@timlinux) for the Kartoza community.**
