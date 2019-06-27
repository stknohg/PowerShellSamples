#
# Demo 2.
# このデモは時間が余る様ならやる
#

# 事前準備
# CFnからあらかじめ必要なリソースを作成
Import-Module AWSPowerShell.NetCore
Set-DefaultAWSRegion -Region ap-northeast-1
Set-AWSCredential -ProfileName "set your profile"
$params = @{
    StackName = "interact2019-lambda-demo-base";
    TemplateBody = (Get-Content -LiteralPath '.\lambda-base-cfn.yaml' -Raw);
    Parameter = &{
        $p1 = New-Object Amazon.CloudFormation.Model.Parameter 
        $p1.ParameterKey = "BaseName" 
        $p1.ParameterValue = "interact2019-lambda-demo"
        return @($p1)
    };
    Capability = "CAPABILITY_NAMED_IAM"
}
New-CFNStack @params

# Lambda関数を初回Publish
Import-Module AWSLambdaPSCore
$params = @{
    Name = "interact2019-lambda-demo";
    ScriptPath = ".\lambda\Function.ps1"
    IAMRoleArn = ("arn:aws:iam::{0}:role/interact2019-lambda-demo-role" -f ((Get-STSCallerIdentity).Account))
}
Publish-AWSPowerShellLambda @params

# CloudWatch events のトリガーを許可
$params = @{
    FunctionName = "interact2019-lambda-demo";
    Action = "lambda:InvokeFunction";
    Principal = "events.amazonaws.com";
    SourceArn = ("arn:aws:events:ap-northeast-1:{0}:rule/interact2019-lambda-demo-event" -f ((Get-STSCallerIdentity).Account));
    StatementId = "interact2019-lambda-demo-event";
}
Add-LMPermission @params
# CloudWatch eventsのターゲットにLambda関数を追加
$params = @{
    Rule = "interact2019-lambda-demo-event";
    Target = &{
        $func = Get-LMFunctionConfiguration -FunctionName "interact2019-lambda-demo"
        $target = New-object Amazon.CloudWatchEvents.Model.Target            
        $target.Arn = $func.FunctionArn
        $target.Id = $func.RevisionId
        return $target
    };
}
Write-CWETarget @params

# 2回目以降のPublish
$params = @{
    Name = "interact2019-lambda-demo";
    ScriptPath = ".\lambda\Function.ps1"
}
Publish-AWSPowerShellLambda @params
