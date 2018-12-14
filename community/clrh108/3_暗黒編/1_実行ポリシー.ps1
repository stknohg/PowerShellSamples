# 現在の実行ポリシーを確認
Get-ExecutionPolicy -List

# CurrentUserスコープで実行ポリシーを設定 (管理者権限不要)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser