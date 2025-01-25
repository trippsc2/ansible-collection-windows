#! /bin/bash

set -e

MOLECULE_BOX="w2022_cis" molecule test -s wds_boot_image
MOLECULE_BOX="w2022_cis" molecule test -s wds_initialize
MOLECULE_BOX="w2022_cis" molecule test -s win_combine_certificates
MOLECULE_BOX="w2022_cis" molecule test -s win_package_provider

MOLECULE_BOX="w2019_cis" molecule test -s wds_boot_image
MOLECULE_BOX="w2019_cis" molecule test -s wds_initialize
MOLECULE_BOX="w2019_cis" molecule test -s win_combine_certificates
MOLECULE_BOX="w2019_cis" molecule test -s win_package_provider

MOLECULE_BOX="w2025_base" molecule test -s wds_boot_image
MOLECULE_BOX="w2025_base" molecule test -s wds_initialize
MOLECULE_BOX="w2025_base" molecule test -s win_combine_certificates
MOLECULE_BOX="w2025_base" molecule test -s win_package_provider
