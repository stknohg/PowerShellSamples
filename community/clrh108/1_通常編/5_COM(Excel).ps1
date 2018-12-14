#
# PowerShellでExcelのよくあるパターン
#
$excel = New-Object -ComObject 'Excel.Application'
try {
    # シート作成
    $workbook = $excel.Workbooks.Add()
    $sheet = $workbook.ActiveSheet
    # シート名の設定
    $sheet.Name = '容量'
    # セルに書き込み
    $sheet.Cells.Item(1, 1) = 'ドライブ'
    $sheet.Cells.Item(1, 2) = '使用量(GB)'
    $sheet.Cells.Item(1, 3) = '容量(GB)'
    $i = 2
    Get-PSDrive -PSProvider FileSystem | ForEach-Object {
        $sheet.Cells.Item($i, 1) = $_.Name
        $sheet.Cells.Item($i, 2) = [int]($_.Used / 1024 / 1024 / 1024)
        $sheet.Cells.Item($i, 3) = [int](($_.Used + $_.Free) / 1024 / 1024 / 1024)
        $i++
    }
    # 名前を付けて上書き保存
    $excel.DisplayAlerts = $false
    $workbook.SaveAs('C:\Temp\sample.xlsx')
    $excel.Quit()
    # $excel.Visible = $true
} finally {
    # COMオブジェクトの解放は非常にめんどうくさい...
    [void][System.Runtime.Interopservices.Marshal]::ReleaseComObject($sheet)
    [void][System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook)
    [void][System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)
    [GC]::Collect()
}

#
# モジュールを使ったパターン
# このモジュールならWindows以外でも動作する
#
Install-Module ImportExcel -scope CurrentUser

Get-PSDrive -PSProvider FileSystem | 
    ForEach-Object {
    [PSCustomObject]@{
        'ドライブ'    = $_.Name;
        '使用量(GB)' = [int]($_.Used / 1024 / 1024 / 1024);
        '容量(GB)'  = [int](($_.Used + $_.Free) / 1024 / 1024 / 1024);
    }
} | Export-Excel -Path C:\Temp\sample2.xlsx -WorksheetName '容量'

# Windows以外
Get-PSDrive -PSProvider FileSystem | 
    ForEach-Object {
    [PSCustomObject]@{
        'ドライブ'    = $_.Name;
        '使用量(GB)' = [int]($_.Used / 1024 / 1024 / 1024);
        '容量(GB)'  = [int](($_.Used + $_.Free) / 1024 / 1024 / 1024);
    }
} | Export-Excel -Path ~/sample2.xlsx -WorksheetName '容量'