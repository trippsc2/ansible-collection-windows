# Ansible Collection: trippsc2.windows

This collection contains general purpose Windows modules and roles.

## Content

### Module plugins

- wds_boot_image - Configures a Windows Deployment Services boot image
- wds_initialize - Configures Windows Deployment Services initial settings
- win_combine_certificates - Combine multiple certificates into a single file.
- win_package_provider - Ensures a package provider is available.

### Roles

- [deployment_services](roles/deployment_services/README.md) - This role installs and configures Windows Deployment Services role on Windows Server.
- [dhcp_server](roles/dhcp_server/README.md) - This role installs and configures DHCP Server role on Windows Server.
- [install_psgallery](roles/install_psgallery/README.md) - This role installs the PSGallery repository for PowerShell modules on Windows machines.
