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

The script once ran locally on the ESXi will:

1. Find the VMID of the "NAME-of-VM"
2. Poll to see if NAME-of-VM is "on"
3. If NAME-of-VM is "on" = shutdown
3a. Wait 10 seconds to allow graceful shutdown
3b. Export "NAME-of-VM" as thin-formatted OVF to location of choice
4. Power (back)On NAME-of-VM

---
Later, import OVF into PVE or even other Environments (other ESXis too!)

I suppose that this could be an even more **ghetto** backup implementation too if ran via CRON?

Have fun!
