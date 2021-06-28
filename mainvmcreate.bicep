targetScope = 'subscription' // tenant', 'managementGroup', 'subscription', 'resourceGroup'

param vmazdevopsUsername string
param vmazdevopsPassword string
param resourceGroupName string = 'not-set'
param namePrefix string = 'not set'
param vstsAccount string
param personalAccessToken string

module vnet_generic './vnet.bicep' = {
  name: 'vnet'
  scope: resourceGroup(resourceGroupName)
  params: {
    namePrefix: '${namePrefix}-vnet'
  }
}


module vm_devopswinvm './createvmwindows.bicep' = {
  name: 'azdevopsvm'
  scope: resourceGroup(resourceGroupName)
  params: {
    namePrefix: '${namePrefix}-vm'
    subnetId: vnet_generic.outputs.subnetId
    username: vmazdevopsUsername
    password: vmazdevopsPassword
    vmName: 'azdevopsvm'
    vstsAccount: vstsAccount
    personalAccessToken: personalAccessToken
    deployAgent: false
  }
}
 
// module vm_jumpboxwinvm './createvmwindows.bicep' = {
//   name: 'jumpboxwinvm'
//   scope: resourceGroup(resourceGroupName)
//   params: {
//     namePrefix: '${namePrefix}-vm'
//     subnetId: vnet_generic.outputs.subnetId
//     username: vmazdevopsUsername
//     password: vmazdevopsPassword
//     vmName: 'jumpboxwinvm'
//   }
// }

output devopvmName string = vm_devopswinvm.name
// output jumpboxvmName string = vm_jumpboxwinvm.name
