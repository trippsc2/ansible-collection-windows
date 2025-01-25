<!-- BEGIN_ANSIBLE_DOCS -->

# Ansible Role: trippsc2.windows.deployment_services
Version: 1.1.0

This role installs and configures Windows Deployment Services role on Windows Server.

## Requirements

| Platform | Versions |
| -------- | -------- |
| Windows | <ul><li>2019</li><li>2022</li></ul> |

## Dependencies
| Role |
| ---- |
| trippsc2.windows.install_psgallery |

| Collection |
| ---------- |
| ansible.windows |
| community.windows |

## Role Arguments
|Option|Description|Type|Required|Choices|Default|
|---|---|---|---|---|---|
| wds_admin_user | <p>The user account used to configure Windows Deployment Services.</p><p>This account must have administrative privileges on the server.</p><p>If *wds_dhcp_authorized* is set to `true`, this account must also have Domain Admin privileges in Active Directory.</p> | str | yes |  |  |
| wds_admin_password | <p>The password for the *wds_admin_user* user account.</p> | str | yes |  |  |
| wds_path | <p>The path where Windows Deployment Services files will be stored.</p> | path | yes |  |  |
| wds_dhcp_authorized | <p>Whether to authorize the server as a DHCP Server in Active Directory.</p> | bool | no |  |  |


## License
MIT

## Author and Project Information
Jim Tarpley
<!-- END_ANSIBLE_DOCS -->
