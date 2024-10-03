# using 1 tfvars file for building a solution on per environment base.

#region vnet and subnets
vnet_name = "dev-vnet"
address_space = "10.0.0.0/16"

#region tags
tags = {
    env  = "dev",
    owner = "mark",
    costcenter = "123456",
    department = "IT",
    country = "NL"
}
#endregion

#region rg
rg_name = "demoapp001-dev"
rg_location = "westeurope"
#endregion

#region storage
storage_name = "devmrbst2411"
public_access_enabled = true
access_tier = "Cool"
#endregion

#region kv
kv_name = "devmrbkv2411"
kv_sku = "standard"
kv_subnet_name = "general_subnet"
#endregion




# windows_subnet_name = "windows_subnet"
# linux_subnet_name = "linux_subnet"
# general_subnet_name = "general_subnet"
# storage_subnet_name = "general_subnet" # using general subnet for everything non vm related

# subnet_bits = 8 # 8 bits on top of addrespace (/16) so /24
# windows_bits = 5 # 10.0.5.0/24
# linux_bits = 4 # 10.0.4.0/24
# general_bits = 10 # 10.0.10.0/24
#endregion