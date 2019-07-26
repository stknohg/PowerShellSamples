param($Timer)
#
# AutoShutdown = true のタグが付いている仮想マシンをシャットダウンさせる関数
# * 事前にマネージド IDを割り当て、仮想マシンに対して適切なアクセス権を持たせる様にしてください。
#
Write-Host "Start Function..."

# シャットダウン対象の仮想マシンを取得
try {
    $VMs = Get-AzVM | Where-Object { $_.Tags['AutoShutdown'] -eq 'true' }
    if ($null -eq $VMs -or $VMs.Count -eq 0) {
        Write-Host 'No Virtual Machine found.'
        return
    }
}
catch {
    Write-Host "ERROR! : Failed to get Virtual Machines."
    Write-Host $_
    return
}

try {
    # ループしてシャットダウン
    foreach ($v in $VMs) {
        $status = Get-AzVM -Name $v.Name -Status | Select-Object -ExpandProperty PowerState
        if ($status -eq 'VM running') {
            Write-Host ("Attempt to stop Virtual Machine {0}." -f ($v.Name))
            Stop-AzVM -ResourceGroupName $v.ResourceGroupName -Name $v.Name -Force
        }
        else {
            Write-Host ("Virtual Machine {0} is not running. Skip to shutdown." -f ($v.Name))
        }
    }
}
catch {
    Write-Host "ERROR! : Failed to shutdown Virtual Machine."
    Write-Host $_
    return
}

Write-Host "End Function."
