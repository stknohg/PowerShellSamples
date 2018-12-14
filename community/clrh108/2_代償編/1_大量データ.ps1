# やってはいけない処理
# 124249件から227件抽出するのにメモリを約220MB消費する
$contents = Get-Content -LiteralPath 'KEN_ALL.CSV'
$rows = $contents | Where-Object { $_ -like '*新発田市*'}

# 変数に大量のデータをためない処理
# 124249件から227件抽出してもメモリの消費はほとんどない
$rows = Get-Content -LiteralPath 'KEN_ALL.CSV' `
  | Where-Object { $_ -like '*新発田市*'}