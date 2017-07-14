# ※ PowerShell Core Beta 3でバグって接続不可
#    https://github.com/PowerShell/psl-omi-provider/issues/101

#
# PSRemoting(サーバー側)
#
sudo apt-get install -y omi-psrp-server
# 状態確認
service omid status

#
# PSRemoting(クライアント側)
#
# Enter-PSSessionで接続
$HostName = 'hostname'
$UserName = 'username'
$Option = New-PSSessionOption -SkipCACheck -SkipRevocationCheck -SkipCNCheck
Enter-PSSession -ComputerName $HostName -Credential $UserName -Authentication basic -UseSSL -SessionOption $Option