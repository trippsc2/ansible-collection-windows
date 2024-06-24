#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r"""
module: win_combine_certificates
version_added: 1.0.0
author:
  - Jim Tarpley
short_description: Combine multiple certificates into a single file.
description:
  - Combines multiple certificates into a single file in order.
attributes:
  check_mode:
    support: full
    details:
      - This module supports check mode.
options:
  certificates:
    description:
      - List of certificates to combine.
    required: true
    type: list(str)
  path:
    description:
      - Path to the combined certificate file.
    required: true
    type: str
"""

EXAMPLES = r"""
"""

RETURN = r"""
"""
