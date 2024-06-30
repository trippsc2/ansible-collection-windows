<!-- BEGIN_ANSIBLE_DOCS -->

# Ansible Role: trippsc2.windows.deployment_services
Version: 1.0.2

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
| wds_path | <p>The path to initialize WDS.</p> | path | yes |  |  |
| wds_dhcp_authorized | <p>Whether to authorize WDS in Active Directory.</p> | bool | no |  | false |
| wds_wait_for_file | <p>Whether to wait for file replication to complete to configure the boot image file.</p> | bool | no |  | false |
| wds_wait_for_file_timeout | <p>The timeout in seconds to wait for file replication to complete.</p> | int | no |  | 300 |
| domain_admin_user | <p>The domain admin username.</p> | str | yes |  |  |
| domain_admin_password | <p>The domain admin password.</p> | str | yes |  |  |
| wds_boot_images | <p>List of boot images to configure.</p> | list of dicts of 'wds_boot_images' options | no |  |  |

### Options for wds_boot_images
|Option|Description|Type|Required|Choices|Default|
|---|---|---|---|---|---|
| name | <p>The name of the boot image.</p> | str | yes |  |  |
| path | <p>The path to the boot image.</p> | path | yes |  |  |
| multicast | <p>Whether to enable multicast for the boot image.</p> | bool | no |  | false |


## License
MIT

## Author and Project Information
Jim Tarpley
<!-- END_ANSIBLE_DOCS -->
