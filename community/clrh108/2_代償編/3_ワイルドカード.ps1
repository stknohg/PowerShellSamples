cd C:\Temp

# dir -Path [1-2]?? と同様
dir [1-2]??


# ファイル、フォルダ名に[]があるとダメ
Get-Item '[001]_Rock\'

# ワイルドカード文字をエスケープする必要がある
Get-Item '`[001`]_Rock\'

# -LiteralPath パラメーターはワイルドカード検索しない
Get-Item -LiteralPath '[001]_Rock\'