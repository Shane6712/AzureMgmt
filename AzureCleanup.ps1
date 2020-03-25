$deleteUnattachedDisks=0
$managedDisks = Get-AzDisk
foreach ($md in $managedDisks) {
    # ManagedBy property stores the Id of the VM to which Managed Disk is attached to
    # If ManagedBy property is $null then it means that the Managed Disk is not attached to a VM
    if($md.ManagedBy -eq $null){
        if($deleteUnattachedDisks -eq 1){
            Write-Host "Deleting unattached Managed Disk Id: $($md.Id)"
            $md | Remove-AzDisk -Force
            Write-Host "Deleted unattached Managed Disk Id: $($md.Id) "
        }else{
            $md.Id
        }
    }
 }

$deleteUnattachedNICs=0
$AttachedNICs = Get-AzNetworkInterface
foreach ($NIC in $AttachedNICs) {
      if($NIC.VirtualMachine -eq $null){
        if($deleteUnattachedNICs -eq 1){
            Write-Host "Deleting unattached NICs with Id: $($NIC.Id)"
            $NIC | Remove-AzNetworkInterface -Force
            Write-Host "Deleted unattached NICs with Id: $($NIC.Id) "
        }else{
            $NIC.Id
        }
    }
 }


# remove unattached Public IPs (PIP)
$deleteUnattachedPIPs=0
$AttachedIPs = Get-AzPublicIpAddress
foreach ($PIP in $AttachedIPs) {
        if($PIP.IpConfiguration -eq $null){
        if($deleteUnattachedPIPs -eq 1){
            Write-Host "Deleting unattached IPs with Id: $($PIP.Id)"
            $PIP | Remove-AzPublicIpAddress -Force
            Write-Host "Deleted unattached IPs with Id: $($PIP.Id) "
        }else{
            $PIP.Id
        }
    }
 }