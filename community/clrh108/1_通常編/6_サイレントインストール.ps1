# サンプルなのでダウンロード先は固定
mkdir 'C:\Temp'

# MSIファイルをダウンロード
$msiSource = 'https://github.com/PowerShell/PowerShell/releases/download/v6.1.1/PowerShell-6.1.1-win-x64.msi'
$msiOutPath = 'C:\Temp\PowerShell-6.1.1-win-x64.msi'
Invoke-WebRequest -Uri $msiSource -OutFile $msiOutPath

# ダウンロードしたMSIファイルを実行し、サイレントインストール
$params = @{
    FilePath     = 'msiexec.exe';
    ArgumentList = @('/i', $msiOutPath, '/passive', '/le', 'C:\Temp\PowerShell-6.1.1-win-x64-install.log');
    Wait         = $true;
    PassThru     = $true;
}
$proc = Start-Process @params
switch ($proc.ExitCode) {
    0 {
        # インストール成功
        break
    }
    3010 {
        # インストール成功 : 要再起動
        break
    }
    1602 {
        # インストールが途中でキャンセルされた
        Write-Warning "Installation canceled."
        break
    }    
    Default {
        # その他のエラー
        Write-Error ("Failed to install.(Exit code={0})" -f $_)
        break
    }
}