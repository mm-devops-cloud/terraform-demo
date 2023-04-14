$env:TF_LOG="TRACE"
$env:TF_LOG_PATH='{1}/logs/{0}-terraform.log' -f (Get-Date -Format yyyy-MM-dd-HH-mm-ss), $PSScriptRoot

terraform apply -auto-approve