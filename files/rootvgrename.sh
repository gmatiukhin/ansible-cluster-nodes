# Must be run with root permissions 
# sudo will be sufficient

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

read -p "Enter old vg name: "
oldvg=$REPLY
read -p "Enter new vg name: "
newvg=$REPLY

vgrename $oldvg $newvg
oldvg=$(echo $oldvg | sed "s/-/--/g")

echo "Changing LVM names"
sed -i "s/${oldvg}/${newvg}/g" /etc/fstab
sed -i "s/${oldvg}/${newvg}/g" /boot/grub/grub.cfg
sed -i "s/${oldvg}/${newvg}/g" /etc/initramfs-tools/conf.d/resume

update-initramfs -c -k all
