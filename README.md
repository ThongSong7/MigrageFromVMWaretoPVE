# MigrageFromVMWaretoPVE
Migrate Script to export VMWare Machines to OVF for import later in PVE
This is for my personal use but I wanted to share too :-)
If you feel that there could/can be improvements, please do!

This is based on ESXi 6.7, most VMs are version 4 and above

--- Important ----

This will only work when you extract ovftools from its installer and copy the entire folder to a datastore locally on ESX
It would word also with a third-party server too, but it would be overkill as this is using the resoures of the ESX and is always on and 
has local storage to use = I/O speed and no network unless to a NFS.

How to copy and use ovftool to/on ESX? ==> https://williamlam.com/2012/05/how-to-deploy-ovfova-in-esxi-shell.html

---

Usage:  ./export.sh NAME-of-VM

*/ "NAME-of-VM" must be visible name of VM in ESX datastore (otherwise ovftool will not find it) /*

The script once ran locally on the ESXi will:

- Find the VMID of the "NAME-of-VM"
- Poll to see if NAME-of-VM is "on"
- If NAME-of-VM is "on" then shutdown (to be able to use ovftool)
- If NAME-of-VM is "off" will skip 10 second-wait
- Wait 10 seconds to allow graceful shutdown
- Export "NAME-of-VM" as thin-formatted OVF to location of choice
- Power (back)On NAME-of-VM

---
Later, import OVF into PVE or even other Environments (other ESXis too!)

I suppose that this could be an even more **ghetto** backup implementation too if ran via CRON?

Have fun!
