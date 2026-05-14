# Artix Encryption Guide
full docs
- https://wiki.artixlinux.org/Main/Installation
- https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system

### Partition your disk
```sh
lsblk
cfdisk /dev/nvme0n1

# root
cryptsetup -v luksFormat /dev/nvme0n1p3
cryptsetup open /dev/nvme0n1p3 cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

# boot
mkfs.fat -F 32 /dev/nvme0n1p1
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

# swap
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
```

### Install base system
```sh
dinitctl start ntpd

basestrap /mnt base base-devel dinit elogind-dinit
basestrap /mnt linux linux-firmware
basestrap /mnt lvm2 cryptsetup vim grub efibootmgr openresolv iwd-dinit sof-firmware intel-ucode linux-headers ntp-dinit

fstabgen -U /mnt >> /mnt/etc/fstab

artix-chroot /mnt
```

### Configure the base system
```sh
ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
hwclock --systohc

# uncomment en_US
vim /etc/locale.gen
locale-gen

echo 'LANG="en_US.UTF-8"' >> /etc/locale.conf
echo 'LC_COLLATE="C"' >> /etc/locale.conf

echo x13 >> /etc/hostname
echo '127.0.1.1        x13.localdomain  x13' >> /etc/hosts

# edit line 55 -> add `encrypt lvm2` after `block`
vim /etc/mkinitcpio.conf 
mkinitcpio -P

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub

vim /etc/default/grub
# cryptdevice=UUID=LUKS_UUID_HERE:cryptroot root=UUID=ROOT_UUID_HERE
sed -i "s|LUKS_UUID_HERE|$(blkid -o value -s UUID /dev/nvme0n1p3)|" /etc/default/grub
sed -i "s|ROOT_UUID_HERE|$(blkid -o value -s UUID /dev/mapper/cryptroot)|" /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
```

### etc.
```
passwd

useradd -m -s /bin/bash chavi
passwd chavi

usermod -aG wheel chavi

EDITOR=vim visudo

dinitctl enable iwd
dinitctl enable ntpd
```

create `/etc/iwd/main.conf`
```
[General]
EnableNetworkConfiguration=true
[Network]
RoutePriorityOffset=200
NameResolvingService=resolvconf
```

```sh
exit
umount -R /mnt
reboot
```

