# リダイレクトの文字コードを変える方法(PowerShell 5.1以降で有効)
# パラメーターのデフォルト値を指定することで変更
$PSDefaultParameterValues["Out-File:Encoding"] = 'utf8'

# Windows PowerShellでBOM無しUTF-8でファイル保存する方法
# 詳細は https://blog.shibata.tech/entry/2016/10/02/154329
@'
2018.12.15
CLR/H #108 ～力こそパワー～
'@  | ForEach-Object { [Text.Encoding]::UTF8.GetBytes($_) } `
    | Set-Content -Path ".\Utf8NoBOM.txt" -Encoding Byte

# PowerShellはパイプラインが基本
# リダイレクトの代わりに Out-File でエンコーディングを明示する
Write-Output "力こそパワー" | 
    Out-File -FilePath '.\output.txt' -Encoding utf8

# PowerShell CoreならEncodingオブジェクトをそのまま指定できる
$encoding = [System.Text.Encoding]::GetEncoding(51932) # EUC
Write-Output "力こそパワー" | 
    Out-File -FilePath '.\output.txt' -Encoding $encoding