param(
    [Parameter(Mandatory)][Validateset("dev","acc")][string]$target_env,
    [Parameter(Mandatory)][Validateset("apply","destroy")][string]$action,
    [Parameter(Mandatory=$true)][string]$tf_state
)


try {
    Set-Location $tf_state -ErrorAction Stop #change to the tf state folder
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

$r = terraform plan -var-file "$target_env.tfvars"

if($r[2] -match("No Changes.") -and $action -eq "apply"){
    Write-Output $r
}
else {
    #Write-Output $r
    write-output "Running $action!"
    terraform $action -var-file "$target_env.tfvars" -auto-approve
}

Set-Location $scriptPath