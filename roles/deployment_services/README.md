<!-- BEGIN_ANSIBLE_DOCS -->

# Ansible Role: trippsc2.windows.deployment_services
Version: 1.1.0

This role installs and configures Windows Deployment Services role on Windows Server.

## Requirements

| Platform | Versions |
| -------- | -------- |
| Windows | <ul><li>2019</li><li>2022</li></ul> |

## Dependencies

| Collection |
| ---------- |
| ansible.windows |
| community.windows |

## Role Arguments
|Option|Description|Type|Required|Choices|Default|
|---|---|---|---|---|---|
| wds_path | <p>The path where Windows Deployment Services files will be stored.</p> | path | yes |  |  |
| wds_standalone | <p>Whether to configure the server as a standalone server.</p> | bool | no |  |  |
| wds_dhcp_authorized | <p>Whether to authorize the server as a DHCP Server in Active Directory.</p> | bool | no |  |  |


## License
MIT

## Author and Project Information
Jim Tarpley
<!-- END_ANSIBLE_DOCS -->
