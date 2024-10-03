# download the zip file
# extract it to a location where you want to run it
# append path to path variable for user
# check if az exist, if not needs to be downloaded and installed as well.
param (
    [Parameter(Mandatory=$false)][string] $tf_url = "https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_windows_amd64.zip",
    [Parameter(Mandatory=$false)][string] $tf_location = "D:\Terraform",
    [Parameter(Mandatory=$false)][string] $az_url = "https://aka.ms/installazurecliwindowsx64"
)

function add-topath {
    $oldvalue = [Environment]::GetEnvironmentVariable("path","User")
    $newvalue = $oldvalue + ";D:\Terraform"
    [Environment]::SetEnvironmentVariable("path",$newvalue,"User")
}

$ProgressPreference = 'SilentlyContinue' #needed to speed up invoke-webrequest, you could also use Net.Webclient with downloadfile method
$t_file = "$env:TEMP\tf_temp.zip"
Invoke-WebRequest $tf_url -OutFile $t_file
Expand-Archive -Path $t_file -DestinationPath $tf_location -Force

if (-not($env:PATH.split(';').contains($tf_location))){
    add-topath
}
else {
    Write-Output "Already in path variable, not need to add again"
}

if(get-command az -ErrorAction SilentlyContinue){
    Write-Output "az is already installed, no need to take any action"
}
else {
    # lets install az cli.
    Invoke-WebRequest $az_url -OutFile $env:TEMP\az.msi
    Start-Process -FilePath $env:TEMP\az.msi -ArgumentList "/qb!"
}

# close shell and relauch it, so you can use terraform.exe/az.cmd from any location in shell
