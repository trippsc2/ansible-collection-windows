# Ansible Collection: trippsc2.windows

This collection contains general purpose Windows modules and roles.

## Content

### Module plugins

- win_combine_certificates - Combine multiple certificates into a single file.
- win_package_provider - Ensures a package provider is available.

### Roles

- [deployment_services](roles/deployment_services/README.md) - This role installs and configures Windows Deployment Services role on Windows Server.
- [dhcp_server](roles/dhcp_server/README.md) - This role installs and configures DHCP Server role on Windows Server.
- [install_psgallery](roles/install_psgallery/README.md) - This role installs the PSGallery repository for PowerShell modules on Windows machines.
