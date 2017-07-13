# 変数定義
$i = 123
$i.GetType().FullName # -> System.Int32 を返す
$i.ToString()

# 配列
$array = @(1, 2, 3)
$array = 1, 2, 3

# ハッシュテーブル
$hash = @{ Name = "stknohg"; Height = 0xA7 }

# if文
$grade = 92
if ($grade -ge 90) { "Grade A" }
elseif ($grade -ge 80) { "Grade B" }
elseif ($grade -ge 70) { "Grade C" }
elseif ($grade -ge 60) { "Grade D" }
else { "Grade F" }

# for文
for ($i = 1; $i -le 5; $i++) {
    echo ($i * $i)
}
# foreach文
foreach ($i in 1..5) {
    echo ($i * $i)
}

# while文
$i = 1
while ($i –le 5) {
    echo ($i * $i)
    ++$i
}
# do-while文
$i = 1
do {
    echo ($i * $i)
}
while (++$i -le 5)

# switch文
switch ($Host.Name) {
    "Windows PowerShell ISE Host" {
        $result = 1
    }
    "Visual Studio Code Host" {
        $result = 2
    }
    Default {
        $result = 3
    }
}

# 関数
function Sqrt([int]$Value) {
    Write-Output "${Value}の平方根は?"
    return [Math]::Sqrt($Value)
}

# 高度な関数
function Invoke-Sqrt {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [int]$Value
    )
    Write-Output "${Value}の平方根は?"
    return [Math]::Sqrt($Value)
}

# フィルタ
filter Sqrt {
    if ($_ -isnot [int]) {
        Write-Error "${_}はInt型のみ指定可能です"
        return
    }
    Write-Output "${_}の平方根は?"
    return [Math]::Sqrt($_)
}

# trap
trap { $j = 2 }
$j = 0; $v = 10 / $j

# try-catch-finally
try {
    $j = 0; $v = 10 / $j
}
catch {
    $j = 2
}

# class
class Device {
    [string]$Brand
    [string]$Model
    [string]$VendorSku

    [string]ToString() {
        return ("{0}|{1}|{2}" -f $this.Brand, $this.Model, $this.VendorSku)
    }
}

# enum
enum MyFlag {
    Off = 0
    On = 1
}

# コマンドレット
{
    Write-Output "Hello World!"
    Write-Host "Hello World!" -ForegroundColor Green
    Get-ChildItem | Get-Member
    Get-Command Get-*
    Get-ChildItem | Where-Object { $_.Name -like "osc*" }
    Get-Content .\sample.txt | Select-String "osc"
    Get-ChildItem -File | ForEach-Object { ren $_.FullName "$($_.Name).orig" }
    Get-ChildItem | Select-Object Name, CreationTime
}

# パイプライン
@(1, 2, @(3, 4), 5) | `
    % { echo "$($_.GetType())型の値 $($_) が渡されました…"}

function Cmdlet1 {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        $InputObject
    )
    Begin {
        Write-Host "Command1 Begin($InputObject)..." -ForegroundColor Green
    }
    Process {
        Write-Host "Command1 Process($InputObject)..." -ForegroundColor Green
        Write-Output $InputObject
    }
    End {
        Write-Host "Command1 End($InputObject)." -ForegroundColor Green
    }
}

function Cmdlet2 {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        $InputObject
    )
    Begin {
        Write-Host "Command2 Begin($InputObject)..." -ForegroundColor Green
    }
    Process {
        Write-Host "Command2 Process($InputObject)..." -ForegroundColor Green
        Write-Output $InputObject
    }
    End {
        Write-Host "Command2 End($InputObject)." -ForegroundColor Green
    }
}

@(1..5) | Cmdlet1 | Cmdlet2

# JSON
@{
    id = 1;
    name = 'stknohg'
    items = @(123, 456, 789)
} | ConvertTo-Json

@"
{
  "name":  "stknohg",
  "id":  1,
  "items":  [ 123, 456, 789 ]
}
"@ | ConvertFrom-Json

# Pester
function Add-Numbers($a, $b) {
    return $a + $b
}
Describe "Add-Numbers" {
    It "adds positive numbers" {
        Add-Numbers 2 3 | should be 5
    }
    It "ensures that that 2 + 2 does not equal 5" {
        Add-Numbers 2 2 | should not be 5
    }
}
