#
# Demo 1. 
#
cd ~/interact

#
# PowerShell Core 6.0 新機能
#
# 01. プログラム名の変更
# ※ Bash on Ubuntuでの実行を想定
cat /etc/lsb-release
which pwsh

# 02. バージョン確認
$PSVersionTable
# PowerShell Core 独自の変数
$IsWindows
$IsLinux
$IsMacOS

# 03. エンコーディング回り
"平成生まれ" > ./natural-born-heisei.txt
nkf --guess ./natural-born-heisei.txt
"平成生まれ2" | Out-File ./natural-born-heisei2.txt
nkf --guess ./natural-born-heisei2.txt

$encoding = [Text.Encoding]::GetEncoding(51932)
"平成生まれ3" | Out-File -FilePath ./natural-born-heisei3.txt -Encoding $encoding
nkf --guess ./natural-born-heisei3.txt

# PowerShell 5.1まで
# Get-Content -Path .\Sample.bin -Encoding Byte
# PowerShell 6.0からは -AsByteStream を使う
Get-Content -Path ./natural-born-heisei.txt -AsByteStream

# 04. & によるジョブ実行
$title = "パンクティーンエイジガールデスロックンロールヘブン"
Write-Output "$title すき" &
Get-Job | Receive-Job

# 05. エイリアス
# ※ PowerShell Core on Ubuntuでの実行を想定
Get-Command curl | Select-Object Name, CommandType, Path
Get-Command wget | Select-Object Name, CommandType, Path
# ロケーションはPowerShell独自の概念なので cd はエイリアスを外すことはできない
Get-Command cd

#
# PowerShell Core 6.1 新機能
# ※ Windows Terminal上だとヒアストリングの扱いがおかしい...
#    これはWindows上のPowerShell Coreを直接実行してデモする
$content = @"
# 平成生まれ

出典: フリー百科事典『ウィキペディア（Wikipedia）』

『__平成生まれ__』（へいせいうまれ）は、ハトポポコによる日本の漫画作品。  
「女子高生たちの日常会話を題材に、シュールな笑いを描き」とうたわれている4コマ漫画。

## 単行本

* ハトポポコ 『平成生まれ』 芳文社〈まんがタイムKRコミックス〉、全2巻
    1. 第1巻：2011年12月26日発売
    1. 第2巻：2012年11月27日発売
* 『平成生まれ2』
    1. 第1巻：2014年6月27日発売
    1. 第2巻：2015年7月27日発売
* 『平成生まれ3』
    1. 第1巻：2016年7月27日発売
"@
$content | Show-Markdown
$content | ConvertFrom-Markdown | Select-Object -ExpandProperty Html
# Desktopがある環境のみ
$content | Show-Markdown -UseBrowser

#
# PowerShell Core 6.2 新機能
#
Get-ExperimentalFeature
Enable-ExperimentalFeature -Name PSTempDrive -Scope CurrentUser
# コンソールを再起動
Get-PSDrive 
Get-PSDrive -Name Temp
dir Temp:\
# 後始末
Disable-ExperimentalFeature -Name PSTempDrive -Scope CurrentUser
