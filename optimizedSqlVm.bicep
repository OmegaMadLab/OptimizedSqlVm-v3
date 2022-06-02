@description('The Azure location where resources are created')
param location string = resourceGroup().location

@description('The name for the Virtual Machine')
param vmName string

@description('Choose Yes to create a new availability set, or No to use an existing one')
@allowed([
  'Yes'
  'No'
])
param createAvailabilitySet string = 'No'

@description('Name of the availability set. Leave empty if availability set is not needed')
param availabilitySetName string = ''

// @description('DNS name of the AD domain you want to join. Leave empty if you don\'t want to join a domain during provisioning')
// @minLength(0)
// @maxLength(15)
// param adDomain string = ''

@description('Admin username for the Virtual Machine. If a domain is specified in the appropriate parameter, this user will be used both for local admin and to join domain')
param adminUsername string

@description('Admin password for the Virtual Machine')
@secure()
param adminPassword string

@description('The vnet you want to connect to. Leave empty to create a new ad hoc virtual network')
@minLength(0)
@maxLength(100)
param vnetName string = ''

@description('If using an existing vnet, specify the name of resource group which contains it. Otherwise, leave it empty')
param vnetResourceGroup string = resourceGroup().name

@description('The subnet you want to connect to')
param subnetName string = 'default'

@description('The private IP address you want to assign to the NIC; leave DHCP to maintain a dynamic IP')
param privateIp string = 'dhcp'

@description('Would you like to enable accelerated networking? It works only on supported VMs')
@allowed([
  'Yes'
  'No'
])
param enableAcceleratedNetworking string = 'No'

@description('Link a public IP address to the NIC?')
@allowed([
  'Yes'
  'No'
])
param enablePublicIP string = 'No'

@description('If public IP address is enabled, choose a unique DNS Name to access the Virtual Machine.')
param dnsLabelPrefix string = ''

@description('The array of application security group ids you want to join. Leave empty to skip this step.')
@minLength(0)
@maxLength(100)
param asgIds array = []

@description('The SQL Server version you want to deploy')
@allowed([
  'SQL Server 2012 SP3 Enterprise on Windows Server 2012 R2'
  'SQL Server 2012 SP3 Enterprise (BYOL) on Windows Server 2012 R2'
  'SQL Server 2012 SP3 Standard on Windows Server 2012 R2'
  'SQL Server 2012 SP3 Standard (BYOL) on Windows Server 2012 R2'
  'SQL Server 2012 SP3 Web on Windows Server 2012 R2'
  'SQL Server 2012 SP3 Express on Windows Server 2012 R2'
  'SQL Server 2012 SP4 Enterprise on Windows Server 2012 R2'
  'SQL Server 2012 SP4 Enterprise (BYOL) on Windows Server 2012 R2'
  'SQL Server 2012 SP4 Standard on Windows Server 2012 R2'
  'SQL Server 2012 SP4 Standard (BYOL) on Windows Server 2012 R2'
  'SQL Server 2012 SP4 Web on Windows Server 2012 R2'
  'SQL Server 2012 SP4 Express on Windows Server 2012 R2'
  'SQL Server 2014 SP1 Enterprise (BYOL) on Windows Server 2012 R2'
  'SQL Server 2014 SP1 Standard (BYOL) on Windows Server 2012 R2'
  'SQL Server 2014 SP2 Enterprise on Windows Server 2012 R2'
  'SQL Server 2014 SP2 Enterprise (BYOL) on Windows Server 2012 R2'
  'SQL Server 2014 SP2 Standard on Windows Server 2012 R2'
  'SQL Server 2014 SP2 Standard (BYOL) on Windows Server 2012 R2'
  'SQL Server 2014 SP2 Web on Windows Server 2012 R2'
  'SQL Server 2014 SP2 Express on Windows Server 2012 R2'
  'SQL Server 2016 Enterprise (BYOL) on Windows Server 2012 R2'
  'SQL Server 2016 Standard (BYOL) on Windows Server 2012 R2'
  'SQL Server 2016 Developer (free) on Windows Server 2012 R2'
  'SQL Server 2016 SP1 Enterprise on Windows Server 2016'
  'SQL Server 2016 SP1 Enterprise (BYOL) on Windows Server 2016'
  'SQL Server 2016 SP1 Standard on Windows Server 2016'
  'SQL Server 2016 SP1 Standard (BYOL) on Windows Server 2016'
  'SQL Server 2016 SP1 Web on Windows Server 2016'
  'SQL Server 2016 SP1 Express (free) on Windows Server 2016'
  'SQL Server 2016 SP1 Developer (free) on Windows Server 2016'
  'SQL Server 2017 Enterprise on Windows Server 2016'
  'SQL Server 2017 Enterprise (BYOL) on Windows Server 2016'
  'SQL Server 2017 Standard on Windows Server 2016'
  'SQL Server 2017 Standard (BYOL) on Windows Server 2016'
  'SQL Server 2017 Web on Windows Server 2016'
  'SQL Server 2017 Express (free) on Windows Server 2016'
  'SQL Server 2017 Developer (free) on Windows Server 2016'
  'SQL Server 2017 Enterprise on Windows Server 2019'
  'SQL Server 2017 Enterprise (BYOL) on Windows Server 2019'
  'SQL Server 2017 Standard on Windows Server 2019'
  'SQL Server 2017 Standard (BYOL) on Windows Server 2019'
  'SQL Server 2017 Web on Windows Server 2019'
  'SQL Server 2017 Express (free) on Windows Server 2019'
  'SQL Server 2017 Developer (free) on Windows Server 2019'
  'SQL Server 2019 Enterprise on Windows Server 2019'
  'SQL Server 2019 Enterprise (BYOL) on Windows Server 2019'
  'SQL Server 2019 Standard on Windows Server 2019'
  'SQL Server 2019 Standard (BYOL) on Windows Server 2019'
  'SQL Server 2019 Web on Windows Server 2019'
  'SQL Server 2019 Express (free) on Windows Server 2019'
  'SQL Server 2019 Developer (free) on Windows Server 2019'
])
param sqlVersion string = 'SQL Server 2019 Developer (free) on Windows Server 2019'

