#!/usr/bin/env -S PYTHONPATH=/home/mlag/phones/android_tools_extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/tecno/kl5n',
]

module = ExtractUtilsModule(
    'kl5n',
    'tecno',
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
