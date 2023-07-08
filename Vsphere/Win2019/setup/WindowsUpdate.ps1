
Get-PackageProvider -name nuget -force
Install-Module PSWindowsUpdate -confirm:$false -force
Get-WindowsUpdate -MicrosoftUpdate -install -IgnoreUserInput -acceptall -AutoReboot | Out-File -filepath 'c:\windowsupdate.log' -append