@description('The size of the virtual machine')
@allowed([
  'Standard_DS2_v2'
  'Standard_DS3_v2'
  'Standard_DS4_v2'
  'Standard_DS5_v2'
  'Standard_DS11_v2'
  'Standard_DS12-2_v2'
  'Standard_DS12_v2'
  'Standard_DS13-2_v2'
  'Standard_DS13-4_v2'
  'Standard_DS13_v2'
  'Standard_DS14-4_v2'
  'Standard_DS14-8_v2'
  'Standard_DS14_v2'
  'Standard_D2_v3'
  'Standard_D4_v3'
  'Standard_D8_v3'
  'Standard_D16_v3'
  'Standard_D32_v3'
  'Standard_D48_v3'
  'Standard_D64_v3'
  'Standard_D2s_v3'
  'Standard_D4s_v3'
  'Standard_D8s_v3'
  'Standard_D16s_v3'
  'Standard_D32s_v3'
  'Standard_D48s_v3'
  'Standard_D64s_v3'
  'Standard_E2_v3'
  'Standard_E4_v3'
  'Standard_E8_v3'
  'Standard_E16_v3'
  'Standard_E20_v3'
  'Standard_E32_v3'
  'Standard_E2s_v3'
  'Standard_E4-2s_v3'
  'Standard_E4s_v3'
  'Standard_E8-2s_v3'
  'Standard_E8-4s_v3'
  'Standard_E8s_v3'
  'Standard_E16-4s_v3'
  'Standard_E16-8s_v3'
  'Standard_E16s_v3'
  'Standard_E20s_v3'
  'Standard_E32-8s_v3'
  'Standard_E32-16s_v3'
  'Standard_E32s_v3'
  'Standard_M8-2ms'
  'Standard_M8-4ms'
  'Standard_M8ms'
  'Standard_M16-4ms'
  'Standard_M16-8ms'
  'Standard_M16ms'
  'Standard_M32-8ms'
  'Standard_M32-16ms'
  'Standard_M32ls'
  'Standard_M32ms'
  'Standard_M32ts'
  'Standard_M64-16ms '
  'Standard_M64-32ms'
  'Standard_M64ls'
  'Standard_M64ms'
  'Standard_M64s'
  'Standard_M128-32ms'
  'Standard_M128-64ms'
  'Standard_M128ms'
  'Standard_M128s'
  'Standard_M64'
  'Standard_M64m'
  'Standard_M128'
  'Standard_M128m'
  'Standard_D15_v2'
  'Standard_DS15_v2'
  'Standard_E48_v3'
  'Standard_E64i_v3'
  'Standard_E64_v3'
  'Standard_E48s_v3'
  'Standard_E64-16s_v3'
  'Standard_E64-32s_v3'
  'Standard_E64is_v3'
  'Standard_E64s_v3'
  'Standard_M24ms_v2 '
  'Standard_M24s_v2'
  'Standard_M48ms_v2'
  'Standard_M48s_v2'
  'Standard_M96ms_v2'
  'Standard_M96s_v2'
  'Standard_M192ms_v2'
  'Standard_M192s_v2'
  'Standard_M208ms_v2'
  'Standard_M208s_v2'
  'Standard_M416s_v2'
  'Standard_M416ms_v2'
  'Standard_D2a_v4'
  'Standard_D4a_v4'
  'Standard_D8a_v4'
  'Standard_D16a_v4'
  'Standard_D32a_v4'
  'Standard_D48a_v4'
  'Standard_D64a_v4'
  'Standard_D96a_v4'
  'Standard_D2as_v4'
  'Standard_D4as_v4'
  'Standard_D8as_v4'
  'Standard_D16as_v4'
  'Standard_D32as_v4'
  'Standard_D48as_v4'
  'Standard_D64as_v4'
  'Standard_D96as_v4 '
  'Standard_E2a_v4'
  'Standard_E4a_v4'
  'Standard_E8a_v4'
  'Standard_E16a_v4'
  'Standard_E20a_v4'
  'Standard_E32a_v4'
  'Standard_E48a_v4'
  'Standard_E64a_v4'
  'Standard_E96a_v4'
  'Standard_E2as_v4'
  'Standard_E4as_v4'
  'Standard_E8as_v4'
  'Standard_E16as_v4'
  'Standard_E20as_v4'
  'Standard_E32as_v4'
  'Standard_E48as_v4'
  'Standard_E64as_v4'
  'Standard_E96as_v4'
  'Standard_E2d_v4'
  'Standard_E4d_v4'
  'Standard_E8d_v4'
  'Standard_E16d_v4'
  'Standard_E20d_v4'
  'Standard_E32d_v4'
  'Standard_E48d_v4'
  'Standard_E64d_v4'
  'Standard_E2ds_v4'
  'Standard_E4-2ds_v4'
  'Standard_E4ds_v4'
  'Standard_E8-2ds_v4'
  'Standard_E8-4ds_v4'
  'Standard_E8ds_v4'
  'Standard_E16-4ds_v4'
  'Standard_E16-8ds_v4'
  'Standard_E16ds_v4'
  'Standard_E20ds_v4'
  'Standard_E32-8ds_v4'
  'Standard_E32-16ds_v4'
  'Standard_E32ds_v4'
  'Standard_E48ds_v4'
  'Standard_E64-16ds_v4'
  'Standard_E64ds_v4'
  'Standard_D2d_v4'
  'Standard_D4d_v4'
  'Standard_D8d_v4'
  'Standard_D16d_v4'
  'Standard_D32d_v4'
  'Standard_D48d_v4'
  'Standard_D64d_v4'
  'Standard_D2ds_v4'
  'Standard_D4ds_v4'
  'Standard_D8ds_v4'
  'Standard_D16ds_v4'
  'Standard_D32ds_v4'
  'Standard_D48ds_v4'
  'Standard_D64ds_v4'
])
param vmSize string = 'Standard_DS2_v2'

@description('Would you like to active Azure Hybrid Benefits and use an existing Windows license on this VM?')
@allowed([
  'Yes'
  'No'
])
param useAHBforWindows string = 'No'

