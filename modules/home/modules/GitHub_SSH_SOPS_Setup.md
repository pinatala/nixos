# Setup SSH Key GitHub dengan SOPS Encryption di NixOS

Dokumentasi lengkap untuk mengatur SSH key GitHub menggunakan SOPS (Secrets Operations) dan Age encryption, terintegrasi dengan NixOS Home Manager.

---

## 📋 Daftar Isi

1. [Prasyarat](#prasyarat)
2. [Langkah 1: Generate Age Key](#langkah-1-generate-age-key)
3. [Langkah 2: Generate SSH Key](#langkah-2-generate-ssh-key)
4. [Langkah 3: Konfigurasi SOPS](#langkah-3-konfigurasi-sops)
5. [Langkah 4: Enkripsi SSH Key](#langkah-4-enkripsi-ssh-key)
6. [Langkah 5: Konfigurasi NixOS](#langkah-5-konfigurasi-nixos)
7. [Langkah 6: Verifikasi Setup](#langkah-6-verifikasi-setup)
8. [Troubleshooting](#troubleshooting)

---

## Prasyarat

Pastikan Anda sudah memiliki:
- NixOS yang sudah terinstall
- `sops-nix` dalam flake inputs
- `home-manager` dalam flake inputs
- Git yang sudah dikonfigurasi
- Akses internet untuk GitHub

Tools yang akan digunakan:
```bash
nix flake show  # Verify sops-nix dan home-manager tersedia
```

---

## Langkah 1: Generate Age Key

Age adalah encryption system modern yang digunakan SOPS untuk mengenkripsi secrets.

### 1.1 Install Age (jika belum ada)

```bash
nix-shell -p age
```

### 1.2 Generate Age Key

Generate age private key yang akan digunakan untuk enkripsi/dekripsi:

```bash
age-keygen -o ~/.config/sops/age/keys.txt
```

**Output yang akan terlihat:**
```
# created: 2026-04-22T10:30:00Z
# public key: age1uwyz7ctcq8a85ryxzaajdtu8sr6qdej4424ynq0fpr5ygqs3zfzsvvru20
AGE-SECRET-KEY-1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJ
```

### 1.3 Simpan Public Key

**Catat public key** (bagian `age1uwyz...`), ini diperlukan untuk `.sops.yaml`:

```bash
# Ambil public key
cat ~/.config/sops/age/keys.txt | grep "public key" | cut -d' ' -f4
```

---

## Langkah 2: Generate SSH Key

Generate SSH key untuk GitHub authentication.

### 2.1 Generate SSH Key ED25519

```bash
ssh-keygen -t ed25519 -C "iqromaulanahadi@gmail.com" -f ~/.ssh/id_ed25519 -N ""
```

**Parameter:**
- `-t ed25519`: Tipe key (modern, recommended)
- `-C`: Comment/email
- `-f`: Lokasi file
- `-N ""`: Passphrase kosong (atau bisa diisi jika ingin lebih aman)

### 2.2 Verifikasi SSH Key

```bash
cat ~/.ssh/id_ed25519
```

Simpan output ini, akan digunakan untuk enkripsi SOPS di langkah berikutnya.

---

## Langkah 3: Konfigurasi SOPS

Buat file `.sops.yaml` di root directory flake Anda.

### 3.1 Buat `.sops.yaml`

```yaml
keys:
  - &my_user_age_key age1uwyz7ctcq8a85ryxzaajdtu8sr6qdej4424ynq0fpr5ygqs3zfzsvvru20

creation_rules:
  - path_regex: secrets.yaml$
    key_groups:
    - age:
      - *my_user_age_key
```

**Penjelasan:**
- `&my_user_age_key`: YAML anchor untuk age public key
- `path_regex: secrets.yaml$`: Regex pattern untuk file yang akan dienkripsi
- `age`: Method enkripsi yang digunakan

⚠️ **PENTING:** Ganti `age1uwyz7ctcq8a85ryxzaajdtu8sr6qdej4424ynq0fpr5ygqs3zfzsvvru20` dengan public key Anda dari Langkah 1.3

---

## Langkah 4: Enkripsi SSH Key

Sekarang kita akan membuat file `secrets.yaml` yang berisi SSH key yang sudah terenkripsi.

### 4.1 Install SOPS

```bash
nix-shell -p sops
```

### 4.2 Buat File `secrets.yaml` (plain text dulu)

Buat file `modules/home/secrets.yaml`:

```yaml
github_ssh_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  b3BlbnNzaC1rZXktdjEAAAAABG5vbmUtbm9uZS1ub25lAAAAAAAAAIcAAAAHc3NoLWVkAA
  ... (isi dari ~/.ssh/id_ed25519) ...
  -----END OPENSSH PRIVATE KEY-----
```

Atau gunakan command untuk insert key langsung:

```bash
# Buka editor dengan template
sops modules/home/secrets.yaml
```

Kemudian paste isi `~/.ssh/id_ed25519` ke field `github_ssh_key`.

### 4.3 Enkripsi dengan SOPS

SOPS akan otomatis mengenkripsi saat Anda menyimpan file:

```bash
# Edit dengan SOPS (akan otomatis terenkripsi saat save)
sops modules/home/secrets.yaml
```

**Format yang terenkripsi:**
```yaml
github_ssh_key: ENC[AES256_GCM,data:GVrRvU3Rv/1uMjstNstbURSaftAOLdzIE3Evo4omINZeJzotwo/G5qYuFVNBEktSNuVVUMsSsVDUWKc46wl+...,iv:eKp671ILvuEgycW60cTEqHLmj+hHY/MLdV/ozbL311Y=,tag:PlwV5nhbf2wP5lWvGirlsw==,type:str]
sops:
    age:
        - recipient: age1uwyz7ctcq8a85ryxzaajdtu8sr6qdej4424ynq0fpr5ygqs3zfzsvvru20
          enc: |
            -----BEGIN AGE ENCRYPTED FILE-----
            ...
            -----END AGE ENCRYPTED FILE-----
    lastmodified: "2026-02-02T12:55:07Z"
    mac: ENC[AES256_GCM,...]
    unencrypted_suffix: _unencrypted
    version: 3.11.0
```

✅ Selesai! File SSH key Anda sekarang terenkripsi dan aman disimpan di git.

---

## Langkah 5: Konfigurasi NixOS

Konfigurasi home-manager untuk menggunakan encrypted SSH key.

### 5.1 Modul SOPS untuk Home Manager

File: `modules/home/modules/_sops.nix`

```nix
{ self, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops = {
    defaultSopsFile = ./../secrets.yaml;
    age.keyFile = "/home/${self.user}/.config/sops/age/keys.txt";
    secrets."github_ssh_key" = {
      path = "/home/${self.user}/.ssh/id_ed25519";
      mode = "0600";
    };
  };
}
```

**Penjelasan:**
- `defaultSopsFile`: Path ke file secrets yang sudah dienkripsi
- `age.keyFile`: Path ke age private key untuk dekripsi
- `secrets."github_ssh_key"`: Define secret yang ingin didekripsi
  - `path`: Lokasi output setelah didekripsi
  - `mode`: Permission file (0600 = read/write untuk owner saja)

### 5.2 Modul SSH Config

File: `modules/home/modules/_ssh.nix`

```nix
{ config, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*".addKeysToAgent = "yes";
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = config.sops.secrets.github_ssh_key.path;
      };
    };
  };
  services.ssh-agent.enable = true;
}
```

**Penjelasan:**
- `addKeysToAgent = "yes"`: Otomatis add key ke SSH agent saat digunakan
- `github.com` block: Konfigurasi khusus untuk GitHub
- `identityFile`: Point ke path dari SOPS module (dekripsi otomatis)
- `ssh-agent`: Service untuk manage SSH keys

### 5.3 Import Modul di Home Manager

File: `modules/home/default.nix`

Pastikan sudah include kedua modul:

```nix
users.${self.user} = { pkgs, ... }: {
  imports = [
    ./modules/_git.nix
    ./modules/_sops.nix    # ← SOPS modul
    ./modules/_ssh.nix     # ← SSH config modul
  ];
  # ... rest of config
};
```

### 5.4 Konfigurasi Git

File: `modules/home/modules/_git.nix`

```nix
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
      user = {
        name = "najika12";
        email = "iqromaulanahadi@gmail.com";
      };
    };
  };
}
```

**Penting:** `url."ssh://git@github.com/".insteadOf = "https://github.com/"` mengubah HTTPS clone menjadi SSH.

---

## Langkah 6: Verifikasi Setup

### 6.1 Build Flake

Rebuild NixOS dengan konfigurasi baru:

```bash
# Di root directory flake Anda
sudo nixos-rebuild switch --flake .#rabbit
```

Ganti `rabbit` dengan hostname Anda jika berbeda.

### 6.2 Verifikasi SSH Key Tersedia

```bash
# Cek apakah file SSH key sudah ada dan terenkripsi dengan benar
ls -la ~/.ssh/id_ed25519

# Cek permission (harus 0600)
stat ~/.ssh/id_ed25519
```

Output yang diharapkan:
```
Access: (0600/-rw-------)
```

### 6.3 Test SSH Connection ke GitHub

```bash
# Test koneksi SSH ke GitHub
ssh -T git@github.com
```

**Output yang diharapkan:**
```
Hi najika12! You've successfully authenticated, but GitHub does not provide shell access.
```

### 6.4 Test Git Clone via SSH

```bash
# Clone repository menggunakan SSH
cd ~/tmp
git clone git@github.com:najika12/my-repo.git

# Atau jika masih di flake repository
git pull
```

### 6.5 Verifikasi SOPS Dekripsi

```bash
# Buka file secrets dengan SOPS untuk verifikasi
sops modules/home/secrets.yaml
```

Jika berhasil, Anda akan melihat SSH key dalam plain text. 

⚠️ **JANGAN commit perubahan apapun saat edit sops file!** (pastikan `.sops.yaml` tidak ada di `.gitignore`)

---

## Troubleshooting

### ❌ Error: "Permission denied (publickey)"

**Kemungkinan penyebab:**
1. SSH key belum ter-dekripsi dengan benar
2. Permission file SSH key tidak 0600
3. SSH agent tidak running

**Solusi:**

```bash
# 1. Cek permission
chmod 600 ~/.ssh/id_ed25519

# 2. Start SSH agent
eval "$(ssh-agent -s)"

# 3. Add key ke agent
ssh-add ~/.ssh/id_ed25519

# 4. Test lagi
ssh -T git@github.com
```

### ❌ Error: "age: recipient is not a valid Bech32-encoded public key"

**Penyebab:** Public key di `.sops.yaml` salah atau tidak lengkap

**Solusi:**
```bash
# Ambil public key yang benar
cat ~/.config/sops/age/keys.txt | grep "public key"

# Update `.sops.yaml` dengan public key yang benar
# Lalu re-encrypt file secrets
sops modules/home/secrets.yaml
```

### ❌ Error: "SOPS_AGE_KEY_FILE not found"

**Penyebab:** Path age key file tidak benar atau file tidak ada

**Solusi:**
```bash
# Verifikasi path
ls -la ~/.config/sops/age/keys.txt

# Jika tidak ada, recreate:
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
```

### ❌ SSH Key masih password-protected

**Penyebab:** Saat generate SSH key, Anda memasukkan passphrase

**Solusi:**
```bash
# Generate ulang tanpa passphrase
ssh-keygen -t ed25519 -C "iqromaulanahadi@gmail.com" \
  -f ~/.ssh/id_ed25519 -N ""

# Update kembali di secrets.yaml
sops modules/home/secrets.yaml
```

### ❌ Git clone masih menggunakan HTTPS bukan SSH

**Penyebab:** Git config tidak ter-update

**Solusi:**
```bash
# Rebuild flake
sudo nixos-rebuild switch --flake .#rabbit

# Atau manual update git config
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"

# Verifikasi
git config --global --get url."ssh://github.com/".insteadOf
```

---

## 🔐 Security Notes

### Best Practices

1. **Age Key Privacy**
   - File `~/.config/sops/age/keys.txt` harus **TIDAK dicommit** ke git
   - Permission harus 0600 (read/write untuk owner saja)
   - Ini adalah private key - jaga dengan baik!

2. **SSH Key Privacy**
   - Enkripsi dengan SOPS memastikan SSH key tidak disimpan plain text
   - Hanya dekripsi saat runtime oleh NixOS
   - `.sops.yaml` boleh di-commit (hanya berisi config, bukan secret)

3. **Git Ignore**
   - Pastikan `.gitignore` include:
     ```
     .sops.yaml.decrypted
     !.sops.yaml
     ~/.config/sops/
     ```

4. **GitHub SSH Key**
   - Add public key (`~/.ssh/id_ed25519.pub`) ke GitHub Settings → SSH Keys
   - Keep private key (`~/.ssh/id_ed25519`) encrypted di SOPS

### Directory Sensitivity

Jangan share atau expose:
- `~/.config/sops/age/keys.txt` (age private key)
- `~/.ssh/id_ed25519` (SSH private key)
- Output saat `sops modules/home/secrets.yaml` dibuka

---

## 📚 Referensi Tambahan

- [SOPS Documentation](https://github.com/mozilla/sops)
- [Age Encryption](https://github.com/FiloSottile/age)
- [sops-nix GitHub](https://github.com/Mic92/sops-nix)
- [NixOS SSH Configuration](https://nixos.org/manual/nixos/stable/options.html#opt-programs.ssh)
- [GitHub SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

---

## 🎯 Checklist Completion

- [ ] Generate age key di `~/.config/sops/age/keys.txt`
- [ ] Generate SSH key di `~/.ssh/id_ed25519`
- [ ] Create `.sops.yaml` dengan public key yang benar
- [ ] Create `modules/home/secrets.yaml` dan enkripsi dengan SOPS
- [ ] Configure `modules/home/modules/_sops.nix`
- [ ] Configure `modules/home/modules/_ssh.nix`
- [ ] Configure `modules/home/modules/_git.nix`
- [ ] Rebuild NixOS dengan `sudo nixos-rebuild switch`
- [ ] Test SSH connection: `ssh -T git@github.com`
- [ ] Test git clone via SSH
- [ ] Verify permission file SSH key (0600)
- [ ] Add public key ke GitHub Settings

---

**Last Updated:** April 22, 2026  
**Author:** Setup Documentation for NixOS SSH + SOPS
