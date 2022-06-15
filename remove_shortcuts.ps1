
function Pin-App { 
    param([string]$appname,[switch]$unpin)
    try {
        if ($unpin.IsPresent){
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Désépingler de la barre des tâches'} | %{$_.DoIt(); $exec = $true}
            return "App '$appname' unpinned from Start"
        } else {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Start" Pin|Pin to Start'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
        }
    } catch {
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
    }
}


Pin-App "Word" -unpin
Pin-App "Excel" -unpin
Pin-App "Powerpoint" -unpin
Pin-App "Skype for Business" -unpin
Pin-App "Internet Explorer" -unpin

D:\devstuff\SetDefaultBrowser.exe HKCU Firefox-2F0750A6881FFE70

# Write-Output "Chrome set as default browser"
#Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name 'DefaultCookiesSetting' -value '0x00000001'
#Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome\Recommended' -Name 'BlockThirdPartyCookies' -value '0x00000000'

# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google /f

#  Write-Output "Policy chrome remises correctement"
