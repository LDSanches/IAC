[ -f /export/.swap/.swapfile ] && swapoff /export/.swap/.swapfile || mkdir -p /export/.swap
dd if=/dev/zero of=/export/.swap/.swapfile bs=1024 count=16000000
mkswap /export/.swap/.swapfile
swapon /export/.swap/.swapfile

[ -z "`grep swapfile /etc/fstab`" ] && echo -e "/export/.swap/.swapfile\tswap\t\t\tswap\tdefaults\t0 0" >> /etc/fstab
