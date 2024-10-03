vnet_name = "acc-vnet"
address_space = "10.100.0.0/16"

#region tags
tags = {
    env  = "acc",
    owner = "mark",
    costcenter = "789012",
    department = "IT",
    country = "NL"
}
#endregion


rg_name = "demoapp001-acc"
rg_location = "westeurope"

#region storage
storage_name = "accmrbst2411"
public_access_enabled = true
access_tier = "Hot"
#endregion

#region kv
kv_name = "accmrbkv2411"
kv_sku = "standard"
kv_subnet_name = "general_subnet"
#endregion