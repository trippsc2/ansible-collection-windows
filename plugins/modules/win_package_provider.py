#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r"""
module: win_package_provider
version_added: 2.1.0
author:
  - Jim Tarpley (@trippsc2)
short_description: Ensures a package provider is available.
description:
  - Ensures a package provider is available of the specified name and, optionally, newer than the specified version.
attributes:
  check_mode:
    support: full
    description:
      - This module supports check mode.
options:
  name:
    description:
      - Name of the package provider to ensure is available.
    required: true
    type: str
  min_version:
    description:
      - Version of the package provider to ensure is available.
    required: false
    type: str
"""

EXAMPLES = r"""
- name: Ensure the NuGet package provider is available.
  trippsc2.windows.win_package_provider:
    name: NuGet
    min_version: 2.8.5.201
"""

RETURN = r"""
previous_version:
  description: The previous version of the package provider.
  returned: changed
  type: str
  sample: 1.2.3
installed_version:
  description: The current version of the package provider.
  returned: success
  type: str
  sample: 1.2.4
"""
