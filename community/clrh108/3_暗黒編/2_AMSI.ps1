#
# AMSIをお試し(通常ではEICAR文字列を認識しないのでデバッグモードに一時的に設定を変える)
#
try {
    # デバッグ用設定
    [System.Management.Automation.Internal.InternalTestHooks]::SetTestHook("UseDebugAmsiImplementation", $true)

    # 適当にEICARテストファイルをつくってお試し
    $EICAR_STRING_B64 = "awZ8EmMWc3JjaAdvY2lrBgcbY20aBHBwGgROF3Z6cHJhHmBncn13cmF3HnJ9Z3plemFmYB5ndmBnHnV6f3YSF3sYexk= "
    $bytes = [System.Convert]::FromBase64String($EICAR_STRING_B64)
    $EICAR_STRING = -join ($bytes | % { [char]($_ -bxor 0x33) })
    Invoke-Expression -Command "echo '$EICAR_STRING'"
} finally {
    [System.Management.Automation.Internal.InternalTestHooks]::SetTestHook("UseDebugAmsiImplementation", $false)
}
