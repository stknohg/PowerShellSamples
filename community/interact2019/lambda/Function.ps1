#
# AutoShutdown = true のタグが付いているEC2インスタンスをシャットダウンさせる関数
#
#Requires -Modules @{ModuleName='AWSPowerShell.NetCore';ModuleVersion='3.3.522.0'}
Write-Host "Start Function..."

# シャットダウン対象のインスタンスを取得
try {
    $instacnes = (Get-EC2Instance -Filter @{Name = 'tag:AutoShutdown'; Value = 'true' }).Instances
    if ($null -eq $instacnes -or $instacnes.Count -eq 0) {
        Write-Host 'No instance found.'
        return 0
    }
}
catch {
    Write-Host "ERROR! : Failed to get EC2 instances."
    Write-Host $_
    return -1
}

try {
    # ループしてシャットダウン
    foreach ($i in $instacnes) {
        $status = Get-EC2InstanceStatus -InstanceId $i.InstanceId
        if ($status.InstanceState.Name -eq 'running') {
            Write-Host ("Attempt to stop EC2 instance {0}." -f ($i.InstanceId))
            Stop-EC2Instance -InstanceId $i.InstanceId
        }
        else {
            Write-Host ("EC2 instance {0} is not running. Skip to shutdown." -f ($i.InstanceId))
        }
    }
}
catch {
    Write-Host "ERROR! : Failed to shutdown EC2 instances."
    Write-Host $_
    return -1
}

Write-Host "End Function."
return $instacnes.Count