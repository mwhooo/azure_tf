# using 1 file for building a solution on per environment base.
# Global stuff
managed_by = "Mark Bakker"

#region vnet
vnet_name = "dev-vnet"
address_space = "10.0.0.0/16"
#endregion

#region subnets
windows_subnet = "windows_subnet"
linux_subnet = "linux_subnet"

subnet_bits = 8 # 8 bits on top of addrespace (/16) and last number is the actual subnet 10.0.5.0/24 in this example and 10.0.4.0 for second one, etc.
windows_bits = 5 # 10.0.5.0/24
linux_bits = 4 # 10.0.4.0/24
#endregion


#region tags
tags = {
    env  = "dev",
    owner = "mark",
    costcenter = "123456",
    department = "IT"
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



