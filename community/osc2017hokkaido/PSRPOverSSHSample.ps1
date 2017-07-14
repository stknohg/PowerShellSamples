#
# PSRP over SSH(サーバー側)
#

# /etc/ssh/sshd_config に
#
# Subsystem powershell powershell -sshs -NoLogo -NoProfile
#
# を追加してsshdを再起動する
 
#
# PSRP over SSH(クライアント側)
#
# ssh.exeのインストール
Invoke-WebRequest -Uri "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v0.0.17.0/OpenSSH-Win64.zip" -OutFile "OpenSSH-Win64.zip"
Expand-Archive -Path ".\OpenSSH-Win64.zip" -DestinationPath "C:\Program Files\"
[Environment]::SetEnvironmentVariable('PATH', [Environment]::GetEnvironmentVariable('PATH') + ';C:\Program Files\OpenSSH-Win64')

# SSH接続 (PowerShell Core 6.0で実行する)
$HostName = 'hostname'
$UserName = 'username'
$Session = New-PSSession -HostName $HostName -UserName $UserName
Enter-PSSession -Session $Session
