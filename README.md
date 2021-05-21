# MigrageFromVMWaretoPVE
Migrate Script to export VMWare Machines to OVF for import later in PVE

This is for my personal use but I wanted to share too :-)

If you feel that there could/can be improvements, please do!

This is based on ESXi 6.7, most VMs are version 4 and above

--- Important ----

This will only work when you extract ovftools from its installer and copy the entire folder to a datastore locally on ESX
It would word also with a third-party server too, but it would be overkill as this is using the resoures of the ESX and is always on and 
has local storage to use = I/O speed and no network unless to a NFS.

