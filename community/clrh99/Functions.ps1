#
# ファンクションのサンプル
#
function WriteHello([string]$Message)
{
    return Write-Output ("Hello {0}!" -f $Message)
}

#
# スクリプトコマンドレットのサンプル
#
function Write-Hello
{
    [CmdletBinding()]
    [OutputType([string])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Message
    )
    Begin
    {
        Write-Verbose "Begin function..."
    }
    Process
    {
        Write-Verbose ("Process input value {0}..." -f $Message)
        return Write-Output ("Hello {0}!" -f $Message)
    }
    End
    {
        Write-Verbose "End function."
    }
}

#
# フィルターのサンプル
#
filter HelloFilter
{
    return Write-Output ("Hello {0}!" -f $_)
}
