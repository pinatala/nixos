# NixOS Installation Guide

A step-by-step guide to install NixOS with disk encryption, secure boot, and optional NVIDIA/AMD GPU support.

---

## Prerequisites

Make sure you have booted into the NixOS installer before proceeding.

---

## Installation Steps

### 1. Configure Disk

Open `modules/disk-config.nix` and replace the placeholder with your actual disk ID. To find your disk ID, run:

```bash
ls /dev/disk/by-id/
```

---

### 2. Format the Disk

Use `disko` to destroy, format, and mount your disk:

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount modules/disk-config.nix
```

> ⚠️ **Warning:** This will erase all data on the selected disk.

---

### 3. Copy NixOS Configuration

Copy the NixOS configuration files to `/mnt/etc`:

```bash
sudo cp -r nixos /mnt/etc
```

---

### 4. Generate Hardware Configuration

Generate the `hardware-configuration.nix` file for your system:

```bash
sudo nixos-generate-config --no-filesystems --root /mnt/etc/nixos
```

---

### 5. Disable Secure Boot Module (Temporarily)

Open `modules/host/rabbit.nix` and comment out the following line:

```nix
# self.nixosModules.secureBoot
```

---

### 6. Configure GPU Driver (Optional)

Open `modules/host/rabbit.nix` and check the NVIDIA module:

- **If you are not using an NVIDIA GPU**, comment out the following line:

```nix
# self.nixosModules.nvidia
```

---

### 7. Disable Home Modules (Temporarily)

Open `modules/users/home-luna.nix` and comment out the following lines:

```nix
# self.homeModules.git
# self.homeModules.ssh
# self.homeModules.sops
```

---

### 8. Install NixOS

Navigate to the NixOS config directory and run the installer:

```bash
cd /mnt/etc/nixos
sudo nixos-install --flake .#yourhostname
```

> Replace `yourhostname` with your actual hostname defined in the flake.

---

### 9. Disable Secure Boot in BIOS

Reboot into your firmware/BIOS settings and:

1. Delete all existing secure boot keys
2. Disable secure boot

---





### 10. Boot into NixOS

Reboot and select NixOS from the boot menu.

---

### 11. Set Up Secure Boot

Once inside NixOS, enroll your secure boot keys:

```bash
sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft
```

---

### 12. Copy SOPS Age Keys

Copy your `keys.txt` file to the SOPS age directory:

```bash
cp keys.txt /home/luna/.config/sops/age/
```

---

### 13. Re-enable Home Modules

Open `modules/users/home-luna.nix` and uncomment the lines from Step 7:

```nix
self.homeModules.git
self.homeModules.ssh
self.homeModules.sops
```

---

### 14. Re-enable Secure Boot Module

Open `modules/host/rabbit.nix` and uncomment the line from Step 5:

```nix
self.nixosModules.secureBoot
```

Then rebuild your system:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#yourhostname
```

---

### 15. Enable Secure Boot in BIOS

Reboot into BIOS and enable secure boot.

---

### 16. Verify Secure Boot

Boot into NixOS and verify that secure boot is active:

```bash
sudo sbctl status
```

You should see `Secure Boot: enabled` in the output.

---

## Notes

- Make sure to replace `yourhostname` with your actual hostname in all flake commands.
- If you encounter issues with secure boot enrollment, ensure all old keys are deleted from BIOS before enrolling new ones.
