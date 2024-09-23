param(
    [Parameter(Mandatory)][Validateset("sb","dev","acc")][string]$target_env,
    [Parameter(Mandatory)][Validateset("apply","destroy")][string]$action,
    [Parameter(Mandatory=$true)][string]$tf_state,
    [switch]$refresh_az #when you create a new subscription or renamed it, you need to relog into azure, otherwise you get error on non existing stuff. 
)

# terraform used az under the hood, make sure you have that installed.
if($refresh_az){
    az login
}

$t = az account list -o table | convertfrom-string # terraform uses az to login, cant use powershell command lets here to check if connected to the correct subscription.
if(($t.where({$_.P6 -eq $true}).P1 -match $target_env) -eq $false){
    az account set --subscription "homemrb-$target_env"
    if ($LASTEXITCODE -ne 0){
        Write-Error "Could not connect, check if the subscription exists"
        exit -1
    }
}

try {
    Set-Location $tf_state -ErrorAction Stop #change to the tf state folder
    terraform.exe init
}
catch {
    Write-Error "Could change to path: $tf_state, please provide a valid folder name where a main.tf is located."
    exit -1
}

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$tf_env_exist = (terraform workspace list) | ForEach-Object {
    if($_ -match $target_env){
        $true
    }
}

if(-not($tf_env_exist)){
    terraform workspace new $target_env
    terraform init
}

terraform workspace select $target_env

$var_file = "$scriptPath\$target_env.tfvars"

$r = terraform plan -var-file "$var_file" -json | 
     convertfrom-json | Where-Object type -eq change_summary

# i hate string parsing of the bottom of heart, dont understand why people still like this. but have no choice with TF
if($r.changes.change -eq 0 -and $r.changes.add -eq 0 -and $r.changes.remove -eq 0 -and $r.changes.import -eq 0 -and $action -ne 'destroy'){
    Write-Output "Skipping due to no changes"
}
else { # means we do a destroy
    write-output "Running $action!"
    terraform $action -var-file "$var_file" -auto-approve -compact-warnings
}

Set-Location $scriptPath