#
# PowerShellでJSON (Web API)
#

# 札幌のお天気 (地域ID : 016010)
# * http://weather.livedoor.com/area/forecast/016010
#
# API仕様
# * http://weather.livedoor.com/weather_hacks/webservice

# Livedoorお天気Webサービスから札幌の天気予報を取得
Invoke-RestMethod -Uri 'http://weather.livedoor.com/forecast/webservice/json/v1?city=016010' | 
    ForEach-Object {
    # 概要の出力
    Write-Host '天気情報の概要' -ForegroundColor Green
    [PSCustomObject]@{
        PublicTime  = $_.publicTime;
        Area        = $_.location.area;
        Prefecture  = $_.location.prefecture;
        City        = $_.location.city;
        Description = $_.description.text;
    } | Format-List

    # 天気予報の出力
    Write-Host '天気予報' -ForegroundColor Green
    $_.forecasts | ForEach-Object {
        [PSCustomObject]@{
            Date           = [Datetime]$_.date
            DateLabel      = $_.datelabel
            Telop          = $_.telop
            MinTemperature = $_.temperature.min.celsius
            MaxTemperature = $_.temperature.max.celsius
        }
    } | Format-Table -AutoSize
}