@description('Choose the time zone for the virtual machine')
@allowed([
  '(UTC-12:00) International Date Line West'
  '(UTC-11:00) Coordinated Universal Time-11'
  '(UTC-10:00) Aleutian Islands'
  '(UTC-10:00) Hawaii'
  '(UTC-09:30) Marquesas Islands'
  '(UTC-09:00) Alaska'
  '(UTC-09:00) Coordinated Universal Time-09'
  '(UTC-08:00) Baja California'
  '(UTC-08:00) Coordinated Universal Time-08'
  '(UTC-08:00) Pacific Time (US & Canada)'
  '(UTC-07:00) Arizona'
  '(UTC-07:00) Chihuahua, La Paz, Mazatlan'
  '(UTC-07:00) Mountain Time (US & Canada)'
  '(UTC-06:00) Central America'
  '(UTC-06:00) Central Time (US & Canada)'
  '(UTC-06:00) Easter Island'
  '(UTC-06:00) Guadalajara, Mexico City, Monterrey'
  '(UTC-06:00) Saskatchewan'
  '(UTC-05:00) Bogota, Lima, Quito, Rio Branco'
  '(UTC-05:00) Chetumal'
  '(UTC-05:00) Eastern Time (US & Canada)'
  '(UTC-05:00) Haiti'
  '(UTC-05:00) Havana'
  '(UTC-05:00) Indiana (East)'
  '(UTC-05:00) Turks and Caicos'
  '(UTC-04:00) Asuncion'
  '(UTC-04:00) Atlantic Time (Canada)'
  '(UTC-04:00) Caracas'
  '(UTC-04:00) Cuiaba'
  '(UTC-04:00) Georgetown, La Paz, Manaus, San Juan'
  '(UTC-04:00) Santiago'
  '(UTC-03:30) Newfoundland'
  '(UTC-03:00) Araguaina'
  '(UTC-03:00) Brasilia'
  '(UTC-03:00) Cayenne, Fortaleza'
  '(UTC-03:00) City of Buenos Aires'
  '(UTC-03:00) Greenland'
  '(UTC-03:00) Montevideo'
  '(UTC-03:00) Punta Arenas'
  '(UTC-03:00) Saint Pierre and Miquelon'
  '(UTC-03:00) Salvador'
  '(UTC-02:00) Coordinated Universal Time-02'
  '(UTC-02:00) Mid-Atlantic - Old'
  '(UTC-01:00) Azores'
  '(UTC-01:00) Cabo Verde Is.'
  '(UTC) Coordinated Universal Time'
  '(UTC+00:00) Casablanca'
  '(UTC+00:00) Dublin, Edinburgh, Lisbon, London'
  '(UTC+00:00) Monrovia, Reykjavik'
  '(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna'
  '(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague'
  '(UTC+01:00) Brussels, Copenhagen, Madrid, Paris'
  '(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb'
  '(UTC+01:00) West Central Africa'
  '(UTC+02:00) Amman'
  '(UTC+02:00) Athens, Bucharest'
  '(UTC+02:00) Beirut'
  '(UTC+02:00) Cairo'
  '(UTC+02:00) Chisinau'
  '(UTC+02:00) Damascus'
  '(UTC+02:00) Gaza, Hebron'
  '(UTC+02:00) Harare, Pretoria'
  '(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius'
  '(UTC+02:00) Jerusalem'
  '(UTC+02:00) Kaliningrad'
  '(UTC+02:00) Khartoum'
  '(UTC+02:00) Tripoli'
  '(UTC+02:00) Windhoek'
  '(UTC+03:00) Baghdad'
  '(UTC+03:00) Istanbul'
  '(UTC+03:00) Kuwait, Riyadh'
  '(UTC+03:00) Minsk'
  '(UTC+03:00) Moscow, St. Petersburg, Volgograd'
  '(UTC+03:00) Nairobi'
  '(UTC+03:30) Tehran'
  '(UTC+04:00) Abu Dhabi, Muscat'
  '(UTC+04:00) Astrakhan, Ulyanovsk'
  '(UTC+04:00) Baku'
  '(UTC+04:00) Izhevsk, Samara'
  '(UTC+04:00) Port Louis'
  '(UTC+04:00) Saratov'
  '(UTC+04:00) Tbilisi'
  '(UTC+04:00) Yerevan'
  '(UTC+04:30) Kabul'
  '(UTC+05:00) Ashgabat, Tashkent'
  '(UTC+05:00) Ekaterinburg'
  '(UTC+05:00) Islamabad, Karachi'
  '(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi'
  '(UTC+05:30) Sri Jayawardenepura'
  '(UTC+05:45) Kathmandu'
  '(UTC+06:00) Astana'
  '(UTC+06:00) Dhaka'
  '(UTC+06:00) Omsk'
  '(UTC+06:30) Yangon (Rangoon)'
  '(UTC+07:00) Bangkok, Hanoi, Jakarta'
  '(UTC+07:00) Barnaul, Gorno-Altaysk'
  '(UTC+07:00) Hovd'
  '(UTC+07:00) Krasnoyarsk'
  '(UTC+07:00) Novosibirsk'
  '(UTC+07:00) Tomsk'
  '(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi'
  '(UTC+08:00) Irkutsk'
  '(UTC+08:00) Kuala Lumpur, Singapore'
  '(UTC+08:00) Perth'
  '(UTC+08:00) Taipei'
  '(UTC+08:00) Ulaanbaatar'
  '(UTC+08:30) Pyongyang'
  '(UTC+08:45) Eucla'
  '(UTC+09:00) Chita'
  '(UTC+09:00) Osaka, Sapporo, Tokyo'
  '(UTC+09:00) Seoul'
  '(UTC+09:00) Yakutsk'
  '(UTC+09:30) Adelaide'
  '(UTC+09:30) Darwin'
  '(UTC+10:00) Brisbane'
  '(UTC+10:00) Canberra, Melbourne, Sydney'
  '(UTC+10:00) Guam, Port Moresby'
  '(UTC+10:00) Hobart'
  '(UTC+10:00) Vladivostok'
  '(UTC+10:30) Lord Howe Island'
  '(UTC+11:00) Bougainville Island'
  '(UTC+11:00) Chokurdakh'
  '(UTC+11:00) Magadan'
  '(UTC+11:00) Norfolk Island'
  '(UTC+11:00) Sakhalin'
  '(UTC+11:00) Solomon Is., New Caledonia'
  '(UTC+12:00) Anadyr, Petropavlovsk-Kamchatsky'
  '(UTC+12:00) Auckland, Wellington'
  '(UTC+12:00) Coordinated Universal Time+12'
  '(UTC+12:00) Fiji'
  '(UTC+12:00) Petropavlovsk-Kamchatsky - Old'
  '(UTC+12:45) Chatham Islands'
  '(UTC+13:00) Coordinated Universal Time+13'
  '(UTC+13:00) Nuku\'alofa'
  '(UTC+13:00) Samoa'
  '(UTC+14:00) Kiritimati Island'
])
param timeZone string = '(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna'

@description('Suffix that will be used to compose OS disk name')
param osDiskSuffix string = 'OsDisk'

@description('The type of storage to use for OS disk')
@allowed([
  'Standard_LRS'
  'StandardSSD_LRS'
  'Premium_LRS'
])
param osDiskStorageSku string = 'Premium_LRS'

