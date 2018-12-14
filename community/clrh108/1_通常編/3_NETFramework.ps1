# Add-Type で外部のアセンブリを取り込むことができる
Add-Type -Path '<使用したいアセンブリ名>.dll'

# GAC等、アセンブリ名だけで解決できる場合は -AssemblyName パラメーターでも可
Add-Type -AssemblyName 'System.Windows.Forms'


# 直接C#などのソースコードを取り込み可能
Add-Type -TypeDefinition 'C#等のソースコードによるクラス定義'

# -MemberDefinition パラメーターなんてのもある
Add-Type -MemberDefinition 'C#等のソースコードによるStaticな関数定義' -Namespace 'ルート名前空間' -Name 'クラス名'

#
# PowerShellでSelenium WebDriver(Chrome)
# * https://blog.shibata.tech/entry/2018/06/13/233932
# 
# Add-Type
Add-Type -Path .\WebDriver.dll

$url = 'https://googlesamples.github.io/web-fundamentals/fundamentals/security/prevent-mixed-content/active-mixed-content.html'
#$url = 'https://blog.shibata.tech/' # 警告ログなしの場合
try {
    # 開始
    $options = [OpenQA.Selenium.Chrome.ChromeOptions]::new()
    # ヘッドレス、log-level=3(LOG_FATAL)
    $options.AddArguments("headless", "disable-gpu", "log-level=3")
    $driver = [OpenQA.Selenium.Chrome.ChromeDriver]::new($options)

    # ブラウザログチェック
    Write-Host ("{0} をチェックします..." -f $url) -ForegroundColor Green
    $driver.Url = $url
    $logs = $driver.Manage().Logs.GetLog('browser')
    $mixedContentLogs = $logs | Where-Object { $_.Message -like "*Mixed Content:*"}
    if (@($mixedContentLogs).Count -eq 0) {
        Write-Host 'Mixed Contentではありませんでした。' -ForegroundColor Green
    } else {
        Write-Warning ('Mixed Contentログが{0}件ありました。' -f @($mixedContentLogs).Count)
        $mixedContentLogs | Format-List
    }
} finally {
    # 終了
    $driver.Quit()
}

#
# C#で書いたクラスをAdd-Typeする
# * https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type
#
$Source = @"
public class BasicTest
{
    public static int Add(int a, int b)
    {
        return (a + b);
    }
    public int Multiply(int a, int b)
    {
    return (a * b);
    }
}
"@
Add-Type -TypeDefinition $Source

# BasicTestクラスの静的メソッドを使う
[BasicTest]::Add(4, 3)
# もちろんインスタンスを生成することも可能
$BasicTestObject = New-Object BasicTest
$BasicTestObject.Multiply(5, 2)
