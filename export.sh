#!/bin/sh
vm=$1
vmid=$(echo `vim-cmd vmsvc/getallvms | grep "$vm" | awk '{print $1}'`)
state=$(vim-cmd vmsvc/power.getstate $vmid | awk '{ print $2 }' | tail -n +2)

if [[ $state == on ]]
then
  vim-cmd vmsvc/power.shutdown $vmid
  sleep 10  # Give the VM time to shutdown gracefully
  /location/to/where/vmware-ovftool/ovftool --noSSLVerify -dm=thin --parallelThreads=6 vi://root:PASSWORDHERE@localhost/"$vm" /location/to/save/OVF/Folder
  vim-cmd vmsvc/power.on $vmid
else
  /location/to/where/vmware-ovftool/ovftool --noSSLVerify -dm=thin --parallelThreads=6 vi://root:PASSWORDHERE@localhost/"$vm" /location/to/save/OVF/Folder
  vim-cmd vmsvc/power.on $vmid
fi
exit 0