@description('Suffix that will be used to compose the name for data disks')
param dataDiskSuffix string = 'DataDisk'

@description('The workload type which will be executed on this VM')
@allowed([
  'OLTP'
  'DW'
  'GENERAL'
])
param workloadType string = 'OLTP'

@description('The type of storage to use')
@allowed([
  'Standard_LRS'
  'StandardSSD_LRS'
  'Premium_LRS'
  'UltraSSD_LRS'
])
param dataDiskStorageSku string = 'Premium_LRS'

@description('The number of data disks to add to the virtual machine')
param numOfDataDisks int = 1

@description('The size of data disks to add to the virtual machine')
param dataDisksSize int = 1023

@description('The type of storage to use for Log Disks')
@allowed([
  'Standard_LRS'
  'StandardSSD_LRS'
  'Premium_LRS'
  'UltraSSD_LRS'
])
param logDiskStorageSku string = 'Premium_LRS'

@description('The number of log disks to add to the virtual machine')
param numOfLogDisks int = 1

@description('The size of log disks to add to the virtual machine')
param logDisksSize int = 1023

@description('The path for data files')
param dataFilePath string = 'F:\\SQLData'

@description('The path for log files')
param logFilePath string = 'G:\\SQLLog'

@description('The path for TempDB files')
param tempFilePath string = 'D:\\TempDB'

@description('The TCP Port for the SQL Server instance')
param sqlTcpPort int = 1433

@metadata({
  Description: 'To enable SQL Authentication, provide an admin username. Avoid sa, sysadmin, admin and similar accounts. If left empty, SQL Auth won\'t be enabled'
})
param sqlAuthAdmin string = ''

@metadata({
  Description: 'SQL Authentication syadmin password. Evaluated only if sqlAuthAdmin parameter is populated'
})
@secure()
param sqlAuthAdminPassword string = ''

// @metadata({
//   Description: 'SQL VM Resource Provider installation mode. If prepareForHA parameter is set to FCI, this parameter is ignored and SQL VM RP mode is automatically set to LightWeight'
// })
// @allowed([
//   'Full'
//   'LightWeight'
//   'NoAgent'
// ])
// param sqlRpInstallMode string = 'Full'

// @metadata({
//   Description: 'Set to Yes if this VM will be part of a SQL Failover Cluster Instance. This will remove default SQL instance and install Failover Cluster related Windows features.'
// })
// @allowed([
//   'No'
//   'AG'
//   'FCI'
// ])
// param prepareForHA string = 'No'

@description('The name of the storage account to use for diagnostic logs. If it doesn\'t exist, it will be created. Leave it empty to use an Azure-managed storage account.')
@minLength(0)
@maxLength(25)
param diagStorageAccountName string = ''

// @description('Location of resources that the script is dependent on such as linked templates and DSC modules')
// param artifactsLocation string = 'https://raw.githubusercontent.com/OmegaMadLab/OptimizedSqlVm-v3/master'

