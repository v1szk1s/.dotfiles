setup swap encryption:
swapon --show
sudo swapoff /dev/nvme0n1p3

/etc/crypttab:
    cryptswap /dev/nvme0n1p3 /etc/keys/cryptswap.key luks,swap

sudo mkdir -p /etc/keys
sudo dd if=/dev/urandom of=/etc/keys/cryptswap.key bs=512 count=4
sudo chmod 000 /etc/keys/cryptswap.key
sudo chmod 600 /etc/keys


sudo cryptsetup luksFormat /dev/nvme0n1p3 /etc/keys/cryptswap.key

sudo cryptsetup open /dev/nvme0n1p3 cryptswap --key-file /etc/keys/cryptswap.key

sudo mkswap /dev/mapper/cryptswap


fstab:
    /dev/mapper/cryptswap none swap defaults 0 0


with random key, but no hibernate:
/etc/crypttab:
    cryptswap /dev/nvme0n1p3 /dev/urandom swap,cipher=aes-xts-plain64,size=256

