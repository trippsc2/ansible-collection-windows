<!-- BEGIN_ANSIBLE_DOCS -->

# Ansible Role: trippsc2.windows.dhcp_server
Version: 1.0.7

This role installs and configures DHCP Server role on Windows Server.

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

## Role Arguments
|Option|Description|Type|Required|Choices|Default|
|---|---|---|---|---|---|
| dhcp_install_management_tools | <p>Whether to install the DHCP Server management tools.</p> | bool | no |  | False |
| dhcp_server_options | <p>List of DHCP server options.</p> | list of dicts of 'dhcp_server_options' options | no |  | [] |
| dhcp_scopes | <p>List of DHCP scopes to configure.</p> | list of dicts of 'dhcp_scopes' options | no |  | [] |

### Options for dhcp_server_options
|Option|Description|Type|Required|Choices|Default|
|---|---|---|---|---|---|
| id | <p>The option ID of the DHCP server option.</p> | int | yes |  |  |
| value | <p>The value of the DHCP server option.</p><p>If *ensure* is set to `Present`, this is required.</p> | raw | no |  |  |
| vendor_class | <p>The vendor class of the DHCP server option.</p> | str | no |  |  |
| user_class | <p>The user class of the DHCP server option.</p> | str | no |  |  |
| ensure | <p>The state of the DHCP server option.</p> | str | no | <ul><li>Present</li><li>Absent</li></ul> | Present |

### Options for dhcp_scopes
|Option|Description|Type|Required|Choices|Default|
|---|---|---|---|---|---|
| ensure | <p>The state of the DHCP scope.</p> | str | no | <ul><li>Present</li><li>Absent</li></ul> | Present |
| id | <p>The network ID address of the DHCP scope.</p> | str | yes |  |  |
| ip_start | <p>The start IP address of the DHCP scope.</p> | str | yes |  |  |
| ip_end | <p>The end IP address of the DHCP scope.</p> | str | yes |  |  |
| name | <p>The name of the DHCP scope.</p> | str | yes |  |  |
| subnet_mask | <p>The subnet mask of the DHCP scope.</p> | str | yes |  |  |
| lease_duration | <p>The lease duration of the DHCP scope.</p> | str | yes |  |  |
| state | <p>The state of the DHCP scope.</p> | str | no | <ul><li>Active</li><li>Inactive</li></ul> | Active |
| options | <p>List of DHCP scope options to configure.</p> | list of dicts of 'options' options | no |  | [] |

### Options for dhcp_scopes > options
|Option|Description|Type|Required|Choices|Default|
|---|---|---|---|---|---|
| id | <p>The ID of the DHCP scope option.</p> | int | yes |  |  |
| value | <p>The value of the DHCP scope option.</p> | raw | yes |  |  |
| vendor_class | <p>The vendor class of the DHCP scope option.</p> | str | no |  |  |
| user_class | <p>The user class of the DHCP scope option.</p> | str | no |  |  |
| ensure | <p>The state of the DHCP scope option.</p> | str | no | <ul><li>Present</li><li>Absent</li></ul> | Present |


## License
MIT

## Author and Project Information
Jim Tarpley
<!-- END_ANSIBLE_DOCS -->
