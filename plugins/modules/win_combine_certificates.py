#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r"""
module: win_combine_certificates
version_added: 1.0.0
author:
  - Jim Tarpley (@trippsc2)
short_description: Combine multiple certificates into a single file.
description:
  - Combines multiple certificates into a single file in order.
attributes:
  check_mode:
    support: full
    description:
      - This module supports check mode.
options:
  certificates:
    type: list
    required: true
    elements: path
    description:
      - List of certificates to combine.
  path:
    type: path
    required: true
    description:
      - Path to the combined certificate file.
"""

EXAMPLES = r"""
- name: Combine certificates
  trippsc2.windows.win_combine_certificates:
    certificates:
      - C:\temp\certificate1.crt
      - C:\temp\certificate2.crt
    path: C:\temp\combined.crt
"""

RETURN = r"""
"""
