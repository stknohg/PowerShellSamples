# PowerShell(MSI)
Invoke-WebRequest `
    -Uri "https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-beta.4/PowerShell-6.0.0-beta.4-win10-win2016-x64.msi" `
    -OutFile "$($pwd.Path)\PowerShell-6.0.0-beta.4.msi"
Start-Process `
    -FilePath msiexec.exe `
    -ArgumentList @("/i", "$($pwd.Path)\PowerShell-6.0.0-beta.4.msi", "/passive") `
    -Wait -PassThru