var storageAccountName = ((length(diagStorageAccountName) == 0) ? take(concat(uniqueString('diag', toLower(vmName), resourceGroup().id)), 25) : diagStorageAccountName)
var storageSku = 'Standard_LRS'
var nicName_var = '${vmName}-NIC'
var addressPrefix = '10.0.0.0/16'
var subnetName_var = ((length(subnetName) == 0) ? 'default' : subnetName)
var subnetPrefix = '10.0.0.0/24'
var publicIPAddressName = '${vmName}-PublicIP'
var publicIpAllocationMethod = 'Dynamic'
var vnetResourceGroupName = ((length(vnetResourceGroup) == 0) ? resourceGroup().name : vnetResourceGroup)
var virtualNetworkName = ((length(vnetName) == 0) ? '${vmName}-Vnet' : vnetName)
var vnetID = resourceId(vnetResourceGroupName, 'Microsoft.Network/virtualNetworks', virtualNetworkName)
var subnetRef = '${vnetID}/subnets/${toLower(subnetName_var)}'
var dataDiskCacheSetting = (((dataDiskStorageSku == 'Premium_LRS') || (dataDiskStorageSku == 'StandardSSD_LRS')) ? 'ReadOnly' : 'None')
var logDiskCacheSetting = 'None'
var numOfDisks = numOfDataDisks + numOfLogDisks
var sqlLicense = (contains(sqlVersion, 'BYOL') ? 'AHUB' : 'PAYG')
var NestedTemplateFolder = 'nestedtemplates'
var NetworkTemplateFileName = 'Network.json'
var StorageTemplateFileName = 'Storage.json'
var PublicIPTemplateFileName = 'PublicIP.json'
var AvSetTemplateFileName = 'AvSet.json'
var TimeZoneObj = {
  '(UTC-12:00) International Date Line West': {
    id: 'Dateline Standard Time'
  }
  '(UTC-11:00) Coordinated Universal Time-11': {
    id: 'UTC-11'
  }
  '(UTC-10:00) Aleutian Islands': {
    id: 'Aleutian Standard Time'
  }
  '(UTC-10:00) Hawaii': {
    id: 'Hawaiian Standard Time'
  }
  '(UTC-09:30) Marquesas Islands': {
    id: 'Marquesas Standard Time'
  }
  '(UTC-09:00) Alaska': {
    id: 'Alaskan Standard Time'
  }
  '(UTC-09:00) Coordinated Universal Time-09': {
    id: 'UTC-09'
  }
  '(UTC-08:00) Baja California': {
    id: 'Pacific Standard Time (Mexico)'
  }
  '(UTC-08:00) Coordinated Universal Time-08': {
    id: 'UTC-08'
  }
  '(UTC-08:00) Pacific Time (US & Canada)': {
    id: 'Pacific Standard Time'
  }
  '(UTC-07:00) Arizona': {
    id: 'US Mountain Standard Time'
  }
  '(UTC-07:00) Chihuahua, La Paz, Mazatlan': {
    id: 'Mountain Standard Time (Mexico)'
  }
  '(UTC-07:00) Mountain Time (US & Canada)': {
    id: 'Mountain Standard Time'
  }
  '(UTC-06:00) Central America': {
    id: 'Central America Standard Time'
  }
  '(UTC-06:00) Central Time (US & Canada)': {
    id: 'Central Standard Time'
  }
  '(UTC-06:00) Easter Island': {
    id: 'Easter Island Standard Time'
  }
  '(UTC-06:00) Guadalajara, Mexico City, Monterrey': {
    id: 'Central Standard Time (Mexico)'
  }
  '(UTC-06:00) Saskatchewan': {
    id: 'Canada Central Standard Time'
  }
  '(UTC-05:00) Bogota, Lima, Quito, Rio Branco': {
    id: 'SA Pacific Standard Time'
  }
  '(UTC-05:00) Chetumal': {
    id: 'Eastern Standard Time (Mexico)'
  }
  '(UTC-05:00) Eastern Time (US & Canada)': {
    id: 'Eastern Standard Time'
  }
  '(UTC-05:00) Haiti': {
    id: 'Haiti Standard Time'
  }
  '(UTC-05:00) Havana': {
    id: 'Cuba Standard Time'
  }
  '(UTC-05:00) Indiana (East)': {
    id: 'US Eastern Standard Time'
  }
  '(UTC-05:00) Turks and Caicos': {
    id: 'Turks And Caicos Standard Time'
  }
  '(UTC-04:00) Asuncion': {
    id: 'Paraguay Standard Time'
  }
  '(UTC-04:00) Atlantic Time (Canada)': {
    id: 'Atlantic Standard Time'
  }
  '(UTC-04:00) Caracas': {
    id: 'Venezuela Standard Time'
  }
  '(UTC-04:00) Cuiaba': {
    id: 'Central Brazilian Standard Time'
  }
  '(UTC-04:00) Georgetown, La Paz, Manaus, San Juan': {
    id: 'SA Western Standard Time'
  }
  '(UTC-04:00) Santiago': {
    id: 'Pacific SA Standard Time'
  }
  '(UTC-03:30) Newfoundland': {
    id: 'Newfoundland Standard Time'
  }
  '(UTC-03:00) Araguaina': {
    id: 'Tocantins Standard Time'
  }
  '(UTC-03:00) Brasilia': {
    id: 'E. South America Standard Time'
  }
  '(UTC-03:00) Cayenne, Fortaleza': {
    id: 'SA Eastern Standard Time'
  }
  '(UTC-03:00) City of Buenos Aires': {
    id: 'Argentina Standard Time'
  }
  '(UTC-03:00) Greenland': {
    id: 'Greenland Standard Time'
  }
  '(UTC-03:00) Montevideo': {
    id: 'Montevideo Standard Time'
  }
  '(UTC-03:00) Punta Arenas': {
    id: 'Magallanes Standard Time'
  }
  '(UTC-03:00) Saint Pierre and Miquelon': {
    id: 'Saint Pierre Standard Time'
  }
  '(UTC-03:00) Salvador': {
    id: 'Bahia Standard Time'
  }
  '(UTC-02:00) Coordinated Universal Time-02': {
    id: 'UTC-02'
  }
  '(UTC-02:00) Mid-Atlantic - Old': {
    id: 'Mid-Atlantic Standard Time'
  }
  '(UTC-01:00) Azores': {
    id: 'Azores Standard Time'
  }
  '(UTC-01:00) Cabo Verde Is.': {
    id: 'Cape Verde Standard Time'
  }
  '(UTC) Coordinated Universal Time': {
    id: 'UTC'
  }
  '(UTC+00:00) Casablanca': {
    id: 'Morocco Standard Time'
  }
  '(UTC+00:00) Dublin, Edinburgh, Lisbon, London': {
    id: 'GMT Standard Time'
  }
  '(UTC+00:00) Monrovia, Reykjavik': {
    id: 'Greenwich Standard Time'
  }
  '(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna': {
    id: 'W. Europe Standard Time'
  }
  '(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague': {
    id: 'Central Europe Standard Time'
  }
  '(UTC+01:00) Brussels, Copenhagen, Madrid, Paris': {
    id: 'Romance Standard Time'
  }
  '(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb': {
    id: 'Central European Standard Time'
  }
  '(UTC+01:00) West Central Africa': {
    id: 'W. Central Africa Standard Time'
  }
  '(UTC+02:00) Amman': {
    id: 'Jordan Standard Time'
  }
  '(UTC+02:00) Athens, Bucharest': {
    id: 'GTB Standard Time'
  }
  '(UTC+02:00) Beirut': {
    id: 'Middle East Standard Time'
  }
  '(UTC+02:00) Cairo': {
    id: 'Egypt Standard Time'
  }
  '(UTC+02:00) Chisinau': {
    id: 'E. Europe Standard Time'
  }
  '(UTC+02:00) Damascus': {
    id: 'Syria Standard Time'
  }
  '(UTC+02:00) Gaza, Hebron': {
    id: 'West Bank Standard Time'
  }
  '(UTC+02:00) Harare, Pretoria': {
    id: 'South Africa Standard Time'
  }
  '(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius': {
    id: 'FLE Standard Time'
  }
  '(UTC+02:00) Jerusalem': {
    id: 'Israel Standard Time'
  }
  '(UTC+02:00) Kaliningrad': {
    id: 'Kaliningrad Standard Time'
  }
  '(UTC+02:00) Khartoum': {
    id: 'Sudan Standard Time'
  }
  '(UTC+02:00) Tripoli': {
    id: 'Libya Standard Time'
  }
  '(UTC+02:00) Windhoek': {
    id: 'Namibia Standard Time'
  }
  '(UTC+03:00) Baghdad': {
    id: 'Arabic Standard Time'
  }
  '(UTC+03:00) Istanbul': {
    id: 'Turkey Standard Time'
  }
  '(UTC+03:00) Kuwait, Riyadh': {
    id: 'Arab Standard Time'
  }
  '(UTC+03:00) Minsk': {
    id: 'Belarus Standard Time'
  }
  '(UTC+03:00) Moscow, St. Petersburg, Volgograd': {
    id: 'Russian Standard Time'
  }
  '(UTC+03:00) Nairobi': {
    id: 'E. Africa Standard Time'
  }
  '(UTC+03:30) Tehran': {
    id: 'Iran Standard Time'
  }
  '(UTC+04:00) Abu Dhabi, Muscat': {
    id: 'Arabian Standard Time'
  }
  '(UTC+04:00) Astrakhan, Ulyanovsk': {
    id: 'Astrakhan Standard Time'
  }
  '(UTC+04:00) Baku': {
    id: 'Azerbaijan Standard Time'
  }
  '(UTC+04:00) Izhevsk, Samara': {
    id: 'Russia Time Zone 3'
  }
  '(UTC+04:00) Port Louis': {
    id: 'Mauritius Standard Time'
  }
  '(UTC+04:00) Saratov': {
    id: 'Saratov Standard Time'
  }
  '(UTC+04:00) Tbilisi': {
    id: 'Georgian Standard Time'
  }
  '(UTC+04:00) Yerevan': {
    id: 'Caucasus Standard Time'
  }
  '(UTC+04:30) Kabul': {
    id: 'Afghanistan Standard Time'
  }
  '(UTC+05:00) Ashgabat, Tashkent': {
    id: 'West Asia Standard Time'
  }
  '(UTC+05:00) Ekaterinburg': {
    id: 'Ekaterinburg Standard Time'
  }
  '(UTC+05:00) Islamabad, Karachi': {
    id: 'Pakistan Standard Time'
  }
  '(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi': {
    id: 'India Standard Time'
  }
  '(UTC+05:30) Sri Jayawardenepura': {
    id: 'Sri Lanka Standard Time'
  }
  '(UTC+05:45) Kathmandu': {
    id: 'Nepal Standard Time'
  }
  '(UTC+06:00) Astana': {
    id: 'Central Asia Standard Time'
  }
  '(UTC+06:00) Dhaka': {
    id: 'Bangladesh Standard Time'
  }
  '(UTC+06:00) Omsk': {
    id: 'Omsk Standard Time'
  }
  '(UTC+06:30) Yangon (Rangoon)': {
    id: 'Myanmar Standard Time'
  }
  '(UTC+07:00) Bangkok, Hanoi, Jakarta': {
    id: 'SE Asia Standard Time'
  }
  '(UTC+07:00) Barnaul, Gorno-Altaysk': {
    id: 'Altai Standard Time'
  }
  '(UTC+07:00) Hovd': {
    id: 'W. Mongolia Standard Time'
  }
  '(UTC+07:00) Krasnoyarsk': {
    id: 'North Asia Standard Time'
  }
  '(UTC+07:00) Novosibirsk': {
    id: 'N. Central Asia Standard Time'
  }
  '(UTC+07:00) Tomsk': {
    id: 'Tomsk Standard Time'
  }
  '(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi': {
    id: 'China Standard Time'
  }
  '(UTC+08:00) Irkutsk': {
    id: 'North Asia East Standard Time'
  }
  '(UTC+08:00) Kuala Lumpur, Singapore': {
    id: 'Singapore Standard Time'
  }
  '(UTC+08:00) Perth': {
    id: 'W. Australia Standard Time'
  }
  '(UTC+08:00) Taipei': {
    id: 'Taipei Standard Time'
  }
  '(UTC+08:00) Ulaanbaatar': {
    id: 'Ulaanbaatar Standard Time'
  }
  '(UTC+08:30) Pyongyang': {
    id: 'North Korea Standard Time'
  }
  '(UTC+08:45) Eucla': {
    id: 'Aus Central W. Standard Time'
  }
  '(UTC+09:00) Chita': {
    id: 'Transbaikal Standard Time'
  }
  '(UTC+09:00) Osaka, Sapporo, Tokyo': {
    id: 'Tokyo Standard Time'
  }
  '(UTC+09:00) Seoul': {
    id: 'Korea Standard Time'
  }
  '(UTC+09:00) Yakutsk': {
    id: 'Yakutsk Standard Time'
  }
  '(UTC+09:30) Adelaide': {
    id: 'Cen. Australia Standard Time'
  }
  '(UTC+09:30) Darwin': {
    id: 'AUS Central Standard Time'
  }
  '(UTC+10:00) Brisbane': {
    id: 'E. Australia Standard Time'
  }
  '(UTC+10:00) Canberra, Melbourne, Sydney': {
    id: 'AUS Eastern Standard Time'
  }
  '(UTC+10:00) Guam, Port Moresby': {
    id: 'West Pacific Standard Time'
  }
  '(UTC+10:00) Hobart': {
    id: 'Tasmania Standard Time'
  }
  '(UTC+10:00) Vladivostok': {
    id: 'Vladivostok Standard Time'
  }
  '(UTC+10:30) Lord Howe Island': {
    id: 'Lord Howe Standard Time'
  }
  '(UTC+11:00) Bougainville Island': {
    id: 'Bougainville Standard Time'
  }
  '(UTC+11:00) Chokurdakh': {
    id: 'Russia Time Zone 10'
  }
  '(UTC+11:00) Magadan': {
    id: 'Magadan Standard Time'
  }
  '(UTC+11:00) Norfolk Island': {
    id: 'Norfolk Standard Time'
  }
  '(UTC+11:00) Sakhalin': {
    id: 'Sakhalin Standard Time'
  }
  '(UTC+11:00) Solomon Is., New Caledonia': {
    id: 'Central Pacific Standard Time'
  }
  '(UTC+12:00) Anadyr, Petropavlovsk-Kamchatsky': {
    id: 'Russia Time Zone 11'
  }
  '(UTC+12:00) Auckland, Wellington': {
    id: 'New Zealand Standard Time'
  }
  '(UTC+12:00) Coordinated Universal Time+12': {
    id: 'UTC+12'
  }
  '(UTC+12:00) Fiji': {
    id: 'Fiji Standard Time'
  }
  '(UTC+12:00) Petropavlovsk-Kamchatsky - Old': {
    id: 'Kamchatka Standard Time'
  }
  '(UTC+12:45) Chatham Islands': {
    id: 'Chatham Islands Standard Time'
  }
  '(UTC+13:00) Coordinated Universal Time+13': {
    id: 'UTC+13'
  }
  '(UTC+13:00) Nuku\'alofa': {
    id: 'Tonga Standard Time'
  }
  '(UTC+13:00) Samoa': {
    id: 'Samoa Standard Time'
  }
  '(UTC+14:00) Kiritimati Island': {
    id: 'Line Islands Standard Time'
  }
}
var sqlVersionObj = {
  'SQL Server 2012 SP3 Enterprise on Windows Server 2012 R2': {
    offer: 'SQL2012SP3-WS2012R2'
    sku: 'Enterprise'
  }
  'SQL Server 2012 SP3 Enterprise (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2012SP3-WS2012R2-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2012 SP3 Standard on Windows Server 2012 R2': {
    offer: 'SQL2012SP3-WS2012R2'
    sku: 'Standard'
  }
  'SQL Server 2012 SP3 Standard (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2012SP3-WS2012R2-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2012 SP3 Web on Windows Server 2012 R2': {
    offer: 'SQL2012SP3-WS2012R2'
    sku: 'Web'
  }
  'SQL Server 2012 SP3 Express on Windows Server 2012 R2': {
    offer: 'SQL2012SP3-WS2012R2'
    sku: 'Express'
  }
  'SQL Server 2012 SP4 Enterprise on Windows Server 2012 R2': {
    offer: 'SQL2012SP4-WS2012R2'
    sku: 'Enterprise'
  }
  'SQL Server 2012 SP4 Enterprise (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2012SP4-WS2012R2-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2012 SP4 Standard on Windows Server 2012 R2': {
    offer: 'SQL2012SP4-WS2012R2'
    sku: 'Standard'
  }
  'SQL Server 2012 SP4 Standard (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2012SP4-WS2012R2-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2012 SP4 Web on Windows Server 2012 R2': {
    offer: 'SQL2012SP4-WS2012R2'
    sku: 'Web'
  }
  'SQL Server 2012 SP4 Express on Windows Server 2012 R2': {
    offer: 'SQL2012SP4-WS2012R2'
    sku: 'Express'
  }
  'SQL Server 2014 SP1 Enterprise (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2014SP1-WS2012R2-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2014 SP1 Standard (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2014SP1-WS2012R2-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2014 SP2 Enterprise on Windows Server 2012 R2': {
    offer: 'SQL2014SP2-WS2012R2'
    sku: 'Enterprise'
  }
  'SQL Server 2014 SP2 Enterprise (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2014SP2-WS2012R2-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2014 SP2 Standard on Windows Server 2012 R2': {
    offer: 'SQL2014SP2-WS2012R2'
    sku: 'Standard'
  }
  'SQL Server 2014 SP2 Standard (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2014SP2-WS2012R2-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2014 SP2 Web on Windows Server 2012 R2': {
    offer: 'SQL2014SP2-WS2012R2'
    sku: 'Web'
  }
  'SQL Server 2014 SP2 Express on Windows Server 2012 R2': {
    offer: 'SQL2014SP2-WS2012R2'
    sku: 'Express'
  }
  'SQL Server 2016 Enterprise (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2016-WS2012R2-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2016 Standard (BYOL) on Windows Server 2012 R2': {
    offer: 'SQL2016-WS2012R2-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2016 Developer (free) on Windows Server 2012 R2': {
    offer: 'SQL2016-WS2012R2'
    sku: 'SQLDEV'
  }
  'SQL Server 2016 SP1 Enterprise on Windows Server 2016': {
    offer: 'SQL2016SP1-WS2016'
    sku: 'Enterprise'
  }
  'SQL Server 2016 SP1 Enterprise (BYOL) on Windows Server 2016': {
    offer: 'SQL2016SP1-WS2016-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2016 SP1 Standard on Windows Server 2016': {
    offer: 'SQL2016SP1-WS2016'
    sku: 'Standard'
  }
  'SQL Server 2016 SP1 Standard (BYOL) on Windows Server 2016': {
    offer: 'SQL2016SP1-WS2016-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2016 SP1 Web on Windows Server 2016': {
    offer: 'SQL2016SP1-WS2016'
    sku: 'Web'
  }
  'SQL Server 2016 SP1 Express (free) on Windows Server 2016': {
    offer: 'SQL2016SP1-WS2016'
    sku: 'Express'
  }
  'SQL Server 2016 SP1 Developer (free) on Windows Server 2016': {
    offer: 'SQL2016SP1-WS2016'
    sku: 'SQLDEV'
  }
  'SQL Server 2017 Enterprise on Windows Server 2016': {
    offer: 'SQL2017-WS2016'
    sku: 'Enterprise'
  }
  'SQL Server 2017 Enterprise (BYOL) on Windows Server 2016': {
    offer: 'SQL2017-WS2016-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2017 Standard on Windows Server 2016': {
    offer: 'SQL2017-WS2016'
    sku: 'Standard'
  }
  'SQL Server 2017 Standard (BYOL) on Windows Server 2016': {
    offer: 'SQL2017-WS2016-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2017 Web on Windows Server 2016': {
    offer: 'SQL2017-WS2016'
    sku: 'Web'
  }
  'SQL Server 2017 Express (free) on Windows Server 2016': {
    offer: 'SQL2017-WS2016'
    sku: 'Express'
  }
  'SQL Server 2017 Developer (free) on Windows Server 2016': {
    offer: 'SQL2017-WS2016'
    sku: 'SQLDEV'
  }
  'SQL Server 2017 Enterprise on Windows Server 2019': {
    offer: 'SQL2017-WS2019'
    sku: 'Enterprise'
  }
  'SQL Server 2017 Enterprise (BYOL) on Windows Server 2019': {
    offer: 'SQL2017-WS2019-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2017 Standard on Windows Server 2019': {
    offer: 'SQL2017-WS2019'
    sku: 'Standard'
  }
  'SQL Server 2017 Standard (BYOL) on Windows Server 2019': {
    offer: 'SQL2017-WS2019-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2017 Web on Windows Server 2019': {
    offer: 'SQL2017-WS2019'
    sku: 'Web'
  }
  'SQL Server 2017 Express (free) on Windows Server 2019': {
    offer: 'SQL2017-WS2019'
    sku: 'Express'
  }
  'SQL Server 2017 Developer (free) on Windows Server 2019': {
    offer: 'SQL2017-WS2019'
    sku: 'SQLDEV'
  }
  'SQL Server 2019 Enterprise on Windows Server 2019': {
    offer: 'SQL2019-WS2019'
    sku: 'Enterprise'
  }
  'SQL Server 2019 Enterprise (BYOL) on Windows Server 2019': {
    offer: 'SQL2019-WS2019-BYOL'
    sku: 'Enterprise'
  }
  'SQL Server 2019 Standard on Windows Server 2019': {
    offer: 'SQL2019-WS2019'
    sku: 'Standard'
  }
  'SQL Server 2019 Standard (BYOL) on Windows Server 2019': {
    offer: 'SQL2019-WS2019-BYOL'
    sku: 'Standard'
  }
  'SQL Server 2019 Web on Windows Server 2019': {
    offer: 'SQL2019-WS2019'
    sku: 'Web'
  }
  'SQL Server 2019 Express (free) on Windows Server 2019': {
    offer: 'SQL2019-WS2019'
    sku: 'Express'
  }
  'SQL Server 2019 Developer (free) on Windows Server 2019': {
    offer: 'SQL2019-WS2019'
    sku: 'SQLDEV'
  }
}
var sqlAuthUid = sqlAuthAdmin
var sqlAuthPwd = ((sqlAuthAdmin == '') ? '' : sqlAuthAdminPassword)
// var sqlConfigModulesURL = '${artifactsLocation}/DSC/SqlDscConfig.zip'
// var SqlDscConfigScript = 'SqlDscConfig.ps1'
// var SqlDscConfigFunction = 'SqlDscConfig'
//var sqlRpInstallMode_var = ((toLower(prepareForHA) == 'FCI') ? 'LightWeight' : sqlRpInstallMode)

var dataDisks = [for i in range(0, numOfDisks): {
  name: '${vmName}-${dataDiskSuffix}${string((i + 1))}'
  diskSizeGB: i < numOfDataDisks ? dataDisksSize : logDisksSize)
  lun: int(i)
  caching: i < numOfDataDisks ? dataDiskCacheSetting : logDiskCacheSetting
  createOption: 'Empty'
  managedDisk: {
    storageAccountType: i < numOfDataDisks ? dataDiskStorageSku : logDiskStorageSku
  }
}]
var asgIds_var = [for item in asgIds: {
  id: item
}]

module Network 'nestedtemplates/Network.bicep' = if (length(vnetName) == 0) {
  name: 'Network'
  params: {
    location: location
    vnetName: virtualNetworkName
    addressPrefix: addressPrefix
    subnetName: subnetName_var
    subnetPrefix: subnetPrefix
  }
  dependsOn: []
}

module Storage 'nestedtemplates/Storage.bicep' = if (length(diagStorageAccountName) == 0) {
  name: 'Storage'
  params: {
    location: location
    storageAccountName: storageAccountName
    storageSku: storageSku
  }
  dependsOn: []
}

module AvSet 'nestedtemplates/AvSet.bicep' = if ((length(availabilitySetName) > 0) && (toLower(createAvailabilitySet) == 'yes')) {
  name: 'AvSet'
  params: {
    location: location
    avSetName: availabilitySetName
    ppgId: ''
  }
  dependsOn: []
}

module PublicIP 'nestedtemplates/PublicIP.bicep' = if (enablePublicIP == 'Yes') {
  name: 'PublicIP'
  params: {
    location: location
    name: publicIPAddressName
    ipAllocationMethod: publicIpAllocationMethod
    domainNameLabel: dnsLabelPrefix
  }
  dependsOn: []
}

resource nicName 'Microsoft.Network/networkInterfaces@2019-09-01' = {
  name: nicName_var
  location: location
  tags: {
    displayName: 'Nic'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: ((toLower(privateIp) == 'dhcp') ? 'Dynamic' : 'Static')
          privateIPAddress: ((toLower(privateIp) == 'dhcp') ? json('null') : privateIp)
          publicIPAddress: ((toLower(enablePublicIP) == 'no') ? json('null') : json('{"id": "/subscriptions/${subscription().subscriptionId}/resourceGroups/${toLower(resourceGroup().name)}/providers/Microsoft.Network/publicIPAddresses/${toLower(publicIPAddressName)}"}'))
          subnet: {
            id: subnetRef
          }
          applicationSecurityGroups: asgIds_var
        }
      }
    ]
    enableAcceleratedNetworking: ((toLower(enableAcceleratedNetworking) == 'yes') ? bool('true') : bool('false'))
  }
  dependsOn: [
    Network
    PublicIP
  ]
}

resource vmName_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vmName
  location: location
  tags: {
    displayName: 'VM'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    licenseType: ((toLower(useAHBforWindows) == 'yes') ? 'Windows_Server' : 'None')
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        timeZone: TimeZoneObj[timeZone].id
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftSqlServer'
        offer: sqlVersionObj[sqlVersion].offer
        sku: sqlVersionObj[sqlVersion].sku
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        createOption: 'FromImage'
        name: '${vmName}-${osDiskSuffix}'
        managedDisk: {
          storageAccountType: osDiskStorageSku
        }
      }
      dataDisks: dataDisks
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicName.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${storageAccountName}.blob.core.windows.net/'
      }
    }
    availabilitySet: ((length(availabilitySetName) == 0) ? json('null') : json('{"id": "/subscriptions/${subscription().subscriptionId}/resourceGroups/${toLower(resourceGroup().name)}/providers/Microsoft.Compute/availabilitySets/${toLower(availabilitySetName)}"}'))
  }
  dependsOn: [
    Storage
    AvSet
  ]
}

