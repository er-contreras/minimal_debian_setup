# MINIMAL DEBIAN SETUP

## First get internet connection

```bash
    su - 
    dhclient <link usb>
```

## Install basics

```cd /etc/apt/sources_list
# deb cdrom:[Debian GNU/Linux 12.11.0 _Bookworm_ - Official amd64 DVD Binary-1 with firmware 20250517-09:52]/ bookworm contrib main non-free-firmware

deb https://deb.debian.org/debian bookworm main non-free-firmware
deb-src https://deb.debian.org/debian bookworm main non-free-firmware

deb https://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src https://security.debian.org/debian-security bookworm-security main non-free-firmware

deb https://deb.debian.org/debian bookworm-updates main non-free-firmware
deb-src https://deb.debian.org/debian bookworm-updates main non-free-firmware
```

## Run the script
```bash setup.sh ```

