# CLR/H #109 ～夏だ一番初心祭り～

セッションは[Interact 2019](https://interact.connpass.com/event/91059/)発表した内容の再演です。  
デモでAWS Lambdaの他にAzure Functionsのコードを増やしています。

## PowerShell on Azure Functions の簡単なメモ

* 2019.07.27 時点では PowerShell Core 6.2.0 基盤
* ランタイム
    * https://github.com/Azure/azure-functions-powershell-worker
    * https://github.com/Azure/azure-functions-powershell-worker/blob/dev/docs/designs/PowerShell-AzF-Overall-Design.md
* ランタイムに組み込み済みのモジュールは以下
    * Az.* なモジュール
    * Microsoft.Azure.Functions.PowerShellWorker
* プロファイルは通常関数本体の一段上位のディレクトリにあり、コールドスタート時に読み込まれる
    * profile.ps1

### Microsoft.Azure.Functions.PowerShellWorker

以下の3つのコマンドレットが公開されている。  

* [Get-OutputBinding](https://github.com/Azure/azure-functions-powershell-worker/blob/dev/docs/cmdlets/Get-OutputBinding.md)
* [Push-OutputBinding](https://github.com/Azure/azure-functions-powershell-worker/blob/dev/docs/cmdlets/Push-OutputBinding.md)
* [Trace-PipelineObject](https://github.com/Azure/azure-functions-powershell-worker/blob/dev/docs/cmdlets/Trace-PipelineObject.md)

