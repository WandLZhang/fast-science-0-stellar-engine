#!/bin/bash
# Update package list and install necessary packages
echo "apt-get update step 1" > /var/log/startup-script.log
sudo apt-get update
echo "apt-get install -y software-properties-common step 2" > /var/log/startup-script.log
sudo apt-get install -y software-properties-common

# Install Security Onion
echo "add-apt-repository -y ppa:securityonion/stable step 3" > /var/log/startup-script.log
sudo add-apt-repository -y ppa:securityonion/stable
echo "sudo apt-get update step 4" > /var/log/startup-script.log
sudo apt-get update
echo "apt-get install -y securityonion-all step 5" > /var/log/startup-script.log
sudo apt-get install -y securityonion-all

# Start Security Onion setup (note: this is interactive; adjust as needed)
sudo sosetup



# Update and install necessary packages
# echo "Hello, world step 1" > /var/log/startup-script.log
# apt-get update
# apt-get install -y curl wget

# # Download and install Security Onion
# wget https://github.com/Security-Onion-Solutions/securityonion/blob/master/securityonion-2.3.90.iso?raw=true -O /tmp/securityonion.iso
# mkdir -p /mnt/so-iso
# mount -o loop /tmp/securityonion.iso /mnt/so-iso

# # Install necessary dependencies
# apt-get install -y squashfs-tools
# unsquashfs -d /tmp/so-extracted /mnt/so-iso/casper/filesystem.squashfs

# # Run the Security Onion installer
# /tmp/so-extracted/usr/sbin/securityonion-setup -y

# # Add your custom Security Onion setup commands here
# # ...

# # Clean up
# umount /mnt/so-iso
# rm -rf /tmp/securityonion.iso /tmp/so-extracted

# echo "Security Onion installation complete!" > /var/log/startup-script.log
 
# # Add your custom startup commands here

