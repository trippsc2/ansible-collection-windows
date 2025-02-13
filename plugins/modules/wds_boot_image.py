#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r"""
module: wds_boot_image
version_added: 1.1.0
author:
  - Jim Tarpley (@trippsc2)
short_description: Configures a Windows Deployment Services boot image
description:
  - Configures a Windows Deployment Services boot image.
  - This module cannot be made idempotent, because the boot image does not have the same hash after being added to WDS.
attributes:
  check_mode:
    support: none
    description:
      - Does not support check mode.
options:
  image_name:
    type: str
    required: true
    description:
      - The name of the boot image to configure.
  path:
    type: path
    required: false
    description:
      - The path to the boot image file.
      - When O(state=present), this option is required.
      - When O(state=absent), this option is ignored.
  architecture:
    type: str
    required: false
    choices:
      - x86
      - x64
      - ia64
      - arm
    description:
      - The architecture of the boot image.
      - If not provided, the module will attempt to determine the architecture from the image name.
      - If provided and either the existing image architecture does not match or the boot image at the specified path does not match, the module will fail.
  description:
    type: str
    required: false
    description:
      - The description of the boot image.
      - When O(state=absent), this option is ignored.
      - If not provided, the module will use an empty string for the description.
  display_order:
    type: int
    required: false
    description:
      - The display order of the boot image.
      - When O(state=absent), this option is ignored.
      - If not provided, the module will use the default value of V(50000) for new boot images.
  state:
    type: str
    required: false
    default: present
    choices:
      - present
      - absent
    description:
      - The state of the boot image.
      - If V(present), the boot image will be created or updated.
      - If V(absent), the boot image will be removed.
"""

EXAMPLES = r"""
- name: Create boot image
  trippsc2.windows.wds_boot_image:
    image_name: Boot Image
    path: C:\boot.wim
    architecture: x64
    description: My boot image
    display_order: 50000
    state: present

- name: Remove boot image
  trippsc2.windows.wds_boot_image:
    image_name: Boot Image
    state: absent
"""

RETURN = r"""
previous:
  type: dict
  returned: changed
  description:
    - The previous configuration of the boot image.
  contains:
    image_name:
      type: str
      description:
        - The name of the boot image.
    description:
      type: str
      description:
        - The description of the boot image.
    architecture:
      type: str
      description:
        - The architecture of the boot image.
    display_order:
      type: int
      description:
        - The display order of the boot image.
current:
  type: dict
  returned: O(state=present)
  description:
    - The current configuration of the boot image.
  contains:
    image_name:
      type: str
      description:
        - The name of the boot image.
    description:
      type: str
      description:
        - The description of the boot image.
    architecture:
      type: str
      description:
        - The architecture of the boot image.
    display_order:
      type: int
      description:
        - The display order of the boot image.
"""
