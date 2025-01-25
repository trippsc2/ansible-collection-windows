#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r"""
module: win_combine_certificates
version_added: 1.1.0
author:
  - Jim Tarpley
short_description: Configures Windows Deployment Services initial settings
description:
  - Initializes/uninitializes a Windows Deployment Services server.
attributes:
  check_mode:
    support: full
    details:
      - This module supports check mode.
options:
  remote_install_path:
    type: path
    required: false
    description:
      - The path to the WDS remote install directory.
      - When O(state=uninitialized), this option is ignored.
      - When O(state=initialized), this option is required.
  standalone:
    type: bool
    required: false
    default: false
    description:
      - Whether the boot image is standalone, as opposed to being integrated with Active Directory.
      - When O(state=uninitialized), this option is ignored.
  authorized:
    type: bool
    required: false
    default: false
    description:
      - Whether the server is authorized as a DHCP server in Active Directory.
      - When O(state=uninitialized), this option is ignored.
      - This will fail if the server is standalone.
  state:
    type: str
    required: false
    default: present
    choices:
      - initialized
      - uninitialized
    description:
      - The state of the WDS server.
"""

EXAMPLES = r"""
- name: Initialize WDS server
  trippsc2.windows.wds_initialize:
    remote_install_path: C:\\RemoteInstall
    state: initialized

- name: Initialize standalone WDS server
  trippsc2.windows.wds_initialize:
    remote_install_path: C:\\RemoteInstall
    standalone: true
    state: initialized

- name: Uninitialize WDS server
  trippsc2.windows.wds_initialize:
    state: uninitialized
"""

RETURN = r"""
reboot_required:
  type: bool
  returned:
    - always
  sample: false
  description:
    - Whether a reboot is required to apply the changes.
"""
