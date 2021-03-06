#!/bin/sh
## To execute on ESX
## Usage: ./export_vm.sh %VMNAME% (visible in inventory)
vm=$1
vmid=$(echo `vim-cmd vmsvc/getallvms | grep "$vm" | awk '{print $1}'`)
state=$(vim-cmd vmsvc/power.getstate $vmid | awk '{ print $2 }' | tail -n +2)
ovftool=/location/on/esx/where/vmware-ovftool
repo=/location/on/esx/where/storing/ovf

if [[ $state == on ]]
then
  vim-cmd vmsvc/power.shutdown $vmid
## Wait till the VM is fully off
echo "Waiting for $vm to poweroff..."
until vim-cmd vmsvc/power.getstate $vmid | grep -i "off" > /dev/null 2<&1
do
  sleep 5
done
  $ovftool/ovftool --noSSLVerify -dm=thin --parallelThreads=6 vi://root:ESXPASSWORDHERE@localhost/"$vm" $repo || vim-cmd vmsvc/power.on $vmid
  vim-cmd vmsvc/power.on $vmid
else
  $ovftool/ovftool --noSSLVerify -dm=thin --parallelThreads=6 vi://root:ESXPASSWORDHERE@localhost/"$vm" $repo || vim-cmd vmsvc/power.on $vmid
  vim-cmd vmsvc/power.on $vmid
fi
exit 0