resource Microsoft_SqlVirtualMachine_SqlVirtualMachines_vmName 'Microsoft.SqlVirtualMachine/sqlVirtualMachines@2021-11-01-preview' = {
  name: vmName
  location: location
  tags: {
    displayName: 'SQLVMRP'
  }
  properties: {
    virtualMachineResourceId: vmName_resource.id
    sqlManagement: 'Full'
    sqlServerLicenseType: sqlLicense
    storageConfigurationSettings: {
      diskConfigurationType: 'NEW'
      sqlDataSettings: {
        defaultFilePath: dataFilePath
        luns: array(range(0, numOfDataDisks))
      }
      sqlLogSettings: {
        defaultFilePath: logFilePath
        luns: array(range(numOfDataDisks, numOfLogDisks))
      }
      sqlSystemDbOnDataDisk: true
      sqlTempDbSettings: {
        defaultFilePath: tempFilePath
      }
      storageWorkloadType: workloadType
    }
    serverConfigurationsManagementSettings: {
      sqlInstanceSettings: {
        isOptimizeForAdHocWorkloadsEnabled: true
        maxDop: 8
      }
      sqlConnectivityUpdateSettings: {
        connectivityType: 'PRIVATE'
        port: sqlTcpPort
        sqlAuthUpdateUserName: sqlAuthAdmin
        sqlAuthUpdatePassword: sqlAuthPwd
      }
    }
}

// resource vmName_OmegaMadLabSqlDscExtension 'Microsoft.Compute/virtualMachines/extensions@2019-07-01' = {
//   parent: vmName_resource
//   name: 'OmegaMadLabSqlDscExtension'
//   location: location
//   tags: {
//     displayName: 'SqlDscConfig'
//   }
//   properties: {
//     publisher: 'Microsoft.Powershell'
//     type: 'DSC'
//     typeHandlerVersion: '2.76'
//     autoUpgradeMinorVersion: false
//     settings: {
//       configuration: {
//         url: sqlConfigModulesURL
//         script: SqlDscConfigScript
//         function: SqlDscConfigFunction
//       }
//       configurationArguments: {
//         prepareForHA: prepareForHA
//       }
//     }
//     protectedSettings: {
//       configurationArguments: {
//         AdminCreds: {
//           userName: adminUsername
//           Password: adminPassword
//         }
//         domainName: adDomain
//       }
//     }
//   }
//   dependsOn: [
//     Microsoft_SqlVirtualMachine_SqlVirtualMachines_vmName
//   ]
// }
