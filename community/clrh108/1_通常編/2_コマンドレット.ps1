#
# OSの起動と停止のイベントログを抽出してメール送信
# 勤怠の管理なんかに使えるかもしれませんね(:
#
# イベントログを抽出して $mailMessage 変数に設定
Get-WinEvent -LogName System -FilterXPath "*[System[Provider[@Name='Microsoft-Windows-Kernel-General'] and (EventID=12 or EventID=13)]]" | 
    Select-Object TimeCreated, Id, Message | 
    Format-Table -Autosize |
    Out-String |
    Set-Variable -Name mailMessage

# outlook.jp からメールを送信
$params = @{
    To         = '宛先メールアドレス';
    From       = '<あなたのアカウント>@outlook.jp';
    Subject    = 'PCの起動・停止ログ';
    Body       = $mailMessage;
    Encoding   = 'utf8'
    SmtpServer = 'smtp-mail.outlook.com';
    Port       = 587;
    UseSsl     = $true
    Credential = New-Object PSCredential -ArgumentList ('<あなたのアカウント>@outlook.jp', (ConvertTo-SecureString '<あなたのパスワード>' -AsPlainText -Force));
}
Send-MailMessage @params
