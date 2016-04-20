#
# パイプラインのテスト用コマンド1
#
function Command1
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        $InputObject
    )
    Begin
    {
        Write-Host "Command1 Begin($InputObject)..." -ForegroundColor Green
    }
    Process
    {
        Write-Host "Command1 Process($InputObject)..." -ForegroundColor Green
        Write-Output $InputObject
    }
    End
    {
        Write-Host "Command1 End($InputObject)." -ForegroundColor Green
    }
}

#
# パイプラインのテスト用コマンド2
#
function Command2
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        $InputObject
    )
    Begin
    {
        Write-Host "Command2 Begin($InputObject)..." -ForegroundColor Yellow
    }
    Process
    {
        Write-Host "Command2 Process($InputObject)..." -ForegroundColor Yellow
        Write-Output $InputObject
    }
    End
    {
        Write-Host "Command2 End($InputObject)." -ForegroundColor Yellow
    }
}

#
# パイプラインのテスト
#
@(1..10) | Command1 | Command2
