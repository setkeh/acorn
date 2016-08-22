# This file is a part of the IncludeOS unikernel - www.includeos.org
#
# Copyright 2015-2016 Oslo and Akershus University College of Applied Sciences
# and Alfred Bratterud
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

# Specify the name of disk image for serving content
FAT_DISK=memdisk.fat

# Check if the specified disk image exists
# If it doesn't then try to create it
if [ ! -f $FAT_DISK ];
then
  echo -e ">>> Creating FAT disk $FAT_DISK"
  dd if=/dev/zero of=$FAT_DISK bs=1M seek=5 count=0
  mkfs.fat $FAT_DISK
fi

# Create a directory for mounting the disk image
mkdir -p mnt

# Try to mount the disk image
echo -e ">>> Mounting $FAT_DISK in mnt/"
sudo mount -o rw $FAT_DISK mnt/

# Copy web content into the disk image
echo -e ">>> Copy content from disk1/ to $FAT_DISK"
sudo cp -r disk1/. mnt/
sync