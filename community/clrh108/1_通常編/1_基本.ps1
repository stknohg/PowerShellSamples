# 現在時刻を取得
$now = Get-Date
Write-Output $now

# $now 変数は System.Datetime 型
Write-Output ($now.GetType().FullName)

# Datetime型のプロパティやメソッドを使って
# 翌日の日付を計算
$tomorrow = $now.Date.AddDays(1)
Write-Output $tomorrow
