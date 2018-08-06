MEMT=$(cat /proc/meminfo | grep -e MemTotal | awk '{print $2}')
RGPT=$(cat /proc/meminfo | grep -e Hugepagesize | awk '{print $2}')
PGS=$(getconf PAGE_SIZE)
cat >> /etc/sysctl.conf << EOF
vm.nr_hugepages = `echo ${MEMT}*0.7/${RGPT}+1 | bc`
kernel.shmmax = `echo ${MEMT}*0.5*1024 | bc | cut -d "." -f1`
kernel.shmall = `echo ${MEMT}*0.7/${PGS}*1024 | bc`
EOF
