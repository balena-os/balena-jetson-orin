Change log
-----------

# v5.3.23+rev1
## (2024-07-22)

* Update .gitmodules with submodule branch information [Kyle Harding]

# v5.3.23
## (2024-07-17)

* Update meta-balena to v5.3.23 [Alexandru Costache]
* edk2-container: Remove patches now included in upstrea, fix custom dtb loading [Alexandru Costache]

# v5.3.22
## (2024-07-08)

* layers/meta-balena: Update to v5.3.22 [Alexandru Costache]
* README: Add L4T 36.3 upgrade notes [Alexandru Costache]
* jetson-dtbs: Update default device-tree names in Jetpack 6, drop AGX Orin SPI dtb [Alexandru Costache]
* balena-image-initramfs: Install out-of-tree drivers to allow NVME to be discovered [Alexandru Costache]
* layers/meta-tegra: Switch to l4t_36_3_kirkstone in our meta-tegra mirror [Alexandru Costache]

# v5.3.21+rev3
## (2024-06-20)

* recipes-kernel/linux-tegra: Add Ilitek ILI210X based touchscreen kernel module [Alexandru]

# v5.3.21+rev2
## (2024-06-18)

* recipes-kernel/linux-tegra: remove duplicate binder configs [Alexandru Costache]

# v5.3.21+rev1
## (2024-06-16)

* Update balena-os/github-workflows to v0.0.27 [Self-hosted Renovate Bot]

# v5.3.21
## (2024-06-14)

* layers/meta-balena: Update to v5.3.21 [Alexandru Costache]
* hostapp-update-hooks: Apply capsule update on AGX Orin even if alternate slot is unbootable [Alexandru Costache]

# v5.3.12
## (2024-06-09)

* layers/meta-balena: update to v5.3.12 [Alexandru Costache]
* uefi/edk2-firmware-tegra: Update Seeed J3010 to L4T 35.5.0 [Alexandru Costache]
* jetson-orin-nano-seeed-j3010: Add new device type [Alex Suykov]

# v5.3.10+rev1
## (2024-06-06)

* hostapp-update-hooks: Allow reprovisioning the QSPI if alternate slot becomes unbootable [Alexandru Costache]
* edk2-firmware-tegra: Refactor all integration patches when switching to L4T 35.5.0 [Alexandru Costache]

# v5.3.10
## (2024-05-28)

* layers/meta-balena: Update to v5.3.10 [Alexandru Costache]

# v5.2.4+rev3
## (2024-05-21)

* hostapp-update-hooks: AGX Orin - write UEFI variables from current hostOS [Alexandru Costache]

# v5.2.4+rev2
## (2024-05-16)


<details>
<summary> Update balena-yocto-scripts to 466d6ec592656bb950a393fc1c7a5d5ff4cf3455 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.21.10
> ### (2024-05-02)
> 
> * balena-deploy: deploy usbboot if available [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.21.9
> ### (Invalid date)
> 
> * balena-lib: improve base tag detection [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.21.8
> ### (2024-04-29)
> 
> * Support commit tags when extracting version tag from git [Kyle Harding]
> 
> ## balena-yocto-scripts-1.21.7
> ### (2024-04-19)
> 
> * Add missing $select for release_asset.asset_key [Thodoris Greasidis]
> 
> ## balena-yocto-scripts-1.21.6
> ### (2024-03-25)
> 
> * Revert "balena-build: avoid using device-type as a prefix in yocto sstate" [Kyle Harding]
> 
> ## balena-yocto-scripts-1.21.5
> ### (2024-03-14)
> 
> * Merge AMI publishing dependencies into yocto-build-env [Kyle Harding]
> 

</details>

# v5.2.4+rev1
## (2024-04-14)

* tegra-binaries: Update Orin Nano Devkit NVME boot blob and UEFI capsule [Alexandru Costache]

# v5.2.4
## (2024-04-05)


<details>
<summary> Update layers/meta-balena to 756d76ca12b7cbf2086bf6bad5f36b1117423d5f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.2.4
> ### (2024-04-03)
> 
> 
> <details>
> <summary> Update balena-supervisor to v16.1.10 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-16.1.10
>> #### (2024-03-28)
>> 
>> * Add revpi-connect-4 to RPi variants We need the supervisor to be able to manage config.txt changes for the RevPi Connect 4. [Shreya Patel]
>> 
>> ### balena-supervisor-16.1.9
>> #### (2024-03-25)
>> 
>> * Log the full error on device state report failure as it is more useful [Pagan Gazzard]
>> 
>> ### balena-supervisor-16.1.8
>> #### (2024-03-25)
>> 
>> * Set @balena/es-version to es2022 to match tsconfig.json [Pagan Gazzard]
>> 
>> ### balena-supervisor-16.1.7
>> #### (2024-03-25)
>> 
>> * Increase the timeout for auto select family to 5000ms to avoid issues [Pagan Gazzard]
>> 
>> ### balena-supervisor-16.1.6
>> #### (2024-03-18)
>> 
>> * Pin iptables to 1.8.9 (legacy) [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v5.2.3
## (2024-03-28)


<details>
<summary> Update layers/meta-balena to 90d838ae943ffa72108522bfcc4370105a3be40c [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.2.3
> ### (2024-03-22)
> 
> * mv docs/{,uefi-}secure-boot.md [Joseph Kogut]
> * docs: secure-boot: update for PCR7 sealing [Joseph Kogut]
> * os-helpers: compute_pcr7: merge event log digests [Joseph Kogut]
> * Update policy's PCR7 value in hostapp-update hook [Joseph Kogut]
> * os-helpers-tpm2: compute_pcr7: allow overriding efivars [Joseph Kogut]
> * Move policy update to HUP commit hook [Joseph Kogut]
> * rollback-health: move apply-dbx to HUP commit hook [Joseph Kogut]
> * hostapp-hooks: include 0-signed-update only for efi [Joseph Kogut]
> * secure boot: seal luks passphrase w/ PCR7 [Joseph Kogut]
> * os-helpers-tpm2: separate authentication from crypto [Joseph Kogut]
> * tcgtool: new recipe [Joseph Kogut]
> * recipes-bsp: add recipe for GRUB 2.12 [Joseph Kogut]
> * tests: skip bootloader config integrity check [Joseph Kogut]
> * secureboot: enroll kernel hash in db for EFISTUB [Joseph Kogut]
> 
> ## meta-balena-5.2.2
> ### (2024-03-20)
> 
> * Update contributing-device-support with balena-info documentation [Alexandru]
> 
> ## meta-balena-5.2.1
> ### (2024-03-18)
> 
> * networkmanager: Wait for iptables lock in shared dispatcher script [Michal Toman]
> 
> ## meta-balena-5.2.0
> ### (2024-03-16)
> 
> * Update NetworkManager to version 1.46.0 [Florin Sarbu]
> 
> ## meta-balena-5.1.54
> ### (2024-03-13)
> 
> * mkfs-hostapp-native: Disable iptables features in yocto balena daemon [Kyle Harding]
> 
> ## meta-balena-5.1.53
> ### (2024-03-12)
> 
> 
> <details>
> <summary> Update balena-supervisor to v16.1.5 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-16.1.5
>> #### (2024-03-12)
>> 
>> * Update fatrw to v0.2.21 [Felipe Lalanne]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.52
> ### (2024-03-11)
> 
> * images: balena-image-initramfs: remove uneeded kernel image [Alex Gonzalez]
> * classes: kernel-balena-noimage: add extra space [Alex Gonzalez]
> 
> ## meta-balena-5.1.51
> ### (2024-03-08)
> 
> 
> <details>
> <summary> Update balena-supervisor to v16.1.4 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-16.1.4
>> #### (2024-03-08)
>> 
>> * Update balena-register-device and its deps [Felipe Lalanne]
>> 
>> ### balena-supervisor-16.1.3
>> #### (2024-03-07)
>> 
>> * Remove dependency on @balena/happy-eyeballs [Felipe Lalanne]
>> * Update Node to v20 [Felipe Lalanne]
>> 
>> ### balena-supervisor-16.1.2
>> #### (2024-03-06)
>> 
>> * Update typescript to v5 [Felipe Lalanne]
>> 
>> ### balena-supervisor-16.1.1
>> #### (2024-03-04)
>> 
>> * Update @balena/lint to v7 [Felipe Lalanne]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.50
> ### (2024-03-07)
> 
> * tests/device-tree: Rework to account for new form of setting dtoverlay in config.txt by the supervisor [Florin Sarbu]
> 
> ## meta-balena-5.1.49
> ### (2024-03-06)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to a677d89 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.64
>> #### (2024-03-04)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.48
> ### (2024-03-06)
> 
> * hostapp-update-hooks: Soft include balena-config-defaults [Michal Toman]
> 
> ## meta-balena-5.1.47
> ### (2024-03-03)
> 
> * classes: kernel-balena: fix secureboot append [Alex Gonzalez]
> * classes: kernel-balena: correct dmcrypt dependencies [Alex Gonzalez]
> * classes: kernel-balena: separate kexec configuration [Alex Gonzalez]
> * kernel-balena: remove EFI specific settings [Alex Gonzalez]
> * kernel-balena: separate EFI specific secure boot configurations [Alex Gonzalez]
> * kernel-balena: remove deprecated kernel configuration [Alex Gonzalez]
> * kernel-balena: add nfsd kernel setting [Alex Gonzalez]
> 
> ## meta-balena-5.1.46
> ### (2024-03-02)
> 
> * resin_update_state_probe: ignore RAID members when looking for root [Michal Toman]
> 

</details>

# v5.1.45+rev3
## (2024-03-14)


<details>
<summary> Update balena-yocto-scripts to 97ebe58289e398c96dbc6f789e0119010b85da7f [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.21.4
> ### (2024-03-13)
> 
> * balena-build: avoid using device-type as a prefix in yocto sstate [Kyle Harding]
> 

</details>

# v5.1.45+rev2
## (2024-03-06)

* pass input parameters to common esr workflow [Alex Gonzalez]

# v5.1.45+rev1
## (2024-03-01)

* Update layers/meta-openembedded to fda737ec0cc1d2a5217548a560074a8e4d5ec580 [Self-hosted Renovate Bot]

# v5.1.45
## (2024-03-01)


<details>
<summary> Update layers/meta-balena to 7f676ac7bcb5e0b066aa8f20de1b5c7d20e5843f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.45
> ### (2024-02-29)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 2b34fec [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.63
>> #### (2024-02-27)
>> 
>> * Update core/contracts digest to f3ba2ee [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.44
> ### (2024-02-29)
> 
> * resin-init-flasher: Allow building images for non-flasher devices that have internal storage [Alexandru]
> 
> ## meta-balena-5.1.43
> ### (2024-02-28)
> 
> * Start os-config service after extracting CA [jaomaloy]
> 
> ## meta-balena-5.1.42
> ### (2024-02-28)
> 
> 
> <details>
> <summary> Update balena-supervisor to v16 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-16.1.0
>> #### (2024-02-27)
>> 
>> * Add support for repeated overlays [Felipe Lalanne]
>> 
>> ### balena-supervisor-16.0.4
>> #### (2024-02-27)
>> 
>> * Fix support for rsync deltas [Felipe Lalanne]
>> 
>> ### balena-supervisor-16.0.3
>> #### (2024-02-21)
>> 
>> * Patch default dtparam handling in config.txt [Christina Ying Wang]
>> 
>> ### balena-supervisor-16.0.2
>> #### (2024-02-17)
>> 
>> * Patch config.txt backend to return array configs correctly [Christina Ying Wang]
>> 
>> ### balena-supervisor-16.0.1
>> #### (2024-02-12)
>> 
>> * Update balena-io/deploy-to-balena-action to v2.0.27 [Self-hosted Renovate Bot]
>> 
>> ### balena-supervisor-16.0.0
>> #### (2024-02-08)
>> 
>> * Add special case for base DTO params on RPI config [Felipe Lalanne]
>> * Fix processing of dtoverlay/dtparams on config.txt [Felipe Lalanne]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.41
> ### (2024-02-27)
> 
> * tests: hup: use secondary antenna for revpi4 [rcooke-warwick]
> * tests: cloud : use secondary antenna for revpi4 [rcooke-warwick]
> * tests: os: use secondary antenna for revpi4 [rcooke-warwick]
> 
> ## meta-balena-5.1.40
> ### (2024-02-26)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to d71ce8f [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.62
>> #### (2024-02-26)
>> 
>> * ad extra autokit setup information, and basic troubleshooting [rcooke-warwick]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.39+rev1
## (2024-02-26)


<details>
<summary> Update contracts to f3ba2eee92e77c5a595bf22ffbeaa9164683ff1b [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.95
> ### (2024-02-26)
> 
> * sw.os+hw.device-type: Update Jetson Orin repositories [Alexandru Costache]
> * jetson-orin-nx-seeed-j4012: Add ubuntu and debian distro tpl files [Alexandru Costache]
> 

</details>

# v5.1.39
## (2024-02-26)


<details>
<summary> Update layers/meta-balena to 47803bace87fd17c2b0bfe89bb06c0744ddcd5e3 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.39
> ### (2024-02-26)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to ef8cbac [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.61
>> #### (2024-02-26)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.60
>> #### (2024-02-26)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.38
## (2024-02-26)


<details>
<summary> Update layers/meta-balena to 50a4fedb26b91e66e5c6fc15246822936c9eab09 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.38
> ### (2024-02-23)
> 
> * balena-rollback: adapt to secure boot support [Alex Gonzalez]
> * hostapp-update-hooks: Adapt resin-uboot hook to secure boot [Alex Gonzalez]
> * classes: u-boot: use global secure boot kernel command line instead of hardcoding [Alex Gonzalez]
> * grub: use global secure boot kernel command line instead of hardcoding [Alex Gonzalez]
> * conf: distro: define kernel command line for secure boot [Alex Gonzalez]
> * resindataexpander: encrypted partitions will auto-expand on unlock [Alex Gonzalez]
> * initrdscripts: migrate: replace hardcoded kernel image names [Alex Gonzalez]
> * resin-mounts: generalize secure boot mounts [Alex Gonzalez]
> * initrdscripts: abroot: Use the global label for non-encrypted boot partitions [Alex Gonzalez]
> * initrdscripts: allow for cryptsetup to support different secure boot implementations [Alex Gonzalez]
> * os-helpers-fs: add shared wait4udev function [Alex Gonzalez]
> * balena-image-flasher: fix appended variable with a leading space [Alex Gonzalez]
> * balena-config-vars: customize for secure boot support [Alex Gonzalez]
> * os-helpers: add dummy os-helpers-sb [Alex Gonzalez]
> * resin-init-flasher: allow flasher image use in devices without internal storage [Alex Gonzalez]
> * resin-init-flasher: flag non-encrypted boot partition as bootable [Alex Gonzalez]
> * resin-init-flasher: replace hardcoded kernel image names [Alex Gonzalez]
> * resin-init-flasher: split secureboot and disk encryption interfaces [Alex Gonzalez]
> * distro: balena-os: define the boot labels as global [Alex Gonzalez]
> * distro: balena-os: Specify full GO version [Alex Gonzalez]
> 

</details>

# v5.1.37+rev1
## (2024-02-25)

* jetson-dtbs: Fix build and install for pre-compiled spi dtb [Alexandru Costache]
* Add SPI support for 40-pin header [Christopher Field]

# v5.1.37
## (2024-02-22)


<details>
<summary> Update layers/meta-balena to bf4ec98227e4cce4c22ff3d7037bdcd78ffdd9ec [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.37
> ### (2024-02-22)
> 
> * tests/device-tree: Minor spelling fixes [Alexandru]
> * test/device-tree: Send vcdbg to DUT [Alexandru Costache]
> * patch: Add vcdbg binary to tests [Vipul Gupta (@vipulgupta2048)]
> 

</details>

# v5.1.36
## (2024-02-21)


<details>
<summary> Update layers/meta-balena to 03023b22b4e6de475e868b60fc8999c94d9255dc [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.36
> ### (2024-02-21)
> 
> * tests: hup: test breadcrumbs after rollback services [Joseph Kogut]
> 
> ## meta-balena-5.1.35
> ### (2024-02-19)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 95a9d72 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.59
>> #### (2024-02-19)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.58
>> #### (2024-02-14)
>> 
>> * Update core/contracts digest to 0c54ce2 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.34
## (2024-02-15)


<details>
<summary> Update layers/meta-balena to b72d2791eb6b8e7a8fbb7b25cc43649a6c5cc281 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.34
> ### (2024-02-14)
> 
> * resin-init-flasher: add jq dependency [Alex Gonzalez]
> 

</details>

# v5.1.33+rev1
## (2024-02-14)


<details>
<summary> Update contracts to 0c54ce2d25baac5485f3828dbfed58c33f881256 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.94
> ### (2024-02-14)
> 
> * odyssey-x86: Update icon to latest revision [Alexandru Costache]
> 

</details>

# v5.1.33
## (2024-02-14)


<details>
<summary> Update layers/meta-balena to 905446e98206f871145d1c70107c01d567e1303d [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.33
> ### (2024-02-14)
> 
> * tests: cloud: if no existing release, create generic fleet [rcooke-warwick]
> 

</details>

# v5.1.32
## (2024-02-13)


<details>
<summary> Update layers/meta-balena to 9cacd8fbca660d61433e0b01a2beb0e515ea5a51 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.32
> ### (2024-02-13)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 4b9de7e [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.57
>> #### (2024-02-13)
>> 
>> * patch: Authenticate the validator before validation [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.31
## (2024-02-13)


<details>
<summary> Update layers/meta-balena to 71c5240fd2c9d26e7773c1ed4b3dc67f7fa4f9c7 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.31
> ### (2024-02-13)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 00ee51c [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.56
>> #### (2024-02-12)
>> 
>> * Update balena-os/leviathan-worker to v2.9.36 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.55
>> #### (2024-02-12)
>> 
>> * Update balena-os/leviathan-worker to v2.9.35 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.30
## (2024-02-12)


<details>
<summary> Update layers/meta-balena to c9e64a42b8de857356e587b551fc25e83df441a1 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.30
> ### (2024-02-12)
> 
> * balena-image-bootloader-initramfs.bb: Add fsck module [Florin Sarbu]
> 
> ## meta-balena-5.1.29
> ### (2024-02-12)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to f6a3391 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.54
>> #### (2024-02-12)
>> 
>> * Update core/contracts digest to 4f7dba1 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.53
>> #### (2024-02-12)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.52
>> #### (2024-02-08)
>> 
>> * Update balena-os/leviathan-worker to v2.9.34 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.51
>> #### (2024-02-06)
>> 
>> * Update balena-os/leviathan-worker to v2.9.33 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.50
>> #### (2024-02-06)
>> 
>> * patch: Add config.js validator [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.28+rev1
## (2024-02-11)


<details>
<summary> Update balena-yocto-scripts to 0cb57aede8dea798c14ddfc6546525b920504970 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.21.3
> ### (2024-02-11)
> 
> * Enable S3 Server Side Encryption flags [Kyle Harding]
> 

</details>

# v5.1.28
## (2024-02-11)


<details>
<summary> Update layers/meta-balena to 4b70a3a329ce5e6749b32e49f87ef0093ee2d2c6 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.28
> ### (2024-02-11)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.43 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.43
>> #### (2024-02-06)
>> 
>> * Update runc component to v1.1.12 from balena-runc repo [Ken Bannister]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.27
## (2024-02-09)


<details>
<summary> Update layers/meta-balena to cb86da70496b25de7b826abbacd7c7feedf2fa54 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.27
> ### (2024-02-09)
> 
> * patch: upgrade recipes/devtools/go to 1.17.13 [JOASSART Edwin]
> * patch: removes recipes/devtools/go to 1.16 [JOASSART Edwin]
> 

</details>

# v5.1.26+rev4
## (2024-02-08)

* Update layers/meta-openembedded to 8609de00952d65bb813a48c535c937324efeb18a [Self-hosted Renovate Bot]

# v5.1.26+rev3
## (2024-02-08)


<details>
<summary> Update contracts to 4f7dba1c6408a17c5a07e353443b068410fd8aa2 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.93
> ### (2024-02-08)
> 
> * hw.device-type: Add Kontron i.MX8M Mini device [joris-bright]
> 

</details>

# v5.1.26+rev2
## (2024-02-08)


<details>
<summary> Update balena-yocto-scripts to 6ccd3b1013b6d25ea9990a07a06bee864fe0a172 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.21.2
> ### (2024-02-08)
> 
> * automation/include: Pass helper image version [Florin Sarbu]
> 

</details>

# v5.1.26+rev1
## (2024-02-07)


<details>
<summary> Update balena-yocto-scripts to 57b2f7c97e4d95e74b76a0827e910d46e3b3ce2f [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.21.1
> ### (2024-02-07)
> 
> * balena-deploy: Remove docker.io when pulling image [Alexandru]
> 

</details>

# v5.1.26
## (2024-02-06)


<details>
<summary> Update layers/meta-balena to cde215eca198fddfd900cf481ed5cc3f26d901ab [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.26
> ### (2024-02-06)
> 
> 
> <details>
> <summary> Update balena-supervisor to v15.3.1 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-15.3.1
>> #### (2024-02-01)
>> 
>> * Respect update strategies app-wide instead of at the service level [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.25
## (2024-02-06)


<details>
<summary> Update layers/meta-balena to 77dc93411fffa0cc71dcc36e447cbfa9170f909d [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.25
> ### (2024-02-06)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to a708a7f [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.49
>> #### (2024-02-05)
>> 
>> * Update actions/upload-artifact digest to 5d5d22a [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.24
## (2024-02-06)


<details>
<summary> Update layers/meta-balena to e3519f1960bc68e72abf3ec052564cbf5878629f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.24
> ### (2024-02-05)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 57ba19b [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.48
>> #### (2024-02-05)
>> 
>> * Update balena-os/leviathan-worker to v2.9.32 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.47
>> #### (2024-02-05)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.23+rev1
## (2024-02-05)

* Update layers/meta-openembedded to ce9c0d76171ce9d07e4bcb702b750416b265562a [Self-hosted Renovate Bot]

# v5.1.23
## (2024-02-05)


<details>
<summary> Update layers/meta-balena to aa6c72f952fa9f9a7428e0bf445b98a5023f8a60 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.23
> ### (2024-02-05)
> 
> * tests: cloud: disable dut internet after flashing [rcooke-warwick]
> 

</details>

# v5.1.22+rev1
## (2024-02-03)


<details>
<summary> Update balena-yocto-scripts to 0ba4bf5f5c4597b21628dfb6206304d1f889468f [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.21.0
> ### (2024-02-02)
> 
> * Return image id after pulling helper images [Kyle Harding]
> * Build and publish helper images with Flowzone [Kyle Harding]
> 
> ## balena-yocto-scripts-1.20.0
> ### (2024-02-02)
> 
> * Remove unused block-build functions [Kyle Harding]
> 

</details>

# v5.1.22
## (2024-02-02)


<details>
<summary> Update layers/meta-balena to 2ba79c7ce73fde702831a041729da21bdff65627 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.22
> ### (2024-02-02)
> 
> * balena-rollback/rollback-health: Allow old OS hooks to access efivars [Alexandru Costache]
> 

</details>

# v5.1.21
## (2024-02-02)


<details>
<summary> Update layers/meta-balena to 282df4bf06581eb6224ecd0eadfc53c0ec078907 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.21
> ### (2024-02-01)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to dd2285a [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.46
>> #### (2024-02-01)
>> 
>> * Update core/contracts digest to 75a9764 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.45
>> #### (2024-02-01)
>> 
>> * Update core/contracts digest to 8dfe06b [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.44
>> #### (Invalid date)
>> 
>> * Update balena-os/leviathan-worker to v2.9.30 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.43
>> #### (2024-01-29)
>> 
>> * Update balena-os/leviathan-worker to v2.9.29 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.20+rev1
## (2024-02-01)


<details>
<summary> Update contracts to 75a97647a44cfe534f93926ab039afca6570cb86 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.92
> ### (2024-02-01)
> 
> * hw.device-type: Add phyboard-lyra-am62xx-2 device [Atanas Bunchev]
> 

</details>

# v5.1.20
## (2024-02-01)


<details>
<summary> Update layers/meta-balena to cb6fcbc870bbb5c3a39a36647fb3c91747718a93 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.20
> ### (2024-02-01)
> 
> 
> <details>
> <summary> Update balena-supervisor to v15.3.0 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-15.3.0
>> #### (2024-01-26)
>> 
>> * Pin docker version to v24 for tests [Felipe Lalanne]
>> * Fix docker utils tests for docker v25 [Felipe Lalanne]
>> * Enable nodemon when using test:env [Felipe Lalanne]
>> * Improve test:compose and test:env commands [Felipe Lalanne]
>> * Add prettierrc for editor compatibility [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.19
## (2024-02-01)


<details>
<summary> Update layers/meta-balena to 03a97aa37d6dd74ad0c18e944d7dc6022b5851b1 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.19
> ### (2024-02-01)
> 
> * Add balena bootloader class [Michal Toman]
> * initrdscripts: remove nr_cpus kernel arg before kexec [Michal Toman]
> 

</details>

# v5.1.18+rev2
## (2024-01-31)


<details>
<summary> Update contracts to 8dfe06b57576e15e8579d4083bb316c9c7671488 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.91
> ### (2024-02-01)
> 
> * Remove generic-amd64-fde device type [Michal Toman]
> 

</details>

# v5.1.18+rev1
## (2024-01-31)

* linux-tegra: Enable CONFIG_ASHMEM [Alexandru Costache]

# v5.1.18
## (2024-01-29)


<details>
<summary> Update layers/meta-balena to 926c556a680f3d42118f2f8cb5c5cd67b1f79c3c [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.18
> ### (2024-01-29)
> 
> * classes: kernel-balena: expose watchdog in sysfs [Alex Gonzalez]
> 

</details>

# v5.1.17
## (2024-01-29)


<details>
<summary> Update layers/meta-balena to 10c68e5f01bbb3f6d2866f11a934635129ed3b0e [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.17
> ### (2024-01-29)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 01e65ec [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.42
>> #### (2024-01-29)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.16
## (2024-01-27)


<details>
<summary> Update layers/meta-balena to 0acd247aa20716b1ceda746e5ff5b7a2634ff427 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.16
> ### (2024-01-27)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 7c94243 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.41
>> #### (2024-01-26)
>> 
>> * Update balena-os/leviathan-worker to v2.9.28 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.15
> ### (2024-01-26)
> 
> * networkmanager: make FORWARD rules for shared interfaces last in chain [Michal Toman]
> 
> ## meta-balena-5.1.14
> ### (2024-01-24)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to e618772 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.40
>> #### (2024-01-23)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.39
>> #### (2024-01-23)
>> 
>> * Update actions/upload-artifact digest to 26f96df [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.13
> ### (2024-01-23)
> 
> * Start extract-balena-ca before os-config update [jaomaloy]
> 
> ## meta-balena-5.1.12
> ### (2024-01-19)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 6be4049 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.38
>> #### (2024-01-18)
>> 
>> * Update actions/upload-artifact digest to 694cdab [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.37
>> #### (2024-01-15)
>> 
>> * Update actions/upload-artifact digest to 1eb3cb2 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.36
>> #### (2024-01-15)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 
> ## meta-balena-5.1.11
> ### (2024-01-18)
> 
> * kernel-balena: Only sign initramfs for EFI machines [Alex Gonzalez]
> * balena-image: Add TPM tools conditionally on tpm machine feature [Alex Gonzalez]
> * initrdscripts: Add TPM/EFI tools conditionally on tpm machine feature [Alex Gonzalez]
> * os-helpers: rename os-helpers-secureboot to os-helpers-efi [Alex Gonzalez]
> * image-balena: extract hup boot partition checks into a function [Alex Gonzalez]
> * balena-keys: Distinguish EFI devices [Alex Gonzalez]
> * balena-image-flasher: only add grub configuration for EFI devices [Alex Gonzalez]
> * balena-image: only add grub configuration for EFI machines [Alex Gonzalez]
> 
> ## meta-balena-5.1.10
> ### (2024-01-12)
> 
> * tests/bluetooth: Leave Autokit host discoverable on BT for a longer period of time [Alexandru Costache]
> 
> ## meta-balena-5.1.9
> ### (2024-01-11)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 0210c02 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.35
>> #### (2024-01-11)
>> 
>> * change to ssh tunnel [rcooke-warwick]
>> 
>> ### leviathan-2.29.34
>> #### (2024-01-10)
>> 
>> * Update core/contracts digest to 14a10d9 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.8+rev3
## (2024-01-24)

* linux-tegra: Enable binder config for Jetson Orin Nano [Alexandru Costache]

# v5.1.8+rev2
## (2024-01-13)

* Update layers/meta-openembedded to 730e44900a0a86265bad93a16b5a5ff344a07266 [Self-hosted Renovate Bot]

# v5.1.8+rev1
## (2024-01-10)


<details>
<summary> Update contracts to 14a10d925b56660c59471447ca74ae324da68f79 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.90
> ### (2024-01-10)
> 
> * hw.device-type: Update svg icon for seeed-j4012 [Alexandru Costache]
> 

</details>

# v5.1.8
## (2024-01-10)


<details>
<summary> Update layers/meta-balena to afa34852ba91dc6e720ae90890c095b73a1f8882 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.8
> ### (2024-01-09)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to dbcacdb [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.33
>> #### (2024-01-09)
>> 
>> * timeout netcat process [rcooke-warwick]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.7
## (2024-01-09)


<details>
<summary> Update layers/meta-balena to e1c602542c6fa2f51ea6e2ff0e6d60e0e3d5beb3 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.7
> ### (2024-01-09)
> 
> 
> <details>
> <summary> Update balena-supervisor to v15.2.0 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-15.2.0
>> #### (2024-01-08)
>> 
>> * Try MDNS lookup only if regular DNS lookup fails [Felipe Lalanne]
>> * Refactor mdns lookup code in app entry [Felipe Lalanne]
>> 
>> ### balena-supervisor-15.1.1
>> #### (2024-01-02)
>> 
>> * docs: api: start-service: specify this endpoint affects the device [Alex Gonzalez]
>> 
>> ### balena-supervisor-15.1.0
>> #### (2023-11-22)
>> 
>> * Force remove container if updateMetadata fails [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.6+rev1
## (2024-01-09)

* tegra-binaries: Update boot blob and capsule for J4012 [Alexandru Costache]

# v5.1.6
## (2024-01-08)


<details>
<summary> Update layers/meta-balena to 18da0e4751bacb78b3da4e95d58a466e32b36faf [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.6
> ### (2024-01-08)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 5163c31 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.32
>> #### (2024-01-08)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.31
>> #### (2024-01-05)
>> 
>> * Update core/contracts digest to b469f31 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.5+rev3
## (2024-01-05)


<details>
<summary> Update contracts to b469f315f2dc5dbd396cbeab6fe3577b948af945 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.89
> ### (2024-01-05)
> 
> * hw.device-type: Fix hyperlinks in provisioning instructions [Alexandru Costache]
> 

</details>

# v5.1.5+rev2
## (2024-01-05)

* hostapp-update-hooks: add hook for J4012 [Alexandru Costache]

# v5.1.5+rev1
## (2024-01-03)


<details>
<summary> Update contracts to 802e95f85092e2bacc14014823b8167add968edd [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.88
> ### (2024-01-03)
> 
> * jetson-orin-nx-seeed-j4012: Add Seeed J4012 device-type [Alexandru Costache]
> 

</details>

# v5.1.5
## (2024-01-01)


<details>
<summary> Update layers/meta-balena to aa9cd7315d801b22635e8468a0341d5dd7182a11 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.5
> ### (2024-01-01)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 70db044 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.30
>> #### (2024-01-01)
>> 
>> * Update core/contracts digest to dd3614e [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.29
>> #### (2024-01-01)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.4+rev4
## (2023-12-29)


<details>
<summary> Update contracts to dd3614e53254562a7f93415de7e7aaaf73637a96 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.87
> ### (2023-12-29)
> 
> * hw.device-type: Fix device type is_private flag for imx8mp-var-dart [Florin Sarbu]
> 

</details>

# v5.1.4+rev3
## (2023-12-29)

* recipes-bsp/uefi: Add UEFI firmware version healthcheck script [Alexandru Costache]

# v5.1.4+rev2
## (2023-12-28)


<details>
<summary> Update contracts to b0c1495877e23b27af209082e6cc9959b94fd541 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.86
> ### (2023-12-28)
> 
> * hw.device-type: Add Variscite DART-MX8M-PLUS [Florin Sarbu]
> 

</details>

# v5.1.4+rev1
## (2023-12-25)


<details>
<summary> Update contracts to 31188f585dc7d7f9e58c138e4c3257e9c2c274c0 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.85
> ### (2023-12-21)
> 
> * patch: Remove wiki link reference to flash Tinker Board [Vipul Gupta (@vipulgupta2048)]
> 

</details>

# v5.1.4
## (2023-12-25)


<details>
<summary> Update layers/meta-balena to b1ad16750b2392ca2301e0a85c272fb4a3ebbde8 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.4
> ### (2023-12-25)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 5068028 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.28
>> #### (2023-12-25)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.3
## (2023-12-22)


<details>
<summary> Update layers/meta-balena to e84aa3890d7eaa439e8e0e64d98a62dd3f33b672 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.3
> ### (2023-12-22)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 57546f9 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.27
>> #### (2023-12-22)
>> 
>> * Update balena-os/leviathan-worker to v2.9.27 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.26
>> #### (2023-12-21)
>> 
>> * Update core/contracts digest to 31188f5 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.25
>> #### (2023-12-18)
>> 
>> * Update actions/upload-artifact action to v4 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.24
>> #### (2023-12-18)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.23
>> #### (2023-12-13)
>> 
>> * Update core/contracts digest to 591fda9 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.2+rev1
## (2023-12-22)


<details>
<summary> Update balena-yocto-scripts to 0008306e565a95aa51d04a8a0fcc318df3df59a2 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.41
> ### (2023-12-22)
> 
> * automation/balena-deploy: Pin to known working version of balena-img [Alexandru Costache]
> 

</details>

# v5.1.2
## (2023-12-21)


<details>
<summary> Update layers/meta-balena to a3b1dd7c9cb8bf593ead65b5c41d5977ad020ab7 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.2
> ### (2023-12-21)
> 
> * balena-config-vars: increase config.json parsing resilience [Alex Gonzalez]
> 

</details>

# v5.1.1
## (2023-12-20)


<details>
<summary> Update layers/meta-balena to 66bfc4c87173155d21d2f82a6888f67f1009ccd8 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.1
> ### (2023-12-20)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.42 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.42
>> #### (2023-12-19)
>> 
>> * Update actions/upload-artifact to v4 and generate unique artifacts [Kyle Harding]
>> 
> 
> </details>
> 
> 

</details>

# v5.1.0
## (2023-12-19)


<details>
<summary> Update layers/meta-balena to d80ee36afa682981b8acce253e28c8237ed8166a [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.1.0
> ### (2023-12-19)
> 
> * migrate: check for mount point before umounting [Alex Gonzalez]
> * initrdscripts: move mounting of log mounts to finish module [Alex Gonzalez]
> 
> ## meta-balena-5.0.11
> ### (2023-12-14)
> 
> * update-balena-supervisor: fix supervisor.conf when image already downloaded [Alex Gonzalez]
> 

</details>

# v5.0.10
## (2023-12-14)


<details>
<summary> Update layers/meta-balena to 3f7d62c3108cf8852fc22f67fd2ed910ef12ed19 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.10
> ### (2023-12-13)
> 
> * hostapp-update-hooks: add debug mode [Alex Gonzalez]
> 

</details>

# v5.0.9+rev2
## (2023-12-13)

* Update layers/meta-openembedded to 402affcc073db39f782c1ebfd718edd5f11eed4c [Self-hosted Renovate Bot]

# v5.0.9+rev1
## (2023-12-13)


<details>
<summary> Update contracts to 591fda9174610519f89842e651f3186eac8862eb [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.84
> ### (2023-12-13)
> 
> * iot-gate-imx8plus: Update flashing instructions and name [Alexandru Costache]
> 

</details>

# v5.0.9
## (2023-12-12)


<details>
<summary> Update layers/meta-balena to 77ede04d006fc181647691958da41161e4f8402e [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.9
> ### (2023-12-12)
> 
> * timesync-https: increase default connection max time to 10s [Alex Gonzalez]
> 

</details>

# v5.0.8
## (2023-12-11)


<details>
<summary> Update layers/meta-balena to e7a8680cc8db8bd7529ed389dd59999a1492c1aa [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.8
> ### (2023-12-11)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to c681ee1 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.22
>> #### (2023-12-11)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.21
>> #### (2023-12-04)
>> 
>> * Update balena-os/leviathan-worker to v2.9.26 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.20
>> #### (2023-12-04)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v5.0.7
## (2023-12-10)


<details>
<summary> Update layers/meta-balena to 91ad9aa182cc5feadf430fea151dc117898919ed [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.7
> ### (2023-12-06)
> 
> * Update actions/setup-python action to v5 [Self-hosted Renovate Bot]
> 

</details>

# v5.0.6+rev1
## (2023-12-10)

* resin-init-flasher-board: switch to using gunzip [Alexandru Costache]

# v5.0.6
## (2023-12-05)


<details>
<summary> Update layers/meta-balena to 3617c776ed31ef47429bb266d4276d63f19a2d58 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.6
> ### (2023-12-05)
> 
> * os-helpers-logging: replace broken container check [Alex Gonzalez]
> 

</details>

# v5.0.5
## (2023-12-02)


<details>
<summary> Update layers/meta-balena to 11ab946c68bc4245e2449ebf4765ecfc1c73831d [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.5
> ### (2023-12-02)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to eaf8774 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.19
>> #### (2023-12-01)
>> 
>> * add jetson-agx-orin-devkit resin-boot index [rcooke-warwick]
>> 
> 
> </details>
> 
> 

</details>

# v5.0.4
## (2023-12-02)


<details>
<summary> Update layers/meta-balena to b33a629f6582bf749164fa40e33b992fa3054e51 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.4
> ### (2023-12-01)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.41 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.41
>> #### (2023-12-01)
>> 
>> * Simplified development doc 'Build and run' instructions [Ken Bannister]
>> 
> 
> </details>
> 
> 

</details>

# v5.0.3
## (2023-12-01)


<details>
<summary> Update layers/meta-balena to 0e2ba69c8a8d7c6b67ec8536f5c84bbd245ac220 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.3
> ### (Invalid date)
> 
> 
> <details>
> <summary> Update balena-supervisor to v15.0.4 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-15.0.4
>> #### (2023-11-22)
>> 
>> * Only build sqlite3 from source [Felipe Lalanne]
>> * Update @balena/systemd to 0.5.0 [Christina Ying Wang]
>> 
>> ### balena-supervisor-15.0.3
>> #### (2023-11-22)
>> 
>> * Cache last reported current state to /mnt/root/tmp [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v5.0.2
## (2023-11-30)


<details>
<summary> Update layers/meta-balena to 4e89f786a171b42546c254557c5f1283c71e9503 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.2
> ### (Invalid date)
> 
> * balena-rollback: If applicable, run device specific healthchecks [Alexandru Costache]
> 

</details>

# v5.0.1+rev1
## (2023-11-29)

* Update layers/meta-openembedded to 8a75c61cce2aa1d6e5a3597ab8fc5a7e6aeae1e4 [Self-hosted Renovate Bot]

# v5.0.1
## (2023-11-29)


<details>
<summary> Update layers/meta-balena to 0fed99ef0c338962d463b38eb58cd64cdf5804ae [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.1
> ### (2023-11-29)
> 
> * Make Engine healthcheck performance test aware of device type [Leandro Motta Barros]
> 

</details>

# v5.0.0
## (2023-11-28)


<details>
<summary> Update layers/meta-balena to a4097f3317ad9b74ad237239b6b6552da75eeaf9 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-5.0.0
> ### (2023-11-28)
> 
> 
> <details>
> <summary> Update balena-supervisor to v15 [Felipe Lalanne] </summary>
> 
>> ### balena-supervisor-15.0.1
>> #### (2023-10-25)
>> 
>> * Expose ports from port mappings on services [Felipe Lalanne]
>> 
>> ### balena-supervisor-15.0.0
>> #### (2023-10-23)
>> 
>> * Ignore `expose` service compose configuration [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.13.14
>> #### (2023-10-23)
>> 
>> * Add note regading API jitter on target state poll [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v4.1.11
## (2023-11-27)


<details>
<summary> Update layers/meta-balena to cb75bf3ef0719cac2b8b080dd99f90d4f6c95705 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.11
> ### (2023-11-27)
> 
> * tests: os: safe-reboot: wait for SV to start [rcooke-warwick]
> 

</details>

# v4.1.10
## (2023-11-27)


<details>
<summary> Update layers/meta-balena to 06288522295690b4722b094098433e5d3cbbd50a [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.10
> ### (2023-11-27)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to c8d2f66 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.18
>> #### (2023-11-27)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.17
>> #### (2023-11-24)
>> 
>> * Update core/contracts digest to 9a88055 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.1.9
## (2023-11-24)


<details>
<summary> Update layers/meta-balena to ea2f9c49095dcc6cfb2ad7289780a7b84f32d031 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.9
> ### (2023-11-24)
> 
> * tests: allow for multiple worker fleets [rcooke-warwick]
> 

</details>

# v4.1.8+rev1
## (2023-11-24)


<details>
<summary> Update contracts to 9a8805526c0fbe4aa1477f32b23c3d0e3647792a [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.83
> ### (2023-11-24)
> 
> * revpi-connect-4: Added contract files for revpi-connect-4 [Waqar Rashid]
> 

</details>

# v4.1.8
## (2023-11-22)


<details>
<summary> Update layers/meta-balena to 3d7cb3b819e6ac6636b7db302dcfc6be0d7c3aed [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.8
> ### (2023-11-22)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 935f8ef [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.16
>> #### (2023-11-22)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.15
>> #### (2023-11-22)
>> 
>> * Update core/contracts digest to c45079c [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.1.7+rev1
## (2023-11-22)


<details>
<summary> Update contracts to c45079c380048f9f65967a68cf30f1654195384f [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.82
> ### (2023-11-22)
> 
> * lcbzu9: boot from internal storage [Francois Loubser]
> 

</details>

# v4.1.7
## (2023-11-17)


<details>
<summary> Update layers/meta-balena to d40a0ca5875c474752cd94aae4e4fd9754b4781f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.7
> ### (2023-11-17)
> 
> * meta-balena-common: Move code from meta-balena-kirkstone [Florin Sarbu]
> 
> ## meta-balena-4.1.6
> ### (2023-11-17)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 30c115d [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.14
>> #### (2023-11-15)
>> 
>> * patch: Add support for local autokit support [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.29.13
>> #### (2023-11-13)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.12
>> #### (2023-11-13)
>> 
>> * Update balena-os/leviathan-worker to v2.9.25 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.11
>> #### (2023-11-13)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.1.5+rev1
## (2023-11-14)

* tegra-binaries: Update pre-flashed boot0 image for AGX Orin Devkt 32GB to L4T 35.4.1 [Alexandru Costache]
* hostapp-update-hooks: Print current active slot prior triggering the capsule [Alexandru Costache]

# v4.1.5
## (2023-11-14)


<details>
<summary> Update layers/meta-balena to 53a1e875f6a48f891d26b5edb9295fc6486ab4e8 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.5
> ### (2023-11-10)
> 
> * update-balena-supervisor: ensure target supervisor is running [Alex Gonzalez]
> * update-balena-supervisor: use os-helpers logging [Alex Gonzalez]
> * hostapp-update: surface logs to journal [Alex Gonzalez]
> * hostapp-update-hooks: surface logs to journal [Alex Gonzalez]
> * os-helpers-logging: skip logging to journal from a container [Alex Gonzalez]
> 
> ## meta-balena-4.1.4
> ### (2023-11-10)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to af50e8d [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.10
>> #### (2023-11-08)
>> 
>> * core: remove request timeout on flashing [rcooke-warwick]
>> 
> 
> </details>
> 
> 
> ## meta-balena-4.1.3
> ### (2023-11-06)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 2a64939 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.9
>> #### (2023-11-06)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.8
>> #### (Invalid date)
>> 
>> * patch: Update Learn More docs content [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.29.7
>> #### (Invalid date)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.6
>> #### (2023-10-26)
>> 
>> * Update core/contracts digest to 1091793 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.1.2+rev3
## (2023-11-13)


<details>
<summary> Update balena-yocto-scripts to 84d8d394f158be4490628d7ca65a50e90667fa4b [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.40
> ### (2023-11-13)
> 
> * Dockerfiles: update balenaCLI version to 17.2.2 [Alex Gonzalez]
> * balena-deploy-block.sh: deploy licenses and changelog as release assets [Alex Gonzalez]
> * balena-deploy: Add changelog to deployed artifacts [Alex Gonzalez]
> * balena-api: add release assets helper functions [Alex Gonzalez]
> 

</details>

# v4.1.2+rev2
## (2023-11-06)

* Update battery backed RTC from system clock on the Orin AGX [Michal Toman]

# v4.1.2+rev1
## (2023-11-02)

* layers/meta-tegra: Switch to L4T 35.4.1 [Alexandru Costache]

# v4.1.2
## (2023-11-01)


<details>
<summary> Update layers/meta-balena to 1f878fc282e911950df09d5af3eb6b61a12d6c48 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.2
> ### (2023-11-01)
> 
> * flasher: remove user mode check after programming keys [Joseph Kogut]
> * initrdscripts: unlock LUKS partitions only in user mode [Joseph Kogut]
> * os-helpers: add secure boot helpers [Joseph Kogut]
> 

</details>

# v4.1.1+rev1
## (2023-10-26)


<details>
<summary> Update contracts to 109179385bb4b862cd7572be14d4c5edddbd93c9 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.81
> ### (2023-10-26)
> 
> * hw.device-type: Add imx8mm-lpddr4-evk device [Alex J Lennon]
> 

</details>

# v4.1.1
## (2023-10-25)


<details>
<summary> Update layers/meta-balena to 0608f561a79e1b4b2ba5e83a10c4b9d2010a00cd [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.1
> ### (2023-10-25)
> 
> * plymouth: Remove --retain-splash flag from plymouth quit [Kyle Harding]
> 

</details>

# v4.1.0
## (2023-10-25)


<details>
<summary> Update layers/meta-balena to 6d41111f954f5c2f080b6f01b37634814b5bc84f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.1.0
> ### (2023-10-25)
> 
> * tests: add safe reboot checks [Alex Gonzalez]
> * hostapp-update: move lock checking to helper function [Alex Gonzalez]
> * os-helpers-logging: output script logging to journald [Alex Gonzalez]
> * os-helpers: add safe_reboot function [Alex Gonzalez]
> 

</details>

# v4.0.31
## (2023-10-24)


<details>
<summary> Update layers/meta-balena to 88fa82e720d8cff1a8e9221703661cb3eee4ad6f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.31
> ### (2023-10-24)
> 
> * Revert "kernel-balena: Remove apparmor support" [Alex Gonzalez]
> 

</details>

# v4.0.30
## (2023-10-23)


<details>
<summary> Update layers/meta-balena to ff47baf219489312903ecbfe52f6f16a2cb284bb [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.30
> ### (2023-10-23)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 5a3ce72 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.5
>> #### (2023-10-23)
>> 
>> * Update Lock file maintenance [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.29
## (2023-10-23)


<details>
<summary> Update layers/meta-balena to c1ed98a9e945d0f1ba684204c2fc10d3fdf59072 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.29
> ### (2023-10-23)
> 
> * resin-device-progress: Add status code check and error reporting [Alex Gonzalez]
> 

</details>

# v4.0.28+rev1
## (2023-10-20)


<details>
<summary> Update balena-yocto-scripts to 39430b27390c28c4b055fb8711005600112a6951 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.39
> ### (2023-10-20)
> 
> * Dockerfile_yocto-build-env: Install rsync and uudecode host dependencies [Alexandru Costache]
> 

</details>

# v4.0.28
## (2023-10-20)


<details>
<summary> Update layers/meta-balena to caa8a7842e0680a4f3a2a51d6b81017ff08fb390 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.28
> ### (2023-10-20)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to cd38f4a [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.4
>> #### (2023-10-20)
>> 
>> * Update core/contracts digest to 42e712d [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.3
>> #### (2023-10-19)
>> 
>> * Update core/contracts digest to 2d44c9c [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.2
>> #### (2023-10-19)
>> 
>> * Update actions/checkout digest to b4ffde6 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.29.1
>> #### (2023-10-19)
>> 
>> * Update core/contracts digest to 97f176d [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.27+rev3
## (2023-10-20)


<details>
<summary> Update contracts to 42e712dfe54929870e1ef51fc95cff10f760ab08 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.80
> ### (2023-10-20)
> 
> * hw.device-type: Modify bluechiptechnology-tm3 [crichardson]
> 

</details>

# v4.0.27+rev2
## (2023-10-19)


<details>
<summary> Update contracts to 2d44c9cb5c64b185fed20caf59d846de4d4b8280 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.79
> ### (2023-10-19)
> 
> * device: Add Compulab UCM-iMX93 [Alexandru Costache]
> 

</details>

# v4.0.27+rev1
## (2023-10-19)


<details>
<summary> Update contracts to 97f176d005a5d91542ac4278ce7dc8eb52dd3e46 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.78
> ### (2023-10-19)
> 
> * hw.device-type: Modify bluechiptechnology-tm3 [crichardson]
> 

</details>

# v4.0.27
## (2023-10-18)


<details>
<summary> Update layers/meta-balena to 2afcf8f6657947fea0ddc5a34fc7c8773b1cfb24 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.27
> ### (2023-10-18)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.13.13 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.13.13
>> #### (2023-10-16)
>> 
>> * Switch some _.includes usage to native versions [Pagan Gazzard]
>> * Switch _.assign usage to native versions [Pagan Gazzard]
>> * Switch _.isNaN usage to native versions [Pagan Gazzard]
>> * Switch _.isFunction usage to native versions [Pagan Gazzard]
>> * Switch _.isUndefined usage to native versions [Pagan Gazzard]
>> * Switch _.isNull usage to native versions [Pagan Gazzard]
>> * Switch _.isNumber usage to native versions [Pagan Gazzard]
>> * Switch _.isArray usage to native versions [Pagan Gazzard]
>> * Switch _.isString usage to native versions [Pagan Gazzard]
>> 
>> ### balena-supervisor-14.13.12
>> #### (2023-10-16)
>> 
>> * Revert "Do not expose ports from image if service network mode" [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.13.11
>> #### (2023-10-16)
>> 
>> * Fix husky config for automatic linting on commit [Pagan Gazzard]
>> 
>> ### balena-supervisor-14.13.10
>> #### (2023-10-16)
>> 
>> * Convert multiple bluebird uses to native promises [Pagan Gazzard]
>> 
>> ### balena-supervisor-14.13.9
>> #### (2023-10-16)
>> 
>> * Do not expose ports from image if service network mode [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.13.8
>> #### (2023-10-12)
>> 
>> * Move mdns-resolver to devDependencies [Felipe Lalanne]
>> * Move got to devDependencies [Felipe Lalanne]
>> * Move semver to dev-dependencies [Felipe Lalanne]
>> * Move happy-eyeballs to dev-dependencies [Felipe Lalanne]
>> * Move systeminformation to devDependencies [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.13.7
>> #### (2023-10-12)
>> 
>> * Use mutation for adding service/image ids to logs to reduce allocations [Pagan Gazzard]
>> * Keep the container lock for the entire duration of attaching logs [Pagan Gazzard]
>> * Remove unnecessary async on handling journald stderr entries [Pagan Gazzard]
>> * Avoid unnecessary work in systemd log row handling for invalid logs [Pagan Gazzard]
>> 
>> ### balena-supervisor-14.13.6
>> #### (2023-10-11)
>> 
>> * Remove unused docker logs logging code [Pagan Gazzard]
>> 
>> ### balena-supervisor-14.13.5
>> #### (2023-10-10)
>> 
>> * Revert os-release path to /mnt/root [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.26
## (2023-10-17)


<details>
<summary> Update layers/meta-balena to b4ba19cb95af296ddb8a4c9998cc741ec9562659 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.26
> ### (2023-10-17)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 62974d9 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.29.0
>> #### (2023-10-16)
>> 
>> * minor: Add Zip Compression support [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.28.35
>> #### (2023-10-16)
>> 
>> * client: enable searching multiple apps for worker [rcooke-warwick]
>> 
>> ### leviathan-2.28.34
>> #### (2023-10-13)
>> 
>> * Update core/contracts digest to a06c0cc [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.33
>> #### (2023-10-13)
>> 
>> * Update balena-os/leviathan-worker to v2.9.24 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.32
>> #### (2023-10-02)
>> 
>> * Update core/contracts digest to d68265e [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.25
## (2023-10-12)


<details>
<summary> Update layers/meta-balena to 4b47f04ece3742de572dd04180e1e30744ed3980 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.25
> ### (2023-10-11)
> 
> * Update Pin dependencies [Self-hosted Renovate Bot]
> 

</details>

# v4.0.24
## (2023-10-11)


<details>
<summary> Update layers/meta-balena to f98f94b3181bfd112b2b88287ae29b134bb4c1ab [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.24
> ### (2023-10-11)
> 
> * classes: image_types_balena: do not hardcode path to data image [Alex Gonzalez]
> 

</details>

# v4.0.23+rev1
## (2023-10-11)


<details>
<summary> Update balena-yocto-scripts to c9f72aa9d032ab2281b918dab5970f18568a7644 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.38
> ### (2023-10-11)
> 
> * README.md ChangeType is needed for PR so add to README example [Alex J Lennon]
> 

</details>

# v4.0.23
## (2023-10-11)


<details>
<summary> Update layers/meta-balena to 2a57fb406f8ddf36f1e907c1b7c236fed64574be [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.23
> ### (2023-10-10)
> 
> * os-helpers-fs: fix returning multiple matching devices [Joseph Kogut]
> 

</details>

# v4.0.22+rev2
## (2023-10-10)


<details>
<summary> Update balena-yocto-scripts to 37a4aa0421848226b41dda508e5fc05fdcc01389 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.37
> ### (2023-10-10)
> 
> * Dockerfile_yocto-build-env: Add screen [Alex J Lennon]
> 

</details>

# v4.0.22+rev1
## (2023-10-10)


<details>
<summary> Update balena-yocto-scripts to e26625baaf2c9cca33933e4baac7b448d644ee30 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.36
> ### (2023-10-10)
> 
> * flowzone: allow external contributions [Alex Gonzalez]
> 

</details>

# v4.0.22
## (2023-10-10)


<details>
<summary> Update layers/meta-balena to 010ff351b1875554aa86fbaa4f1ac5b8f865cc7f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.22
> ### (2023-10-09)
> 
> * Update tibdex/github-app-token action to v2.1.0 [Self-hosted Renovate Bot]
> 

</details>

# v4.0.21+rev1
## (2023-10-09)


<details>
<summary> Update contracts to a06c0ccb61620b3a805339c523f85f69a780b6a5 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.77
> ### (2023-10-09)
> 
> * hw.device-type: Add bluechiptechnology-tm3 [crichardson]
> 

</details>

# v4.0.21
## (2023-10-09)


<details>
<summary> Update layers/meta-balena to 9fe2ab5faca6323fa188bdc3145511083085ffc9 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.21
> ### (2023-10-09)
> 
> * Update backports with current 2.112.x [BalenaCI github workflow]
> 

</details>

# v4.0.20+rev1
## (2023-10-05)

* Update balena-os/github-workflows to [Self-hosted Renovate Bot]

# v4.0.20
## (2023-10-05)


<details>
<summary> Update layers/meta-balena to dda681a93a1e2459925d36fabcb8bd4c6f68363a [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.20
> ### (2023-10-05)
> 
> * balena-net-config: Ensure NM dispatcher scripts are executable [Alexandru Costache]
> 
> ## meta-balena-4.0.19
> ### (2023-10-03)
> 
> * flowzone: meta-balena-esr: add weekly run to keep workflow enabled [Alex Gonzalez]
> 
> ## meta-balena-4.0.18
> ### (2023-10-03)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.13.4 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.13.4
>> #### (2023-10-02)
>> 
>> * Add tmpfs for /mnt/root/tmp in test env [Christina Ying Wang]
>> 
>> ### balena-supervisor-14.13.3
>> #### (2023-10-02)
>> 
>> * Use `~=` to specify alpine package versions [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.13.2
>> #### (Invalid date)
>> 
>> * Use native structuredClone instead of _.cloneDeep [Christina Ying Wang]
>> 
>> ### balena-supervisor-14.13.1
>> #### (2023-09-28)
>> 
>> * Update balena-io/deploy-to-balena-action to v1.0.3 [Self-hosted Renovate Bot]
>> 
>> ### balena-supervisor-14.13.0
>> #### (2023-09-28)
>> 
>> * Update runtime-base image to alpine:3.18 [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.17
## (2023-10-03)


<details>
<summary> Update layers/meta-balena to b1e2d7f34e4bffe2c6149b0a360cb226c6f644a7 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.17
> ### (2023-10-02)
> 
> * workflows: Switch to balenaOS ESR [bot] for authentication [Kyle Harding]
> 

</details>

# v4.0.16+rev1
## (2023-10-02)

* Update balena-os/github-workflows to v0.0.24 [Self-hosted Renovate Bot]

# v4.0.16
## (2023-10-02)


<details>
<summary> Update layers/meta-balena to 1c9c4813033186cefde51b9639edf7035f070c9d [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.16
> ### (2023-09-28)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 04a53d3 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.31
>> #### (2023-09-28)
>> 
>> * Update core/contracts digest to 27ea28b [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.15+rev4
## (2023-10-02)


<details>
<summary> Update contracts to d68265ebeac98e7814829da7e7f6bb2a9aff8e39 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.76
> ### (2023-10-02)
> 
> * hw.device-type: Add Eurotec Lowpad lcbzu9 device [Francois Loubser]
> 

</details>

# v4.0.15+rev3
## (2023-09-28)


<details>
<summary> Update balena-yocto-scripts to 29e8e0678085db54226956617ae66b59f5a28f8d [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.35
> ### (2023-09-28)
> 
> * balena-deploy: fail if device type not found [rcooke-warwick]
> * balena-api: Dont assume private if can't get DT [rcooke-warwick]
> 

</details>

# v4.0.15+rev2
## (2023-09-28)


<details>
<summary> Update contracts to 12fb777da3f386501d3fa386b9ac9319afd9a424 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.75
> ### (2023-09-28)
> 
> * raspberrypi5: remove reference to 64bits in display name [Alex Gonzalez]
> 
> ## contracts-2.0.74
> ### (2023-09-28)
> 
> * raspberrypi5: Explicitly flag as public for the switch to apply [Alex Gonzalez]
> 

</details>

# v4.0.15+rev1
## (2023-09-28)


<details>
<summary> Update contracts to 27ea28be5e65c06cac559ab5bddeccf77d13830f [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.73
> ### (2023-09-28)
> 
> * raspberrypi5: Add new device type [Florin Sarbu]
> 

</details>

# v4.0.15
## (2023-09-28)


<details>
<summary> Update layers/meta-balena to 44da832b8ba67e5889f8c0d09cea7372ca0b7c09 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.15
> ### (2023-09-27)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to b4e68c8 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.30
>> #### (2023-09-25)
>> 
>> * Update actions/checkout action to v4 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 
> ## meta-balena-4.0.14
> ### (2023-09-27)
> 
> * patch: Add custom build docs [Vipul Gupta (@vipulgupta2048)]
> 

</details>

# v4.0.13
## (2023-09-26)


<details>
<summary> Update layers/meta-balena to 57352e943a786ab900f9dd9d07fcd39963babdf6 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.13
> ### (2023-09-26)
> 
> * balena-rollback: Add support for balena bootloader [Michal Toman]
> * hostapp-update-hooks: Add hook for balena bootloader [Michal Toman]
> * initrdscripts: add a script that switches between rootA and rootB [Michal Toman]
> * initrdscripts: make kexec script more robust [Michal Toman]
> * initrdscripts: add missing dependencies to rootfs script [Michal Toman]
> * balena-image-bootloader-initramfs: Add balena bootloader [Alex Gonzalez]
> 

</details>

# v4.0.12
## (2023-09-25)


<details>
<summary> Update layers/meta-balena to 4fe79e7ee65f47c0a5baebbd82b35aec71d92fbd [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.12
> ### (2023-09-25)
> 
> * Check if SUPERVISOR_OVERRIDE_LOCK is set [jaomaloy]
> * Check and get service lockfiles on HUP reboot [jaomaloy]
> 

</details>

# v4.0.11
## (2023-09-21)


<details>
<summary> Update layers/meta-balena to 2afff0f8f102e7525f41c81c6c41d0c184a6e5be [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.11
> ### (2023-09-21)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.40 [Leandro Motta Barros] </summary>
> 
>> ### balena-engine-20.10.40
>> #### (2023-09-11)
>> 
>> * Re-vendor to get the containerd-shim-runc-v2 sources [Leandro Motta Barros]
>> * Default to io.containerd.runc.v2 [Robert Günzler]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.10+rev1
## (2023-09-21)

* Discontinue Forecr DSB NX2 board [Alexandru Costache]

# v4.0.10
## (2023-09-20)


<details>
<summary> Update layers/meta-balena to 966f4447225b4d7def470789ca6239067c22591d [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.10
> ### (2023-09-20)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.12.2 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.12.2
>> #### (2023-09-15)
>> 
>> * Dump target-state to hostOS tmp dir [jaomaloy]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.9+rev2
## (2023-09-18)

* Update balena-os/github-workflows to v0.0.22 [Self-hosted Renovate Bot]

# v4.0.9+rev1
## (2023-09-18)

* Update .gitmodules with submodule branch information [Kyle Harding]

# v4.0.9
## (2023-09-16)


<details>
<summary> Update layers/meta-balena to 8f952b7a5c8db38d6c674c2a0bef577c743ba2f0 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.9
> ### (2023-09-15)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 397a10f [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.29
>> #### (2023-09-14)
>> 
>> * Update balena-os/leviathan-worker to v2.9.23 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.28
>> #### (2023-09-12)
>> 
>> * Update balena-os/leviathan-worker to v2.9.22 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.8
## (2023-09-15)


<details>
<summary> Update layers/meta-balena to 3282f57a59799111d7f68c13013f6324aa65c966 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.8
> ### (2023-09-15)
> 
> * Enable back ModemManager AT commands through D-Bus and	mmcli [Zahari Petkov]
> 

</details>

# v4.0.7
## (2023-09-14)


<details>
<summary> Update layers/meta-balena to 3c2bfbdb10a51ef5b3fd3f7e59888645f2029ecc [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.7
> ### (2023-09-14)
> 
> * Update tibdex/github-app-token action to v2 [Self-hosted Renovate Bot]
> 

</details>

# v4.0.6
## (2023-09-13)


<details>
<summary> Update layers/meta-balena to 6b39839656ee335e08081474e0c528978fdcae6c [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.6
> ### (2023-09-13)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.12.1 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.12.1
>> #### (2023-08-21)
>> 
>> * Bump sqlite3 to 5.1.6 [Felipe Lalanne]
>> * Bump knex to v2.5.1 [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.5
## (2023-09-13)


<details>
<summary> Update layers/meta-balena to cd6279920e902422377cd21d81584ccf1791676c [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.5
> ### (2023-09-13)
> 
> * tests: os: retry healthcheck disable [rcooke-warwick]
> 

</details>

# v4.0.4
## (2023-09-11)


<details>
<summary> Update layers/meta-balena to 5ebb6671a99eaaa577e03fd16290d25493d05ee2 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.4
> ### (2023-09-11)
> 
> * renovate updates patch only [ab77]
> 

</details>

# v4.0.3+rev1
## (2023-09-11)

* Use battery backed-up RTC in Orin AGX devkit [Alex Gonzalez]

# v4.0.3
## (2023-09-09)


<details>
<summary> Update layers/meta-balena to 3cdf98b11926bdbf27fb7870326a3f5d05e67e11 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.3
> ### (2023-09-09)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 0acfe61 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.27
>> #### (2023-09-06)
>> 
>> * Update actions/upload-artifact digest to a8a3f3a [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.26
>> #### (2023-09-04)
>> 
>> * Update core/contracts digest to 518a1d4 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.2
## (2023-09-08)


<details>
<summary> Update layers/meta-balena to 5e772f467a81643ad3b78007ce9662df03782bc1 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.2
> ### (2023-09-08)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.39 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.39
>> #### (Invalid date)
>> 
>> * Don't enable AppArmor if `apparmor_parser` is not present [Leandro Motta Barros]
>> 
> 
> </details>
> 
> 

</details>

# v4.0.1
## (2023-09-08)


<details>
<summary> Update layers/meta-balena to 6db6c7c9774bf58dc4676816280f81fae83df78e [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.1
> ### (2023-09-08)
> 
> * classes: sign: add a retry to the signing call [Alex Gonzalez]
> 

</details>

# v4.0.0
## (2023-09-06)


<details>
<summary> Update layers/meta-balena to b85be94a14e77496ff21e131642f596a247efd59 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-4.0.0
> ### (2023-09-06)
> 
> * Update actions/checkout action to v4 [Self-hosted Renovate Bot]
> 

</details>

# v3.2.12
## (2023-09-06)


<details>
<summary> Update layers/meta-balena to c0508d3c1ae14f7f4c80312b044cc4a1efa46c60 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.12
> ### (2023-09-06)
> 
> * timesync-https: skip time sync if connectivity URI is null [Alex Gonzalez]
> * README: update time in the OS section [Alex Gonzalez]
> 

</details>

# v3.2.11+rev1
## (2023-09-04)


<details>
<summary> Update contracts to 518a1d424f09a11dc1b60a16026bfe8ffe07ca78 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.72
> ### (2023-09-04)
> 
> * raspberrypi4-unipi-neuron: Add new device type [Florin Sarbu]
> 

</details>

# v3.2.11
## (2023-09-01)


<details>
<summary> Update layers/meta-balena to c1fb1e6bc532507ed9084ba613a481a6a7dbd466 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.11
> ### (2023-09-01)
> 
> * Update tibdex/github-app-token action to v1.8.2 [Self-hosted Renovate Bot]
> 

</details>

# v3.2.10
## (2023-09-01)


<details>
<summary> Update layers/meta-balena to cacbac0f5dc91de46ab61fcb1f517390dc4724ed [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.10
> ### (2023-09-01)
> 
> * meta-resin-pyro: do not apply further modemmanager updates [Alex Gonzalez]
> 

</details>

# v3.2.9
## (2023-08-31)


<details>
<summary> Update layers/meta-balena to 3e9aa973067758b0424798dba9e9b9bdaf33a9d3 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.9
> ### (2023-09-01)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to b353754 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.25
>> #### (Invalid date)
>> 
>> * Update balena-os/leviathan-worker to v2.9.21 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.24
>> #### (Invalid date)
>> 
>> * Update balena-os/leviathan-worker to v2.9.20 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.23
>> #### (Invalid date)
>> 
>> * Update balena-os/leviathan-worker to v2.9.19 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.22
>> #### (Invalid date)
>> 
>> * add nocache flash to balena push [rcooke-warwick]
>> 
>> ### leviathan-2.28.21
>> #### (Invalid date)
>> 
>> * patch: Update client dependencies [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.28.20
>> #### (Invalid date)
>> 
>> * patch: Clarify env variables in Documentation [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.28.19
>> #### (Invalid date)
>> 
>> * patch: Add .nojekyll file to docs [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.28.18
>> #### (2023-08-29)
>> 
>> * patch: Resolve dead links in README [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.28.17
>> #### (2023-08-29)
>> 
>> * Update core/contracts digest to ca46c34 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.16
>> #### (2023-08-25)
>> 
>> * Update core/contracts digest to d61d911 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.15
>> #### (2023-08-25)
>> 
>> * Update actions/checkout digest to f43a0e5 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.14
>> #### (2023-08-25)
>> 
>> * Remove custom automerge rules and use the inherited rules [Kyle Harding]
>> 
>> ### leviathan-2.28.13
>> #### (2023-08-25)
>> 
>> * patch: Exit GH job if tests fails [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v3.2.8+rev1
## (2023-08-29)


<details>
<summary> Update contracts to ca46c341b263adfd70071288d669f7479983f326 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.71
> ### (2023-08-29)
> 
> * Add the BeagleBone AI-64. [Lisandro Damián Nicanor Pérez Meyer]
> 

</details>

# v3.2.8
## (2023-08-24)


<details>
<summary> Update layers/meta-balena to 9b15abeeb36a1e2a8e1b382a1f9b00b3c034371c [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.8
> ### (2023-08-24)
> 
> * meta-balena-warrior: modemmanager: use v 1.18.4 [Alex Gonzalez]
> * meta-balena-warrior: libmqmi: use v 1.30.2 [Alex Gonzalez]
> * meta-balena-warrior: libmbim: use v 1.26.2 [Alex Gonzalez]
> 

</details>

# v3.2.7
## (2023-08-24)


<details>
<summary> Update layers/meta-balena to d0fb824dca1869d27592e5c48b757cbf95ae106f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.7
> ### (2023-08-24)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to e7622aa [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.12
>> #### (2023-08-23)
>> 
>> * Update balena-os/leviathan-worker to v2.9.18 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v3.2.6+rev1
## (2023-08-24)


<details>
<summary> Update contracts to d61d9118688241409d15a3ba10e963f9a202e347 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.70
> ### (2023-08-23)
> 
> * Add alpine 3.18 [Kyle Harding]
> 

</details>

# v3.2.6
## (2023-08-23)


<details>
<summary> Update layers/meta-balena to e390695280de65b7e451afe624daaeea31dde595 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.6
> ### (2023-08-23)
> 
> * resin-u-boot.class: Fix for older u-boot versions [Alex Gonzalez]
> 

</details>

# v3.2.5+rev2
## (2023-08-23)

* tegra-binaries: Update boot blob for Orin NX [Alexandru Costache]

# v3.2.5+rev1
## (2023-08-22)


<details>
<summary> Update contracts to 10b9852d5826601854c35be13555647ca65bdb54 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.69
> ### (2023-08-22)
> 
> * Remove Ubuntu Impish and Kinetic and add Lunar [Kyle Harding]
> 

</details>

# v3.2.5
## (2023-08-22)


<details>
<summary> Update layers/meta-balena to b65f4a096bfae592e7f02acf7dd0be2110c84ae9 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.5
> ### (2023-08-22)
> 
> * contributing-device-support.md: Clarify repo set-up in balenaOS org for private device types [Florin Sarbu]
> 

</details>

# v3.2.4
## (2023-08-21)


<details>
<summary> Update layers/meta-balena to ab712a25ab4b9747037fc2a20f76e1d0b6f49e5e [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.4
> ### (2023-08-21)
> 
> * tests: cloud: lockfile: change test order [rcooke-warwick]
> 

</details>

# v3.2.3
## (2023-08-21)


<details>
<summary> Update layers/meta-balena to ab4a4bdbce4c33a63a24f9d969f18711ddbfdc96 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.3
> ### (2023-08-21)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 26e6cea [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.11
>> #### (2023-08-18)
>> 
>> * improve autokit quickstart [rcooke-warwick]
>> 
>> ### leviathan-2.28.10
>> #### (2023-08-18)
>> 
>> * patch: Update suites dependencies to latest [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.28.9
>> #### (2023-08-18)
>> 
>> * patch: Add balenaCloud configurable environments to e2e [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v3.2.2
## (2023-08-18)


<details>
<summary> Update layers/meta-balena to ba317bb80bb108576d8421a81547bf9cfdad1faf [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.2
> ### (2023-08-18)
> 
> * modemmanager: hold ModemManager 1.14.2 on Thud [Alex Gonzalez]
> * meta-balena-thud: libqmi: Use v1.26.0 [Alex Gonzalez]
> * meta-balena-thud: libmbim: use v 1.24.2 [Alex Gonzalez]
> 

</details>

# v3.2.1
## (2023-08-17)


<details>
<summary> Update layers/meta-balena to ec885550473b00b86e986f84bfd74f06a137fd24 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.1
> ### (2023-08-17)
> 
> * meta-balena-thud: adapt migrate module dependencies [Alex Gonzalez]
> 

</details>

# v3.2.0
## (2023-08-17)


<details>
<summary> Update layers/meta-balena to 87546c158a40798749c94fdab9355e3c39920490 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.2.0
> ### (2023-08-17)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.12.0 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.12.0
>> #### (2023-08-17)
>> 
>> * Update README [Felipe Lalanne]
>> * Replace node-dbus with @balena/systemd [Felipe Lalanne]
>> * Replace dbus test service with mock-systemd-bus [Felipe Lalanne]
>> * Update to nodejs 18 [Pagan Gazzard]
>> 
> 
> </details>
> 
> 

</details>

# v3.1.13
## (2023-08-16)


<details>
<summary> Update layers/meta-balena to eeb57a87d32b9dafb4656a5a598a57da425892e4 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.13
> ### (2023-08-16)
> 
> * Integration layers: mobile-broadband-provider: fix fetch failure [Alex Gonzalez]
> 

</details>

# v3.1.12+rev1
## (2023-08-15)


<details>
<summary> Update contracts to d09ff464591acafff8da686110ecc315f94745fa [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.68
> ### (2023-08-15)
> 
> * iot-gate-imx8plus: Improve provisioning instructions for Windows [Alexandru Costache]
> 

</details>

# v3.1.12
## (2023-08-15)


<details>
<summary> Update layers/meta-balena to 07e9c06daa0b46154a241b448569c89ab307b6e7 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.12
> ### (2023-08-15)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.14 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.14
>> #### (2023-08-14)
>> 
>> * Update balena-io/deploy-to-balena-action to v0.28.0 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v3.1.11
## (2023-08-12)


<details>
<summary> Update layers/meta-balena to 096a3557f96faa00ae018d3aebc7e272949f9e9e [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.11
> ### (2023-08-12)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.13 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.13
>> #### (2023-08-10)
>> 
>> * patch: Remove reference of override_lock variable [Vipul Gupta]
>> 
> 
> </details>
> 
> 

</details>

# v3.1.10
## (2023-08-12)


<details>
<summary> Update layers/meta-balena to e6802f52d479d4ac76622dc6049740c03b0172c2 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.10
> ### (2023-08-12)
> 
> * hostapp-update: bind-mount /sys for Jetson efivars [Alexandru Costache]
> 

</details>

# v3.1.9
## (2023-08-10)


<details>
<summary> Update layers/meta-balena to b7d25711fe3895125b92a0ff2852aa82f5c75cee [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.9
> ### (2023-08-10)
> 
> * tests: secureboot: add test for module signing [Joseph Kogut]
> 

</details>

# v3.1.8+rev1
## (2023-08-10)

* Update build instructions in README [Alex Gonzalez]

# v3.1.8
## (2023-08-09)


<details>
<summary> Update layers/meta-balena to b64d73fcc51374ed90f2ede803b3efee13351d30 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.8
> ### (2023-08-09)
> 
> * tests: hup: retry sending image if fails [rcooke-warwick]
> 

</details>

# v3.1.7
## (2023-08-08)


<details>
<summary> Update layers/meta-balena to a54f1b2a8253d564634789283980d54004201bdf [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.7
> ### (2023-08-08)
> 
> * tests: os: eng. healthcheck: retry timeout change [rcooke-warwick]
> 

</details>

# v3.1.6+rev3
## (2023-08-03)


<details>
<summary> Update contracts to bd81b500fe74976567485afa39f6bbab3e60dd77 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.67
> ### (2023-08-03)
> 
> * Fix conditional when installing libssl1.1 [Kyle Harding]
> 
> ## contracts-2.0.66
> ### (2023-08-03)
> 
> * Fix a condition where /etc/nsswitch.conf exists and the build fails [Kyle Harding]
> 

</details>

# v3.1.6+rev2
## (2023-08-03)

* tegra-flash-dry: Fix wifi card not detected on Orin NX [Alexandru Costache]

# v3.1.6+rev1
## (2023-08-02)


<details>
<summary> Update contracts to bf0ec3d5a42dae4babeed8485030a0ca50f6fde3 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.65
> ### (2023-08-02)
> 
> * Replace ifupdown with ifupdown-ng for alpine edge [Kyle Harding]
> 
> ## contracts-2.0.64
> ### (2023-08-02)
> 
> * Remove OpenJDK v7 as it has been removed from alpine edge [Kyle Harding]
> 

</details>

# v3.1.6
## (2023-08-02)


<details>
<summary> Update layers/meta-balena to a84dc6fbc5967f67acf0d12f4fe5a9081a70cb63 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.6
> ### (2023-08-02)
> 
> * resin-init-flasher: Allow background device registration [Michal Toman]
> 

</details>

# v3.1.5
## (2023-08-01)


<details>
<summary> Update layers/meta-balena to a71647f35b7987e21887d7cf0d0f6a883662ff5b [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.5
> ### (2023-08-01)
> 
> * Reduce scope of app token used for backports and ESR [Kyle Harding]
> 

</details>

# v3.1.4+rev2
## (2023-08-01)

* Update balena-os/github-workflows to v0.0.21 [Self-hosted Renovate Bot]

# v3.1.4+rev1
## (2023-07-31)

* tegra-flash-dry: Fix boot blob Orin NX on 35.3.1 [Alexandru Costache]

# v3.1.4
## (2023-07-30)


<details>
<summary> Update layers/meta-balena to 3ee7dc32110f9da60a088b5bd4bb39642d901bb5 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.4
> ### (Invalid date)
> 
> * kernel-balena: remove mispelled config setting [Alex Gonzalez]
> 

</details>

# v3.1.3+rev1
## (2023-07-28)

* tegra-flash-dry: Update boot blob for Orin NX on L4T 35.3.1 [Alexandru Costache]

# v3.1.3
## (2023-07-28)


<details>
<summary> Update layers/meta-balena to 3df341dcfa5681fc27d0713814635ddfe20d6a17 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.3
> ### (2023-07-28)
> 
> * resin-init-flasher: Install the dispatcher scripts to installation media [Alex Gonzalez]
> * balena-net-config: populate the dispatcher bind mount [Alex Gonzalez]
> * resin-mounts: add dispatcher.d bind mount [Alex Gonzalez]
> 

</details>

# v3.1.2
## (2023-07-27)


<details>
<summary> Update layers/meta-balena to 5dbd59262ff28b0036e2730d428499e134343c36 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.2
> ### (2023-07-27)
> 
> * grub-conf: Do not hardcode the path for grub_extraenv [Michal Toman]
> 

</details>

# v3.1.1+rev1
## (2023-07-27)

* hostapp-update-hooks: Move efivars trigger to 'after' hook [Alexandru Costache]

# v3.1.1
## (2023-07-26)


<details>
<summary> Update layers/meta-balena to ced059b1f06281129434311dddc8ddab3d65fb5b [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.1
> ### (2023-07-26)
> 
> * linux/kernel-devsrc: Fix aarch64 kernel-headers-test build [Alexandru Costache]
> 

</details>

# v3.1.0
## (2023-07-25)


<details>
<summary> Update layers/meta-balena to 76a64e46ebf953fba9e78aa7e60892113ccb9ad7 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.1.0
> ### (2023-07-25)
> 
> * linux-firmware: upgrade 20210511 -> 20230404 [Joseph Kogut]
> * common: firmware: repackage iwlwifi-quz-a0-hr-b0 [Joseph Kogut]
> * common: firmware: repackage iwlwifi-cc-a0 [Joseph Kogut]
> * compat: connectivity: drop deprecated iwlwifi files [Joseph Kogut]
> * compat: install linux-firmware-iwlwifi-3160 [Joseph Kogut]
> 

</details>

# v3.0.17
## (2023-07-25)


<details>
<summary> Update layers/meta-balena to 424c259104716586e450738c7de6fb7ef3472a02 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.17
> ### (2023-07-25)
> 
> * balena-image: Install extra_uEnv for all boards that use u-boot [Alexandru Costache]
> 

</details>

# v3.0.16+rev1
## (2023-07-25)

* hostapp-update-hook: Trigger uefi update on next reboot for AGX Orin [Alexandru Costache]

# v3.0.16
## (2023-07-22)


<details>
<summary> Update layers/meta-balena to e1f474a9b8d28d5b0a0b993dd52108c214a376ea [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.16
> ### (2023-07-22)
> 
> * modemmanager: increase qmi port open timeout [Alexandru Costache]
> * Update ModemManager to v1.20.6 [Zahari Petkov]
> 

</details>

# v3.0.15
## (2023-07-20)


<details>
<summary> Update layers/meta-balena to a20f839eb56d1636e9905c4809e27c4c318977e8 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.15
> ### (2023-07-20)
> 
> * tests: cloud: sv-timer: account for conn. error [rcooke-warwick]
> * tests: cloud: use local ssh for sv timer test [rcooke-warwick]
> * tests: cloud: remove preload log check [rcooke-warwick]
> * tests: allow for configurable BC env [rcooke-warwick]
> 

</details>

# v3.0.14
## (2023-07-20)


<details>
<summary> Update layers/meta-balena to e378e5c5ac8186c1d8164a05f8aa669c1fe97ed9 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.14
> ### (2023-07-20)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.12 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.12
>> #### (2023-07-19)
>> 
>> * mount-partitions: do not hardcode partition types [Alex Gonzalez]
>> 
>> ### balena-supervisor-14.11.11
>> #### (2023-07-12)
>> 
>> * backends: Add Jetson Orin NANO custom device-tree support [Alexandru Costache]
>> 
> 
> </details>
> 
> 

</details>

# v3.0.13
## (2023-07-19)


<details>
<summary> Update layers/meta-balena to 8d432e761bf29b2f9f3f8f9f711b087f9133cfa6 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.13
> ### (2023-07-19)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 4e4c1bb [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.8
>> #### (2023-07-19)
>> 
>> * Update balena-os/leviathan-worker to v2.9.13 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.7
>> #### (2023-07-18)
>> 
>> * update e2e tests to use sshconfig [rcooke-warwick]
>> * core: allow configurable ssh target [rcooke-warwick]
>> 
> 
> </details>
> 
> 
> ## meta-balena-3.0.12
> ### (2023-07-16)
> 
> * tests/os: skip boot switch during provisioning [Alexandru Costache]
> 

</details>

# v3.0.11+rev1
## (2023-07-14)

* Update balena-os/github-workflows to [Self-hosted Renovate Bot]

# v3.0.11
## (2023-07-14)


<details>
<summary> Update layers/meta-balena to 146e74b5bc28ae5ed734835a4d5a71cb974f51c6 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.11
> ### (2023-07-14)
> 
> * .github/workflows: Replace GitHub PAT with ephemeral app tokens [Kyle Harding]
> 
> ## meta-balena-3.0.10
> ### (2023-07-14)
> 
> * initrdscripts: make initramfs-module-cryptsetup pull libgcc in [Michal Toman]
> 

</details>

# v3.0.9
## (2023-07-13)


<details>
<summary> Update layers/meta-balena to cd6d6ef437a25ada9a03029367e3b6f36c2b4f6d [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.9
> ### (2023-07-13)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to b1581a2 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.6
>> #### (2023-07-13)
>> 
>> * Update balena-os/leviathan-worker to v2.9.12 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.5
>> #### (2023-07-13)
>> 
>> * Update balena-os/leviathan-worker to v2.9.11 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v3.0.8+rev3
## (2023-07-12)


<details>
<summary> Update balena-yocto-scripts to 45e32821ac6e3efba81e24a21e417a375da5e154 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.34
> ### (2023-07-12)
> 
> * Remove all traces of --skip-discontinued [Florin Sarbu]
> * barys: Remove documenting the --skip-discontinued option [Florin Sarbu]
> 
> ## balena-yocto-scripts-1.19.33
> ### (2023-07-10)
> 
> * Update device-types package from v10.3.0 to v10.5.1 [Alex Gonzalez]
> * barys: remove option to skip discontinued device types [Alex Gonzalez]
> * balena-lib: remove balena_lib_get_dt_state [Alex Gonzalez]
> * jenkins_build: remove discontinued device check [Alex Gonzalez]
> * balena-deploy: remove discontinued check [Alex Gonzalez]
> 

</details>

# v3.0.8+rev2
## (2023-07-11)

* tegra-binaries: Update Orin NVME boot blob after partition size change [Alexandru Costache]

# v3.0.8+rev1
## (2023-07-10)

* tegra-binaries: Shrink Orin Nano partition sizes [Alexandru Costache]

# v3.0.8
## (2023-07-10)


<details>
<summary> Update layers/meta-balena to d36ec27a6f467d936e93a0f4c64f59cd917a00a2 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.8
> ### (2023-07-10)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to e081190 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.4
>> #### (2023-07-07)
>> 
>> * Update balena-os/leviathan-worker to v2.9.10 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 
> ## meta-balena-3.0.7
> ### (2023-07-06)
> 
> * bail out in kexec initramfs hook on failure [Joseph Kogut]
> 

</details>

# v3.0.6
## (2023-07-06)


<details>
<summary> Update layers/meta-balena to f7963b6b6d2cafd4d2b9ab4cfb12052d1afa0e53 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.6
> ### (2023-07-06)
> 
> * kernel-devsrc: fix for v6.1+ [Alex Gonzalez]
> 

</details>

# v3.0.5
## (2023-07-06)


<details>
<summary> Update layers/meta-balena to 5fca7f6bd85c00824689bedb2ceb4ee3fb5faad2 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.5
> ### (2023-07-06)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.10 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.10
>> #### (2023-07-05)
>> 
>> * Add revpi-connect-s to Raspberry Pi variants [Florin Sarbu]
>> 
> 
> </details>
> 
> 

</details>

# v3.0.4
## (2023-07-05)


<details>
<summary> Update layers/meta-balena to 6a3ed9d310f41d687c9751f8e3e8c37604195cd4 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.4
> ### (2023-07-05)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.38 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.38
>> #### (2023-07-03)
>> 
>> * Document a couple of troubleshooting tips [Leandro Motta Barros]
>> 
> 
> </details>
> 
> 

</details>

# v3.0.3
## (2023-07-05)


<details>
<summary> Update layers/meta-balena to 744eb2021a797c2e2b116e791c395cd0e6b133d7 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.3
> ### (2023-07-05)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.9 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.9
>> #### (2023-06-28)
>> 
>> * Remove the 'Stopped' status for services [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v3.0.2
## (2023-07-05)


<details>
<summary> Update layers/meta-balena to fac2a045b028c533f12b67712d663cfd3a360649 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.2
> ### (2023-07-05)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 498d4cb [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.28.3
>> #### (2023-07-05)
>> 
>> * Update balena-os/leviathan-worker to v2.9.9 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.2
>> #### (2023-07-05)
>> 
>> * Update core/contracts digest to 6e3d563 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.28.1
>> #### (2023-07-05)
>> 
>> * patch: Pass env variables to client [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.28.0
>> #### (Invalid date)
>> 
>> * minor: Make client work with different balenaCloud environments [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v3.0.1
## (2023-07-05)


<details>
<summary> Update layers/meta-balena to 0232d66721fc127cc14e5078bbc811d50b3cf7a4 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.1
> ### (2023-07-04)
> 
> * docs: Explain TPM ownership and possible TPM fill-up with secure boot [Michal Toman]
> * docs: Recommend BIOS password and no F-key shortcuts with secure boot [Michal Toman]
> 

</details>

# v3.0.0
## (2023-07-04)


<details>
<summary> Update layers/meta-balena to 05dfed30f590eb14e1721a471262d64e798dea46 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-3.0.0
> ### (2023-07-04)
> 
> * mkfs-hostapp-native: Allow the compile task to access the network [Alex Gonzalez]
> * mkfs-hostapp-native: Use image tags instead of parsing docker output [Alex Gonzalez]
> * kernel-headers-test: Use image tags instead of parsing docker output [Alex Gonzalez]
> * kernel-headers-test: Allow network access for compile task [Alex Gonzalez]
> * kernel-modules-headers: use kernel-devsrc to provide kernel headers [Alex Gonzalez]
> 

</details>

# v2.115.18
## (2023-06-29)


<details>
<summary> Update layers/meta-balena to c087c2dbcff4ed666bbad7901fe0f28794c99bc0 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.18
> ### (2023-06-29)
> 
> * resin-init-flasher: Increase size of LUKS header to 16MB [Michal Toman]
> 
> ## meta-balena-2.115.17
> ### (2023-06-28)
> 
> * balena-keys: add SIGN_KMOD_KEY_APPEND [Joseph Kogut]
> 
> ## meta-balena-2.115.16
> ### (2023-06-28)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.8 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.8
>> #### (2023-06-23)
>> 
>> * Parse container exit error message instead of status [Christina W]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.115.15
> ### (2023-06-28)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.37 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.37
>> #### (2023-06-26)
>> 
>> * Bugfix: concatReadSeekCloser.Read() with buffers of any size [Leandro Motta Barros]
>> * Minor code and comments tweaks [Leandro Motta Barros]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.115.14
> ### (2023-06-27)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to a19d6ef [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.27.9
>> #### (2023-06-27)
>> 
>> * Update balena-os/leviathan-worker to v2.9.8 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.27.8
>> #### (2023-06-27)
>> 
>> * Update core/contracts digest to 6c4386a [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.27.7
>> #### (2023-06-22)
>> 
>> * patch: Update QEMU getting started guide [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v2.115.13+rev2
## (2023-06-29)


<details>
<summary> Update contracts to 6e3d563f610303a24d0cbf43839919e451879899 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.63
> ### (2023-06-29)
> 
> * sw.os+hw.device-type: Add ubuntu and debian distro configs for Orin Nano [Alexandru Costache]
> 
> ## contracts-2.0.62
> ### (2023-06-27)
> 
> * hw.device-type: Add Jetson Orin Nano Devkit 8GB (SD) module [Alexandru Costache]
> 

</details>

# v2.115.13+rev1
## (2023-06-29)

* tegra-flash-dry: Update to 35.3.1 and include placeholder bootblob [Alexandru Costache]

# v2.115.13
## (2023-06-26)


<details>
<summary> Update layers/meta-balena to 87c91cdae3ca87e44a9417627c260701a5f85df9 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.13
> ### (2023-06-26)
> 
> * os-helpers: Fix os-helpers-api build warnings [Alex Gonzalez]
> 

</details>

# v2.115.12
## (2023-06-23)


<details>
<summary> Update layers/meta-balena to f50614c3a4c7e6db317d4404368827508d8fce82 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.12
> ### (2023-06-23)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.7 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.7
>> #### (2023-06-19)
>> 
>> * Fix /v2/applications/state endpoint [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.11.6
>> #### (2023-06-19)
>> 
>> * Add fail-safe to test the image architecture [Felipe Lalanne]
>> * Use multi-arch in dockerfile [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.11.5
>> #### (2023-06-19)
>> 
>> * Improve tests surrounding Engine-host race patch [Christina Ying Wang]
>> 
>> ### balena-supervisor-14.11.4
>> #### (2023-06-19)
>> 
>> * Specify fs type when mounting partitions to prevent "Can't open blockdev" warnings [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v2.115.11
## (2023-06-21)


<details>
<summary> Update layers/meta-balena to 2d298dfd21cc69271a25642a74608ff39c9ca33f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.11
> ### (2023-06-21)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 09eff9c [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.27.6
>> #### (2023-06-19)
>> 
>> * Update balena-os/leviathan-worker to v2.9.7 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.27.5
>> #### (2023-06-19)
>> 
>> * tests: only do serial file read with testbot [rcooke-warwick]
>> * core: enable serial executeCommandinHostOS [rcooke-warwick]
>> 
>> ### leviathan-2.27.4
>> #### (2023-06-16)
>> 
>> * Update alpine Docker tag to v3.18.2 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.27.3
>> #### (2023-06-16)
>> 
>> * Update core/contracts digest to c777910 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.27.2
>> #### (2023-06-16)
>> 
>> * patch: Revert "minor: Add Leviathan Test Helpers" [Vipul Gupta]
>> 
>> ### leviathan-2.27.1
>> #### (2023-06-09)
>> 
>> * Update Pin dependencies [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v2.115.10
## (2023-06-21)


<details>
<summary> Update layers/meta-balena to f420c91e38843f5cf9b3f68122ee8cb71f9f605f [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.10
> ### (2023-06-21)
> 
> * resin-init-flasher: Format encrypted partitions as LUKS2 [Michal Toman]
> 

</details>

# v2.115.9
## (2023-06-19)


<details>
<summary> Update layers/meta-balena to 4a9a1b6ce3abacf025fe01b5b4292be2f791c13b [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.9
> ### (2023-06-15)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.3 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.3
>> #### (2023-06-15)
>> 
>> * Update balena-io/deploy-to-balena-action to v0.27.0 [Self-hosted Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v2.115.8+rev2
## (2023-06-19)


<details>
<summary> Update balena-yocto-scripts to 91474e62b74d6390c285d1033b34f77092fe1824 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.32
> ### (2023-06-19)
> 
> * balena-deploy: Newer meta-balena do not create a kernel_source tarball [Alex Gonzalez]
> 

</details>

# v2.115.8+rev1
## (2023-06-14)


<details>
<summary> Update contracts to c777910763b2476da6648200ab00629755b24da2 [Self-hosted Renovate Bot] </summary>

> ## contracts-2.0.61
> ### (2023-06-14)
> 
> * hw/device-type: Update contract.json for iot-gate-imx8 [Alexandru Costache]
> 

</details>

# v2.115.8
## (2023-06-14)


<details>
<summary> Update layers/meta-balena to 9760ab707b5c48d9a67ccacee61eacb063e14ac0 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.8
> ### (2023-06-14)
> 
> * balena_check_crc: Add helper u-boot command for crc manipulation [Alexandru Costache]
> 

</details>

# v2.115.7
## (2023-06-09)


<details>
<summary> Update layers/meta-balena to d6546982c2e7777336a00b4d7e289cadc3efb714 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.7
> ### (2023-06-09)
> 
> * README: Add bootloader section [Alexandru Costache]
> 

</details>

# v2.115.6
## (2023-06-08)


<details>
<summary> Update layers/meta-balena to 92a2e312bc49b6c35402efc528b035a66d9969ef [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.6
> ### (2023-06-08)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 62e4099 [Self-hosted Renovate Bot] </summary>
> 
>> ### leviathan-2.27.0
>> #### (2023-05-29)
>> 
>> * Update alpine Docker tag to v3.18.0 [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.26.1
>> #### (2023-05-29)
>> 
>> * Update core/contracts digest to fd4af4e [Self-hosted Renovate Bot]
>> 
>> ### leviathan-2.26.0
>> #### (2023-05-29)
>> 
>> * Update balena-cli to v16.1.0 with arm64 binaries [Kyle Harding]
>> 
> 
> </details>
> 
> 

</details>

# v2.115.5
## (2023-06-08)


<details>
<summary> Update layers/meta-balena to 7c31e98312e50f7cc6380b00701c6ed8ff3da216 [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.5
> ### (2023-06-08)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.2 [Self-hosted Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.2
>> #### (2023-06-05)
>> 
>> * Handle Engine-host race condition for "always" and "unless-stopped" restart policy [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v2.115.4+rev1
## (2023-06-05)


<details>
<summary> Update balena-yocto-scripts to e9f9ef5b729ac01f0b8efe0a16187fbb00d0bf54 [Self-hosted Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.31
> ### (2023-06-05)
> 
> * balena-deploy: add a compressed licenses tarball to the deploy artifacts [Alex Gonzalez]
> 

</details>

# v2.115.4
## (2023-06-01)


<details>
<summary> Update layers/meta-balena to f06ec1fc32f6c5baa0c734eaf9e94ee88f7993bb [Self-hosted Renovate Bot] </summary>

> ## meta-balena-2.115.4
> ### (2023-06-01)
> 
> * docs: Make secure boot docs more detailed [Michal Toman]
> 

</details>

# v2.115.3+rev1
## (2023-05-31)

* Update balena-os/github-workflows to [Self-hosted Renovate Bot]

# v2.115.3
## (2023-05-29)


<details>
<summary> Update layers/meta-balena to 60cfd8a3761501274de5f189fd8d52dd75cfbe42 [Renovate Bot] </summary>

> ## meta-balena-2.115.3
> ### (2023-05-29)
> 
> * resin-init-flasher: check that commands exist before calling [Alex Gonzalez]
> 
> ## meta-balena-2.115.2
> ### (2023-05-28)
> 
> * os-helpers: do not fail build if API tests fail [Alex Gonzalez]
> 

</details>

# v2.115.1
## (2023-05-24)


<details>
<summary> Update layers/meta-balena to 5bf3a7b37f4e33264629144c9bf355b4d81c1dee [Renovate Bot] </summary>

> ## meta-balena-2.115.1
> ### (2023-05-17)
> 
> * tests: config: set both network options to false [rcooke-warwick]
> * tests: hup: use contract to configure network [rcooke-warwick]
> * tests: cloud: use contract to configure network [rcooke-warwick]
> * tests: os: use contract to configure network [rcooke-warwick]
> 

</details>

# v2.115.0+rev1
## (2023-05-23)


<details>
<summary> Update balena-yocto-scripts to f2a164e0acaaa66795d5f31af248f1743dd0ffb7 [Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.30
> ### (2023-05-23)
> 
> * generate_ami: opt-in secure boot when using signed images [Alex Gonzalez]
> * balena-generate-ami: comply with default AMI quotas [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.19.29
> ### (2023-05-19)
> 
> * balena-deploy: add secureBoot feature into contract [Alex Gonzalez]
> 

</details>

# v2.115.0
## (2023-05-12)


<details>
<summary> Update layers/meta-balena to e86e103292e67dda18ca243e46721e65cd89c577 [Renovate Bot] </summary>

> ## meta-balena-2.115.0
> ### (2023-05-12)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.11.1 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.11.1
>> #### (2023-05-11)
>> 
>> * Fix `sw.arch` typo when testing contracts [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.11.0
>> #### (2023-05-10)
>> 
>> * Add `arch.sw` to the valid container requirements [Felipe Lalanne]
>> * Allow using slug to validate hw.device-type contract [Felipe Lalanne]
>> * Simplify and move lib/contract.spec.ts to tests/unit [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.10.11
>> #### (2023-05-08)
>> 
>> * Add information about hdmi port 2 config vars [Felipe Lalanne]
>> * Update table formatting on configurations.md [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.25
## (2023-05-12)


<details>
<summary> Update layers/meta-balena to 39982e107a500e0ebdacfd0d5ae33576cf2e24b4 [Renovate Bot] </summary>

> ## meta-balena-2.114.25
> ### (2023-05-12)
> 
> * tests: hup: enable boot-switch skip [rcooke-warwick]
> * tests: cloud: enable boot-switch skip Commit body [rcooke-warwick]
> * tests: os: enable boot-switch skip [rcooke-warwick]
> 

</details>

# v2.114.24
## (2023-05-11)


<details>
<summary> Update layers/meta-balena to d0b1a5a80c691e752dd5b396ce7da995507dd619 [Renovate Bot] </summary>

> ## meta-balena-2.114.24
> ### (2023-05-11)
> 
> * resin-init-flasher: add more comments around efi/boot partition split [Michal Toman]
> * resin-init-flasher: reboot into signed flasher when provisioning secure boot [Michal Toman]
> * resin-init-flasher: Fill db EFI variable from esl file instead of auth [Michal Toman]
> 

</details>

# v2.114.23+rev3
## (2023-05-09)

* tegra-binaries: Add Orin NX boot file for 35.2.1 [Alexandru Costache]

# v2.114.23+rev2
## (2023-05-08)

* balena-image: Use simplified boot files recipe [Alexandru Costache]

# v2.114.23+rev1
## (2023-05-08)

* edk2-firmware-tegra: Update all uefi integration patches to L4T 35.2.1 [Alexandru Costache]

# v2.114.23
## (2023-05-06)


<details>
<summary> Update layers/meta-balena to 3f2f215e39c39fc3ef227db665c99fb8ad77ee08 [Renovate Bot] </summary>

> ## meta-balena-2.114.23
> ### (2023-05-06)
> 
> * tests: suites: remove default migration force configuration [Alex Gonzalez]
> * resin-init-flasher: avoid partition labels clashes [Alex Gonzalez]
> * initrdscripts: recovery: set adb default timeouts in minutes [Alex Gonzalez]
> * tests: move installerForceMigration suite configuration to balenaOS section [Alex Gonzalez]
> * tests: simplify accessing config.json data [Alex Gonzalez]
> 

</details>

# v2.114.22+rev1
## (2023-05-06)


<details>
<summary> Update balena-yocto-scripts to 57226ffa5abafc3001cb275ad6520895c938842a [Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.28
> ### (2023-05-06)
> 
> * jenkins_build: accept bitbake extra arguments [Alex Gonzalez]
> 

</details>

# v2.114.22
## (2023-05-05)


<details>
<summary> Update layers/meta-balena to ddaac0ccf50d22ac8d0ed6c73022edd40c68b58e [Renovate Bot] </summary>

> ## meta-balena-2.114.22
> ### (2023-05-05)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.36 [Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.36
>> #### (2023-05-04)
>> 
>> * Further improve resilience of image pulls [Leandro Motta Barros]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.21+rev1
## (2023-05-05)


<details>
<summary> Update contracts to fd4af4e5694608cc0c87d9bff2a5b27b2c5f2f39 [Renovate Bot] </summary>

> ## contracts-2.0.60
> ### (2023-05-04)
> 
> * Fix LED support for ISG-503 [Alexandru Costache]
> 

</details>

# v2.114.21
## (2023-05-05)


<details>
<summary> Update layers/meta-balena to 0f0fec2a68746d8616cc55a06cf636363786bdca [Renovate Bot] </summary>

> ## meta-balena-2.114.21
> ### (2023-05-05)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 256b844 [Renovate Bot] </summary>
> 
>> ### leviathan-2.25.6
>> #### (2023-05-04)
>> 
>> * suite: move installer configuration to balenaOS configuration section [Alex Gonzalez]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.20
## (2023-05-05)


<details>
<summary> Update layers/meta-balena to e2ce4a7a054624967941f4b96500b5bb79c36d1e [Renovate Bot] </summary>

> ## meta-balena-2.114.20
> ### (2023-05-04)
> 
> * Updated the CDS link [Ryan]
> 

</details>

# v2.114.19+rev1
## (2023-05-04)

* edk2-firmware-tegra: Fix dtb parsing for AGX Orin Devkit [Alexandru Costache]

# v2.114.19
## (2023-05-04)


<details>
<summary> Update layers/meta-balena to 35a34d76f441fe37ea3d2cbd911558973fdec30c [Renovate Bot] </summary>

> ## meta-balena-2.114.19
> ### (2023-05-04)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to e6180e9 [Renovate Bot] </summary>
> 
>> ### leviathan-2.25.5
>> #### (2023-05-03)
>> 
>> * Update core/contracts digest to 75cd5e9 [Renovate Bot]
>> 
>> ### leviathan-2.25.4
>> #### (2023-05-01)
>> 
>> * Update balena-os/leviathan-worker to v2.9.6 [Renovate Bot]
>> 
>> ### leviathan-2.25.3
>> #### (2023-05-01)
>> 
>> * Update core/contracts digest to 6c6ed28 [Renovate Bot]
>> 
>> ### leviathan-2.25.2
>> #### (2023-04-26)
>> 
>> * suite: add installerForceMigration configuration [Alex Gonzalez]
>> 
>> ### leviathan-2.25.1
>> #### (2023-04-25)
>> 
>> * Update balena-os/leviathan-worker to v2.9.4 [Renovate Bot]
>> 
>> ### leviathan-2.25.0
>> #### (2023-04-20)
>> 
>> * Update Node.js to v18.16.0 [Renovate Bot]
>> 
>> ### leviathan-2.24.5
>> #### (2023-04-20)
>> 
>> * Update alpine Docker tag to v3.17.3 [Renovate Bot]
>> 
>> ### leviathan-2.24.4
>> #### (2023-04-20)
>> 
>> * Update core/contracts digest to 777cd35 [Renovate Bot]
>> 
>> ### leviathan-2.24.3
>> #### (2023-04-17)
>> 
>> * Update balena-os/leviathan-worker to v2.9.2 [Renovate Bot]
>> 
>> ### leviathan-2.24.2
>> #### (2023-04-15)
>> 
>> * docker-compose-qemu: allow to configure internal disk [Alex Gonzalez]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.18
## (2023-05-03)


<details>
<summary> Update layers/meta-balena to 0d43fec5037b2b4be928647e9b626c62c794c6f0 [Renovate Bot] </summary>

> ## meta-balena-2.114.18
> ### (2023-05-03)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.10.10 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.10.10
>> #### (2023-05-03)
>> 
>> * mount-partitions.sh: Add support for encrypted partitions [Michal Toman]
>> 
>> ### balena-supervisor-14.10.9
>> #### (2023-05-03)
>> 
>> * Run test supervisor under a different service name [Kyle Harding]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.17+rev2
## (2023-05-03)

* tegra-binaries: switch to using a prebuilt bootimg [Alexandru Costache]
* hostapp-update-hooks: Disable xudc in the old dtbs [Alexandru Costache]
* recipes-core/images: Install dtc for the AGX Orin [Alexandru Costache]

# v2.114.17+rev1
## (2023-05-03)


<details>
<summary> Update contracts to 75cd5e9f19d49b8723b7e39033763ca698e1254f [Renovate Bot] </summary>

> ## contracts-2.0.59
> ### (2023-05-03)
> 
> * hw.device-type: Add revpi-connect-s [Obaid Ch]
> 

</details>

# v2.114.17
## (2023-05-03)


<details>
<summary> Update layers/meta-balena to fa0106adb36432f5538f908304e9967c827dcfd4 [Renovate Bot] </summary>

> ## meta-balena-2.114.17
> ### (2023-05-03)
> 
> * test: append installer configuration instead of replacing it [Alex Gonzalez]
> * test: os: use boolean for installer migration flag [Alex Gonzalez]
> 

</details>

# v2.114.16
## (2023-05-03)


<details>
<summary> Update layers/meta-balena to 43bf9f98db7de74bce36141f5e55c4dcffb7e060 [Renovate Bot] </summary>

> ## meta-balena-2.114.16
> ### (2023-05-02)
> 
> * initrdscripts: give the root device a chance to come up before cryptsetup [Michal Toman]
> 

</details>

# v2.114.15+rev2
## (2023-05-01)

* hostapp-update-hooks: Fix potential crash in old 35.1.0 on altboot [Alexandru Costache]

# v2.114.15+rev1
## (2023-04-30)

* Update boot partition bind diff for AGX Orin Devkit 32GB [Alexandru Costache]

# v2.114.15
## (2023-04-28)


<details>
<summary> Update layers/meta-balena to 6dea3e6c37f789704d95485ed1ddab2b63226111 [Renovate Bot] </summary>

> ## meta-balena-2.114.15
> ### (2023-04-28)
> 
> * patch: Add additional logs when logging in using balenaSDK [Vipul Gupta (@vipulgupta2048)]
> 

</details>

# v2.114.14
## (2023-04-27)


<details>
<summary> Update layers/meta-balena to e610a1f7d15aaf3795b335e0773680561bee054b [Renovate Bot] </summary>

> ## meta-balena-2.114.14
> ### (2023-04-27)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.10.8 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.10.8
>> #### (2023-04-26)
>> 
>> * Fix service comparison when creating component steps [Felipe Lalanne]
>> * Create tests with recovery from #1576 [Felipe Lalanne]
>> * Skip updateMetadata step if there are network changes [Felipe Lalanne]
>> * Add replication of issue using unit tests [Felipe Lalanne]
>> * Add integration tests for state-engine [Felipe Lalanne]
>> * Do not pass auth to images with no registry [Felipe Lalanne]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.114.13
> ### (2023-04-27)
> 
> * hostapp-update-hooks: use unsafe fatrw copy for bootfiles [Alex Gonzalez]
> * balena-config-vars: introduce unsafe fatrw copy [Alex Gonzalez]
> 

</details>

# v2.114.12+rev2
## (2023-04-27)


<details>
<summary> Update contracts to 6c6ed28d459bc48102a69cdf0850d2eb4c778ce7 [Renovate Bot] </summary>

> ## contracts-2.0.58
> ### (2023-04-27)
> 
> * jetson-agx-orin-devkit: Mention the RAM configuration in the device name [Alexandru Costache]
> 

</details>

# v2.114.12+rev1
## (2023-04-26)

* tegra234-flash-dry: Update AGX Orin boot bindiff for L4T 35.2.1 [Alexandru Costache]

# v2.114.12
## (2023-04-26)


<details>
<summary> Update layers/meta-balena to 0396b07b2119b2c1a3cdf2bbd107e08de2110671 [Renovate Bot] </summary>

> ## meta-balena-2.114.12
> ### (2023-04-26)
> 
> * classes: kernel-balena: force recompilation if signing variables change [Alex Gonzalez]
> * balena-keys: make tasks depends on signing variables [Alex Gonzalez]
> * classes: sign: make signing task depends on signing variables [Alex Gonzalez]
> 

</details>

# v2.114.11
## (2023-04-25)

* recipes-bsp/tegra-binaries: Update AGX Orin Devkit to L4T 35.2.1 [Alexandru Costache]
* Update layers/meta-balena to 945c6af54ac4f637418ec812747e4fe4e43e8844 [Renovate Bot]

# v2.114.10
## (2023-04-24)


<details>
<summary> Update layers/meta-balena to 6f38c16dea7e006ee20b90a089574505fbce4a25 [Renovate Bot] </summary>

> ## meta-balena-2.114.10
> ### (2023-04-24)
> 
> * mkfs-hostapp-native: Update base image in Dockerfile [Alexandru Costache]
> 

</details>

# v2.114.9
## (2023-04-22)


<details>
<summary> Update layers/meta-balena to e2663a747325b2cb71476fde889244ad424ec8a4 [Renovate Bot] </summary>

> ## meta-balena-2.114.9
> ### (2023-04-22)
> 
> * tests: os: configure to use installer's migrator [Alex Gonzalez]
> * test: os: add installer migration test [Alex Gonzalez]
> 

</details>

# v2.114.8
## (2023-04-22)


<details>
<summary> Update layers/meta-balena to f7fe9a9bb773aa19cee244ab6f1b275ff182d40d [Renovate Bot] </summary>

> ## meta-balena-2.114.8
> ### (2023-04-22)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.10.7 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.10.7
>> #### (2023-04-21)
>> 
>> * Remove safeStateClone function [Felipe Lalanne]
>> * Get rid of targetVolatile in app manager [Felipe Lalanne]
>> * Make pausingApply a private member of device-state [Felipe Lalanne]
>> * Simplify doRestart and doPurge actions [Felipe Lalanne]
>> * Fix network appUuid inference in local mode [Felipe Lalanne]
>> * Get image name from DB when getting the app current state [Felipe Lalanne]
>> * Improve net alias comparison to prevent unwanted restarts [Felipe Lalanne]
>> * Exclude containerId from service network aliases [Felipe Lalanne]
>> * Skip image delete when applying intermediate state [Felipe Lalanne]
>> * Make local mode image management work as in cloud mode [Felipe Lalanne]
>> * Remove ignoreImages argument from getRequiredSteps [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.7+rev1
## (2023-04-22)


<details>
<summary> Update balena-yocto-scripts to 34c8434ffcaeeeb14853082bbf2b4ecc5e0ec769 [Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.27
> ### (2023-04-21)
> 
> * barys: fix removal of equals sign from argval [Joseph Kogut]
> 

</details>

# v2.114.7
## (2023-04-20)


<details>
<summary> Update layers/meta-balena to f2637a0d4cf774ed903613dd058ff9db037ad23e [Renovate Bot] </summary>

> ## meta-balena-2.114.7
> ### (2023-04-20)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.10.6 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.10.6
>> #### (2023-04-20)
>> 
>> * Do not restart balena-hostname on rename [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.10.5
>> #### (2023-04-13)
>> 
>> * Remove anonymous build volume from Dockerfile [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.6
## (2023-04-20)


<details>
<summary> Update layers/meta-balena to ac3e9193544d0bc3188473f725e3d88495caed75 [Renovate Bot] </summary>

> ## meta-balena-2.114.6
> ### (2023-04-20)
> 
> * Update db and dbx hashes during HUP when secure boot is enabled [Michal Toman]
> * balena-db-hashes: ship both db and dbx updates [Michal Toman]
> * Use hashes instead of certificates for secure boot image validation [Michal Toman]
> 

</details>

# v2.114.5
## (2023-04-19)


<details>
<summary> Update layers/meta-balena to cca4a5e7e9523bbe5892af3846ff8b3f03d6c749 [Renovate Bot] </summary>

> ## meta-balena-2.114.5
> ### (2023-04-19)
> 
> * Ship separate GRUB images for secure boot [Michal Toman]
> 

</details>

# v2.114.4
## (2023-04-18)


<details>
<summary> Update layers/meta-balena to 1264f58c432b7d87523a59ff27e246c2d6a3f903 [Renovate Bot] </summary>

> ## meta-balena-2.114.4
> ### (2023-04-18)
> 
> * initedscripts: recovery: do not use strings for timeout [Alex Gonzalez]
> * resin-init-flasher: limit boot device identification to booting disk [Alex Gonzalez]
> * resin-init-flasher: add verbose copy of migration log [Alex Gonzalez]
> * resin-init-flasher: fix EFI installation for multiple disks [Alex Gonzalez]
> * initrdscripts: migrate: correctly identify boot device [Alex Gonzalez]
> * distro: balena-os: update GRUB key id for signature [Alex Gonzalez]
> 

</details>

# v2.114.3+rev1
## (2023-04-12)


<details>
<summary> Update balena-yocto-scripts to 66e817cc08c391f06d0cf16dded7e6cf2082d0ca [Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.26
> ### (2023-04-12)
> 
> * balena-lib: Do not return error if no balena user token is available [Alex Gonzalez]
> 

</details>

# v2.114.3
## (2023-04-12)


<details>
<summary> Update layers/meta-balena to 9197a215577fd82110fc3c0a863a25fa9ec3cfcc [Renovate Bot] </summary>

> ## meta-balena-2.114.3
> ### (2023-04-12)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.10.4 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.10.4
>> #### (2023-04-10)
>> 
>> * Log uncaught promise exceptions on the app entry [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.10.3
>> #### (2023-04-10)
>> 
>> * Fix assertion error in restart-service [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.2
## (2023-04-12)


<details>
<summary> Update layers/meta-balena to af7446b3723221a5dbaa6e979c57e305d481f2d3 [Renovate Bot] </summary>

> ## meta-balena-2.114.2
> ### (2023-04-12)
> 
> * tests: cloud: convert ssh tunneling to test [rcooke-warwick]
> * tests: hup: convert ssh tunneling to test [rcooke-warwick]
> * tests: os: convert ssh tunneling to test [rcooke-warwick]
> * tests: cloud: check engine+sv ok in suite [rcooke-warwick]
> * tests: os: check engine+sv ok in suite [rcooke-warwick]
> * tests:cloud: convert initial SSH attempt into test [rcooke-warwick]
> * tests: hup: convert initial SSH attempt into test [rcooke-warwick]
> * tests: os: convert initial SSH attempt into test [rcooke-warwick]
> 

</details>

# v2.114.1
## (2023-04-08)


<details>
<summary> Update layers/meta-balena to aa8a58d761c11e9ed875d78e74f6838cb4e2ff02 [Renovate Bot] </summary>

> ## meta-balena-2.114.1
> ### (2023-04-07)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.10.2 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.10.2
>> #### (2023-04-07)
>> 
>> * backends: Add Jetson Orin NX custom device-tree support [Alexandru Costache]
>> 
> 
> </details>
> 
> 

</details>

# v2.114.0+rev1
## (2023-04-07)


<details>
<summary> Update contracts to 777cd35ffb8bebb2a9d8a2ec6b88a45b2c937193 [Renovate Bot] </summary>

> ## contracts-2.0.57
> ### (2023-04-07)
> 
> * debian/ubuntu jetson-orin-nx-xavier-nx-devkit: Add distro configs [Alexandru Costache]
> * Orin NX: Update flashing steps [Alexandru Costache]
> 

</details>

# v2.114.0
## (2023-04-07)


<details>
<summary> Update layers/meta-balena to 3f0e4743516442227387bb9fc55d97fdf7d57a12 [Renovate Bot] </summary>

> ## meta-balena-2.114.0
> ### (2023-04-07)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.10.1 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.10.1
>> #### (2023-04-07)
>> 
>> * Use dbus-send to get current boot block device instead of fdisk [Christina Ying Wang]
>> 
>> ### balena-supervisor-14.10.0
>> #### (2023-03-28)
>> 
>> * Mount boot partition into container on Supervisor start [Christina Ying Wang]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.113.35
> ### (2023-04-05)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.34 [Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.34
>> #### (2023-04-05)
>> 
>> * Update librsync-go to v0.8.5, circbuf to v0.1.3 [Leandro Motta Barros]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.113.34
> ### (2023-04-04)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 5785e44 [Renovate Bot] </summary>
> 
>> ### leviathan-2.24.1
>> #### (2023-04-04)
>> 
>> * Deprecate worker release env var (again) [Kyle Harding]
>> 
>> ### leviathan-2.24.0
>> #### (2023-04-03)
>> 
>> * minor: Add Leviathan Test Helpers [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.23.6
>> #### (2023-04-01)
>> 
>> * patch: Output final-result in the end [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.23.5
>> #### (2023-04-01)
>> 
>> * update default worker version [rcooke-warwick]
>> 
>> ### leviathan-2.23.4
>> #### (2023-03-29)
>> 
>> * swtpm: store state in tmpfs [Joseph Kogut]
>> 
>> ### leviathan-2.23.3
>> #### (2023-03-29)
>> 
>> * Update core/contracts digest to fa51fae [Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

* layers/meta-balena: Update to v2.113.33 [Alexandru Costache]
* balena-image: Shrink partition sizes [Alexandru Costache]
* Update meta-balena submodule to v2.113.32 [Alexandru Costache]

# v2.113.33
## (2023-04-06)

* layers/meta-balena: Update to v2.113.33 [Alexandru Costache]

# v2.113.32+rev1
## (2023-04-06)

* balena-image: Shrink partition sizes [Alexandru Costache]

# v2.113.32
## (2023-04-04)

* Update meta-balena submodule to v2.113.32 [Alexandru Costache]

# v2.113.31+rev1
## (2023-04-04)

* Specify NVME as internal storage [Alexandru Costache]

# v2.113.31
## (2023-03-28)


<details>
<summary> Update layers/meta-balena to c06fe0336f8582acf95c0615c48deafd4bed2731 [Renovate Bot] </summary>

> ## meta-balena-2.113.31
> ### (2023-03-28)
> 
> * Don't create core dumps in containers by default [Leandro Motta Barros]
> * Make sure balenaEngine owns the container cgroups [Leandro Motta Barros]
> 

</details>

# v2.113.30
## (2023-03-28)


<details>
<summary> Update layers/meta-balena to 761194320a6d4ddbc16802ee615d9845c0318d3c [Renovate Bot] </summary>

> ## meta-balena-2.113.30
> ### (2023-03-27)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.33 [Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.33
>> #### (2023-03-27)
>> 
>> * Add integration tests for balena's "delta on load" [Leandro Motta Barros]
>> * Simplify and improve delta error handling [Leandro Motta Barros]
>> * Refactor the xfer portions of delta [Leandro Motta Barros]
>> * Refactor the distribution portions of delta [Leandro Motta Barros]
>> 
> 
> </details>
> 
> 

</details>

# v2.113.29
## (2023-03-27)


<details>
<summary> Update layers/meta-balena to 5841b817cd3a0f2ffc063e586b7ed215655afb1c [Renovate Bot] </summary>

> ## meta-balena-2.113.29
> ### (2023-03-27)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.9.8 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.9.8
>> #### (2023-03-27)
>> 
>> * Revert "Use multi-arch in dockerfile" [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v2.113.28
## (2023-03-27)


<details>
<summary> Update layers/meta-balena to 30a8878dc207e4b9a8654ee715d36440e8a1a5d0 [Renovate Bot] </summary>

> ## meta-balena-2.113.28
> ### (2023-03-27)
> 
> * README: modify migration documentation to match module [Alex Gonzalez]
> 

</details>

# v2.113.27
## (2023-03-24)


<details>
<summary> Update layers/meta-balena to ead4a8fb7c11d565ca2be168b2bf33a69f1bc7f6 [Renovate Bot] </summary>

> ## meta-balena-2.113.27
> ### (2023-03-24)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.9.7 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.9.7
>> #### (2023-03-23)
>> 
>> * Add missing log backend field assignment in logger init [Christina Ying Wang]
>> 
>> ### balena-supervisor-14.9.6
>> #### (2023-03-23)
>> 
>> * Update deploy-to-balena action to 0.26.2 [Felipe Lalanne]
>> * Use multi-arch in dockerfile [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.9.5
>> #### (2023-03-20)
>> 
>> * Use log endpoint subdomain if it exists in config.json [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v2.113.26
## (2023-03-24)


<details>
<summary> Update layers/meta-balena to 0e8423f4307efd9d85ee413981e95112242ff9d5 [Renovate Bot] </summary>

> ## meta-balena-2.113.26
> ### (2023-03-23)
> 
> 
> <details>
> <summary> Update balena-engine to v20.10.32 [Renovate Bot] </summary>
> 
>> ### balena-engine-20.10.32
>> #### (2023-03-21)
>> 
>> * Installer: Make the script POSIX-compliant [Leandro Motta Barros]
>> * Installer: Improve handling of su/sudo [Leandro Motta Barros]
>> * Installer: Improve checking for dependencies [Leandro Motta Barros]
>> * Installer: remove support for the 386 architecture [Leandro Motta Barros]
>> * Remove the installation script from docs/ [Leandro Motta Barros]
>> 
>> ### balena-engine-20.10.31
>> #### (2023-03-20)
>> 
>> * Remove references to deprecated build targets [Kyle Harding]
>> * Revert "Cross-build the dynbinary target" [Kyle Harding]
>> 
>> ### balena-engine-20.10.30
>> #### (2023-03-13)
>> 
>> * Fix typos in the masterclass docs [Leandro Motta Barros]
>> * patch: Migrate balenaEngine Debugging docs from masterclass [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### balena-engine-20.10.29
>> #### (2023-02-20)
>> 
>> * Rename test functions for better clarity [Leandro Motta Barros]
>> * Add test case for the delta image store [Leandro Motta Barros]
>> * Add dev-focused docs on some balenaEngine features [Leandro Motta Barros]
>> * Simplify test code by using new std lib function [Leandro Motta Barros]
>> * Set the delta image store, fix delta-based HUPs [Leandro Motta Barros]
>> 
>> ### balena-engine-20.10.28
>> #### (2023-02-20)
>> 
>> * Disable builds for linux/386 [Leandro Motta Barros]
>> 
>> ### balena-engine-20.10.27
>> #### (2023-02-07)
>> 
>> * Merge upstream v20.10.17 [Leandro Motta Barros]
>> 
> 
> </details>
> 
> 

</details>

# v2.113.25
## (2023-03-23)


<details>
<summary> Update layers/meta-balena to 71c0d9581c2d5285b91c66675317edbcbb7b8ef9 [Renovate Bot] </summary>

> ## meta-balena-2.113.25
> ### (2023-03-23)
> 
> * kernel-balena: Include NFS V2, V3 and V4 client and server modules [Alexandru Costache]
> 
> ## meta-balena-2.113.24
> ### (2023-03-22)
> 
> * dunfell+: remove obsolete systemd patch [Joseph Kogut]
> * plymouth: replace duplicated patches w/ shared drop-ins [Joseph Kogut]
> * systemd: mask systemd-getty-generator instead of patching [Joseph Kogut]
> * systemd: replace duplicated patch w/ shared drop-ins [Joseph Kogut]
> 
> ## meta-balena-2.113.23
> ### (2023-03-22)
> 
> * pyro/sumo: initrdscripts: fix migrate module for older Yocto versions [Alex Gonzalez]
> * networkmanager: do not update to latest version in sumo [Alex Gonzalez]
> 
> ## meta-balena-2.113.22
> ### (2023-03-21)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to ad4f908 [Renovate Bot] </summary>
> 
>> ### leviathan-2.23.1
>> #### (2023-03-14)
>> 
>> * compose: qemu: add FLASHER_SECUREBOOT var [Joseph Kogut]
>> * swtpm: fix abort on exit [Joseph Kogut]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.113.21
> ### (2023-03-20)
> 
> * tests: os: secureboot: add integrity checks [Joseph Kogut]
> * tests: configure flasher secure boot opt-in [Joseph Kogut]
> 
> ## meta-balena-2.113.20
> ### (2023-03-20)
> 
> * tests: os: disable unwrapping [Joseph Kogut]
> * tests: hup: disable unwrapping [Joseph Kogut]
> * tests: cloud: disable unwrapping [Joseph Kogut]
> 
> ## meta-balena-2.113.19
> ### (2023-03-20)
> 
> * resin-u-boot.bbclass: Default to u-boot Kconfig support [Florin Sarbu]
> 

</details>

# v2.113.18
## (2023-03-18)


<details>
<summary> Update layers/meta-balena to 47781bdd7184f17c83523e961c7039d50e5e8775 [Renovate Bot] </summary>

> ## meta-balena-2.113.18
> ### (2023-03-16)
> 
> * Enable CI for external contributions from forks [Kyle Harding]
> 
> ## meta-balena-2.113.17
> ### (2023-03-16)
> 
> * Removed links to hub [Ryan H]
> 
> ## meta-balena-2.113.16
> ### (2023-03-16)
> 
> * balena-image-flasher: Default image type to balenaos-img [Florin Sarbu]
> 
> ## meta-balena-2.113.15
> ### (2023-03-16)
> 
> * resin-u-boot.bbclass: Replace static patch resin-specific-env-integration-kconfig.patch [Florin Sarbu]
> 
> ## meta-balena-2.113.14
> ### (2023-03-15)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.9.4 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.9.4
>> #### (2023-03-13)
>> 
>> * Skip pin device step if release was deleted [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.9.3
>> #### (2023-03-10)
>> 
>> * Use single-arch in dockerfile [Felipe Lalanne]
>> 
>> ### balena-supervisor-14.9.2
>> #### (2023-03-02)
>> 
>> * Replace BALENA-FIREWALL rule in INPUT chain instead of flushing [Christina Ying Wang]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.113.13
> ### (2023-03-15)
> 
> * update-balena-supervisor: use API request helper [Alex Gonzalez]
> * os-helpers: add test for os-helpers-api [Alex Gonzalez]
> * os-helpers: add os-helpers-api [Alex Gonzalez]
> 
> ## meta-balena-2.113.12
> ### (2023-03-14)
> 
> * Remove a bad check in Internet connection sharing test [Zahari Petkov]
> 
> ## meta-balena-2.113.11
> ### (2023-03-14)
> 
> * peak: Ship signed module when signing is enabled [Michal Toman]
> 
> ## meta-balena-2.113.10
> ### (2023-03-09)
> 
> * patch: Add balenaOS debugging docs [Vipul Gupta (@vipulgupta2048)]
> 
> ## meta-balena-2.113.9
> ### (2023-03-09)
> 
> * flasher: fix installation when in user mode w/ sb disabled [Joseph Kogut]
> 
> ## meta-balena-2.113.8
> ### (2023-03-08)
> 
> * fix ip for dummy interface to avoid ip conflicts [rcooke-warwick]
> * tests: os: NetworkManager iptables rules test for Internet sharing [Zahari Petkov]
> 
> ## meta-balena-2.113.7
> ### (2023-03-07)
> 
> * conf: distro: balena-os: use lower case for signing key names [Alex Gonzalez]
> 
> ## meta-balena-2.113.6
> ### (2023-03-07)
> 
> * recipes-core/images: Ensure redsocks sample files are deployed [Alexandru Costache]
> 
> ## meta-balena-2.113.5
> ### (2023-03-07)
> 
> * image-balena.bbclass: deploy grub-conf before building the boot partition [Michal Toman]
> 
> ## meta-balena-2.113.4
> ### (2023-03-03)
> 
> * balena-keys: do not ship certificates in DER format [Michal Toman]
> 
> ## meta-balena-2.113.3
> ### (2023-03-02)
> 
> * balena-units-conf: launch os-config on config changes [Alex Gonzalez]
> 
> ## meta-balena-2.113.2
> ### (2023-03-02)
> 
> * Refer to balenaEngine by its full name [Leandro Motta Barros]
> 
> ## meta-balena-2.113.1
> ### (2023-02-28)
> 
> * os-helpers-fs: formatting and fixing lint warning [Alex Gonzalez]
> * os-helpers-fs: fix check for media attached [Alex Gonzalez]
> * initrdscripts: migrate: use du instead of wc to calculate byte sizes [Alex Gonzalez]
> 
> ## meta-balena-2.113.0
> ### (2023-02-25)
> 
> * resin-init-flasher: use logging helper [Alex Gonzalez]
> * resin-init-flasher: replace shutdown for reboot in case of migration [Alex Gonzalez]
> * README: add installer section [Alex Gonzalez]
> * initrdscripts: Add migration module [Alex Gonzalez]
> * integration layers: use `android-tools` from Yocto Dunfell and before [Alex Gonzalez]
> * resin-init-flasher: comply with recovery mode [Alex Gonzalez]
> * initrdscritps: Move moving /run mountpoint from rootfs to migrate module [Alex Gonzalez]
> * initrdscripts: add recovery module [Alex Gonzalez]
> 
> ## meta-balena-2.112.15
> ### (2023-02-24)
> 
> * os-helpers-fs: add dependency on util-linux fdisk [Alex Gonzalez]
> 

</details>

# v2.112.14+rev5
## (2023-03-18)

* remove recovery module from balena-image-initramfs [Alexandru Costache]

# v2.112.14+rev4
## (2023-03-17)


<details>
<summary> Update contracts to 0ff4f419b4467349d7cb1d1202b580004067664c [Renovate Bot] </summary>

> ## contracts-2.0.54
> ### (2023-03-16)
> 
> * patch: Remove CircleCI in favor of Flowzone [Vipul Gupta (@vipulgupta2048)]
> 
> ## contracts-2.0.53
> ### (2023-03-16)
> 
> * patch: Fix fluid tags for revpi-core-3 [Vipul Gupta (@vipulgupta2048)]
> 
> ## contracts-2.0.52
> ### (2023-03-16)
> 
> * patch: Fix punctuation in partials [Vipul Gupta (@vipulgupta2048)]
> * patch: Fix spelling of eMMC [Vipul Gupta (@vipulgupta2048)]
> * patch: Fix spelling of while [Vipul Gupta (@vipulgupta2048)]
> 

</details>

# v2.112.14+rev3
## (2023-03-16)

* Prevent duplicate CI workflow executions [Kyle Harding]

# v2.112.14+rev2
## (2023-03-16)


<details>
<summary> Update contracts to 40d6eaa3f0455babd1abcc1d11a6e6db60387797 [Renovate Bot] </summary>

> ## contracts-2.0.51
> ### (2023-02-24)
> 
> * node: do not set unsafe-perm with npm 9 and newer [Michal Toman]
> 

</details>

# v2.112.14+rev1
## (2023-03-15)


<details>
<summary> Update balena-yocto-scripts to 93f94ff88593966c1f417861b235e729d5192ba6 [Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.25
> ### (2023-03-01)
> 
> * Dockerfile: yocto-build-env: update balenaCLI to 14.5.15 [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.19.24
> ### (2023-02-28)
> 
> * balena-api: ignore quotes from API replies [Alex Gonzalez]
> 

</details>

* trigger deploy builds on multi-digit revisions too [Alex Gonzalez]

# v2.112.14
## (2023-02-22)


<details>
<summary> Update layers/meta-balena to 80ca81f9e4ec9d4b2e4d21bc1cf12bd59220be5a [Renovate Bot] </summary>

> ## meta-balena-2.112.14
> ### (2023-02-22)
> 
> * balena-config-vars: Remove dependency on fatrw [Alex Gonzalez]
> * balena-config-vars: split in two packages [Alex Gonzalez]
> * Add raid support based on machine features [Alex Gonzalez]
> * packagegroup-resin: add resin-device-progress dependency [Alex Gonzalez]
> * resin-init-flasher: remove device-register and device-progress dependencies [Alex Gonzalez]
> * resin-init-flasher: reduce dependencies [Alex Gonzalez]
> * os-helpers-fs: replace inform with info helper [Alex Gonzalez]
> * resin-init-flasher: Build time check on INTERNAL_DEVICE_KERNEL only for flasher device types [Alex Gonzalez]
> * resin-init-flasher: wait for the by-label links to be created [Alex Gonzalez]
> 

</details>

# v2.112.13+rev2
## (2023-02-22)


<details>
<summary> Update contracts to 7e5420c232e35b678f2138d9878f1d1fc921b1cf [Renovate Bot] </summary>

> ## contracts-2.0.50
> ### (2023-02-22)
> 
> * hw.device-type: Rename radxaFlash protocol to usbMassStorage [Alexandru Costache]
> 

</details>

# v2.112.13+rev1
## (2023-02-22)


<details>
<summary> Update contracts to 6acab7c69f61f6660fe5fa41ccfd617281442fb3 [Renovate Bot] </summary>

> ## contracts-2.0.49
> ### (2023-02-22)
> 
> * patch: Fix spelling for eMMC in Radxa-zero contract [Vipul Gupta (@vipulgupta2048)]
> 
> ## contracts-2.0.48
> ### (2023-02-22)
> 
> * hw.device-type: Various fixes [Alexandru Costache]
> 

</details>

# v2.112.13
## (2023-02-22)


<details>
<summary> Update layers/meta-balena to f6327ce662208faa11b250b47518a5f01679dd25 [Renovate Bot] </summary>

> ## meta-balena-2.112.13
> ### (2023-02-22)
> 
> * recipes-bsp/u-boot: Disable saveenv shell command [Alexandru Costache]
> * Update tests/leviathan digest to 771bac8 [Renovate Bot]
> 

</details>

# v2.112.12+rev1
## (2023-02-21)


<details>
<summary> Update contracts to f32bce95ef31a6890812fbcf8f403a3ac2df95fd [Renovate Bot] </summary>

> ## contracts-2.0.47
> ### (2023-02-21)
> 
> * patch: Add docs to contracts for instructions partials [Vipul Gupta (@vipulgupta2048)]
> 

</details>

# v2.112.12
## (2023-02-21)


<details>
<summary> Update layers/meta-balena to 2e4f0c9530e0c8ea71b52a6e6a4f12fd01f1643b [Renovate Bot] </summary>

> ## meta-balena-2.112.12
> ### (2023-02-20)
> 
> * os-helpers-fs: get_internal_device() skip disks w/out media [Joseph Kogut]
> 

</details>

# v2.112.11
## (2023-02-20)


<details>
<summary> Update layers/meta-balena to d21da1fc034f4e0b09a457d0ed5eda47d0a18e13 [Renovate Bot] </summary>

> ## meta-balena-2.112.11
> ### (2023-02-20)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 84c2b96 [Renovate Bot] </summary>
> 
>> ### leviathan-2.22.0
>> #### (2023-02-20)
>> 
>> * Update core/contracts digest to 93ba80c [Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v2.112.10+rev1
## (2023-02-20)


<details>
<summary> Update contracts to 93ba80ca1ffeced474d0567cc58703cdbeb629d5 [Renovate Bot] </summary>

> ## contracts-2.0.46
> ### (2023-02-20)
> 
> * <owa5X logo> Updated owa5X logo. [Alvaro Guzman]
> 

</details>

# v2.112.10
## (2023-02-20)


<details>
<summary> Update layers/meta-balena to c7ef4ad6fe401699d0c24960ab27a8d10511697f [Renovate Bot] </summary>

> ## meta-balena-2.112.10
> ### (2023-02-20)
> 
> * tests: os: secureboot: skip if system is not locked down [Joseph Kogut]
> 
> ## meta-balena-2.112.9
> ### (2023-02-20)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 8a7bdcc [Renovate Bot] </summary>
> 
>> ### leviathan-2.21.0
>> #### (2023-02-20)
>> 
>> * Update core/contracts digest to 103037c [Renovate Bot]
>> 
>> ### leviathan-2.20.1
>> #### (2023-02-20)
>> 
>> * client: throw errors instead of blanket handling [Joseph Kogut]
>> 
> 
> </details>
> 
> 

</details>

# v2.112.8
## (2023-02-18)


<details>
<summary> Update contracts to 103037ca9624070c01ed388e8fd425bef609e924 [Renovate Bot] </summary>

> ## contracts-2.0.45
> ### (2023-02-18)
> 
> * Add node v19.6.1 v18.14.1 v16.19.1 and v14.21.3 [Trong Nghia Nguyen]
> 

</details>

* Update layers/meta-balena to 70d37200e8af95b6a784ead0682708c7e7f3acfb [Renovate Bot]

# v2.112.7
## (2023-02-16)


<details>
<summary> Update layers/meta-balena to 9fdf1011b4061ed579c71dfb58f22a97f904a50b [Renovate Bot] </summary>

> ## meta-balena-2.112.7
> ### (2023-02-16)
> 
> * renovate: Only consider github releases when bumping engine [Kyle Harding]
> 

</details>

# v2.112.6
## (2023-02-16)


<details>
<summary> Update layers/meta-balena to fd42070393600c11ae162b35f126b2632c3bb694 [Renovate Bot] </summary>

> ## meta-balena-2.112.6
> ### (2023-02-16)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 92cb71a [Renovate Bot] </summary>
> 
>> ### leviathan-2.20.0
>> #### (2023-02-16)
>> 
>> * Update core/contracts digest to 9b8811f [Renovate Bot]
>> 
>> ### leviathan-2.19.2
>> #### (2023-02-15)
>> 
>> * patch: Improve Getting Started instructions [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v2.112.5
## (2023-02-16)


<details>
<summary> Update layers/meta-balena to beb261875db907bcfa9ad8604100860c362d9ebe [Renovate Bot] </summary>

> ## meta-balena-2.112.5
> ### (2023-02-16)
> 
> * grub: Add chain module to support multiboot [Alex Gonzalez]
> 

</details>

# v2.112.4+rev1
## (2023-02-16)


<details>
<summary> Update contracts to 9b8811faee63c0884f367537d3411a8d70f0fcd0 [Renovate Bot] </summary>

> ## contracts-2.0.44
> ### (2023-02-16)
> 
> * Add Golang v1.20.1 and v1.19.6 [Trong Nghia Nguyen]
> 

</details>

# v2.112.4
## (2023-02-15)


<details>
<summary> Update layers/meta-balena to e9e5601e6bb0c4ee4ab51094714f88ce074b4b09 [Renovate Bot] </summary>

> ## meta-balena-2.112.4
> ### (2023-02-15)
> 
> * Update backports with current 2.102.x [BalenaCI github workflow]
> 
> ## meta-balena-2.112.3
> ### (2023-02-15)
> 
> * workflows: update-backports: remove skipping tests [Alex Gonzalez]
> 
> ## meta-balena-2.112.2
> ### (2023-02-15)
> 
> * workflows: add update-backports [Alex Gonzalez]
> 

</details>

# v2.112.1
## (2023-02-15)


<details>
<summary> Update layers/meta-balena to dcef4ce75f4f77bdcf941d0c095487bc4bc128f4 [Renovate Bot] </summary>

> ## meta-balena-2.112.1
> ### (2023-02-15)
> 
> * Update aufs5 kernel patches for 5.10 versions [Florin Sarbu]
> 

</details>

# v2.112.0
## (2023-02-14)


<details>
<summary> Update layers/meta-balena to 7cc56305880ded60850c3440840dcdba823bd179 [Renovate Bot] </summary>

> ## meta-balena-2.112.0
> ### (2023-02-14)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.9.0 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.9.0
>> #### (2023-02-14)
>> 
>> * Find and remove duplicate networks [Felipe Lalanne]
>> * Reference networks by Id instead of by name [Felipe Lalanne]
>> 
> 
> </details>
> 
> 

</details>

# v2.111.4
## (2023-02-14)


<details>
<summary> Update layers/meta-balena to b48ce7abc1eb2506eb81ebbb18a1c4b90e55c4d4 [Renovate Bot] </summary>

> ## meta-balena-2.111.4
> ### (2023-02-14)
> 
> * tests: hup: fix flashing for tx2 [rcooke-warwick]
> 

</details>

# v2.111.3
## (2023-02-14)


<details>
<summary> Update layers/meta-balena to a1621d4de1730a4f943f758b7fd7896d870ef9f7 [Renovate Bot] </summary>

> ## meta-balena-2.111.3
> ### (2023-02-14)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 975e8ca [Renovate Bot] </summary>
> 
>> ### leviathan-2.19.1
>> #### (2023-02-14)
>> 
>> * docker-compose: qemu: remove dep on swtpm [Joseph Kogut]
>> 
> 
> </details>
> 
> 

</details>

# v2.111.2
## (2023-02-13)


<details>
<summary> Update layers/meta-balena to 3e652503831c517ed60bc838c250d2910f2de8fe [Renovate Bot] </summary>

> ## meta-balena-2.111.2
> ### (2023-02-13)
> 
> * docs: add section for sb/fde opt-in [Joseph Kogut]
> 

</details>

# v2.111.1
## (2023-02-13)


<details>
<summary> Update layers/meta-balena to ad77fa3dacfa32044deb80c2266e3c2d8e1e13dd [Renovate Bot] </summary>

> ## meta-balena-2.111.1
> ### (2023-02-13)
> 
> * resin-init-flasher: do not report progress if unprovisioned [Alex Gonzalez]
> * resin-init-flasher: check splash configuration exists before copying [Alex Gonzalez]
> * resin-init-flasher: Move configuration data definitions to config file [Alex Gonzalez]
> 

</details>

# v2.111.0
## (2023-02-11)


<details>
<summary> Update layers/meta-balena to 18d3baaee23803f2b15e45c1ce3b1446e7a87eb1 [Renovate Bot] </summary>

> ## meta-balena-2.111.0
> ### (2023-02-11)
> 
> 
> <details>
> <summary> Update balena-supervisor to v14.8.0 [Renovate Bot] </summary>
> 
>> ### balena-supervisor-14.8.0
>> #### (2023-02-10)
>> 
>> * Remove dependent devices content in codebase [Christina Ying Wang]
>> 
> 
> </details>
> 
> 

</details>

# v2.110.4
## (2023-02-10)


<details>
<summary> Update layers/meta-balena to 152fe5b0fde438279bf0bc05e8f51d2cafb28fc0 [Renovate Bot] </summary>

> ## meta-balena-2.110.4
> ### (2023-02-10)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 589449d [Renovate Bot] </summary>
> 
>> ### leviathan-2.19.0
>> #### (2023-02-10)
>> 
>> * Update core/contracts digest to 35f4223 [Renovate Bot]
>> 
> 
> </details>
> 
> 

</details>

# v2.110.3+rev3
## (2023-02-10)


<details>
<summary> Update contracts to 35f42232b2c24e9a43c4b0e171f9644b1b12a686 [Renovate Bot] </summary>

> ## contracts-2.0.43
> ### (2023-02-10)
> 
> * Add Fedora 37 (latest) and 38 [Trong Nghia Nguyen]
> * Add Python v3.11.2 and v3.10.10 [Trong Nghia Nguyen]
> 

</details>

# v2.110.3+rev2
## (2023-02-09)


<details>
<summary> Update contracts to 79998a238ca981b890dfb9206f50bde2d367ff7c [Renovate Bot] </summary>

> ## contracts-2.0.42
> ### (2023-02-06)
> 
> * Add golang v1.20 [Trong Nghia Nguyen]
> * Add node v19.6.0 and v18.14.0 [Trong Nghia Nguyen]
> 
> ## contracts-2.0.41
> ### (2023-02-01)
> 
> * Add support for latest dotnet releases v7 (7.0.102) and v6 (6.0.113) [Trong Nghia Nguyen]
> * Add node v19.5.0 [Trong Nghia Nguyen]
> 
> ## contracts-2.0.40
> ### (2023-01-18)
> 
> * Add golang v1.19.5 and v1.18.10 [Trong Nghia Nguyen]
> 
> ## contracts-2.0.39
> ### (2023-01-12)
> 
> * hw.device-type: Add Radxa CM3 on Raspberry Pi Compute Module 4 IO Board [Florin Sarbu]
> 

</details>

# v2.110.3+rev1
## (2023-02-09)


<details>
<summary> Update balena-yocto-scripts to fe6beafdcfa7406b20257cf67a6b74cd8f59142f [Renovate Bot] </summary>

> ## balena-yocto-scripts-1.19.23
> ### (2023-01-28)
> 
> * balena-generate-ami: increase import snapshot timeout [Alex Gonzalez]
> * balena-generate-ami: remove s3 temporary image if snapshot import times out [Alex Gonzalez]
> * balena-generate-ami: match instance type with image type [Alex Gonzalez]
> * balena-generate-ami: fix linter warnings [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.19.22
> ### (2023-01-25)
> 
> * balena-generate-ami: allow for staging deployments [Alex Gonzalez]
> * jenkins_generate_ami: allow for staging deployment [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.19.21
> ### (2023-01-19)
> 
> * balene-generate-ami: remove key name [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.19.20
> ### (2023-01-18)
> 
> * jenkins_generate_ami: default to pull cloud-config apps from balena_os [Alex Gonzalez]
> 
> ## balena-yocto-scripts-1.19.19
> ### (2023-01-14)
> 
> * balena-generate-ami: do not remove AMI snapshot [Alex Gonzalez]
> * jenkins_generate_ami: use balena_os tokens instead of org specific token [Alex Gonzalez]
> * jenkins_build: respect the preserve build flag [Alex Gonzalez]
> * balena-generate-ami: cleanup images after deployment [Alex Gonzalez]
> * balena-generate-ami: test image before making it public [Alex Gonzalez]
> 

</details>

# v2.110.3
## (2023-02-09)


<details>
<summary> Update layers/meta-balena to 2c4c90350f1748a5b8d11441d84023c65069f01d [Renovate Bot] </summary>

> ## meta-balena-2.110.3
> ### (2023-02-09)
> 
> * os-helpers: remove shebangs as these are not meant to be executed [Alex Gonzalez]
> * resindataexpander: Fix formatting [Alex Gonzalez]
> * resin-init-flasher: Extract code that resolved internal device [Alex Gonzalez]
> * os-helpers-fs: Add shared code from resin-init-flasher [Alex Gonzalez]
> * resin-init-flasher: remove unused variable [Alex Gonzalez]
> * resin-init-flasher: Use the default for the external boot partition mount [Alex Gonzalez]
> * resin-init-flasher: search for images to copy instead of hardcoding paths [Alex Gonzalez]
> * resin-init-flasher: Do not  hardcode the path to the internal boot device [Alex Gonzalez]
> * resin-init-flasher: remove systemd dependency [Alex Gonzalez]
> * resin-init-flasher: Do not hardcode path to the raw image [Alex Gonzalez]
> * initrdscript: prepare: expose path to initramfs logs [Alex Gonzalez]
> * initrdscript: resindataexpander: skip for flasher images [Alex Gonzalez]
> * docs: add initramfs overview [Alex Gonzalez]
> 

</details>

# v2.110.2
## (2023-02-08)


<details>
<summary> Update layers/meta-balena to c005b8bf80326b05d3e7605bdcfda43433232679 [Renovate Bot] </summary>

> ## meta-balena-2.110.2
> ### (2023-02-07)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 4f63a2d [Renovate Bot] </summary>
> 
>> ### leviathan-2.18.1
>> #### (2023-02-07)
>> 
>> * patch: Automate docs deployment with Flowzone [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.18.0
>> #### (2023-02-07)
>> 
>> * Update core/contracts digest to 7797750 [Renovate Bot]
>> 
>> ### leviathan-2.17.6
>> #### (2023-02-07)
>> 
>> * patch: Update client lockfile [Vipul Gupta (@vipulgupta2048)]
>> * patch: Update core lockfile [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.17.5
>> #### (2023-02-06)
>> 
>> * patch: Update core dependencies [Vipul Gupta (@vipulgupta2048)]
>> 
> 
> </details>
> 
> 

</details>

# v2.110.1
## (2023-02-07)


<details>
<summary> Update layers/meta-balena to 22f6f33279e7d152dec60de927371312093396cd [Renovate Bot] </summary>

> ## meta-balena-2.110.1
> ### (2023-02-07)
> 
> * renovate: Include to and from versions for supervisor and engine [Kyle Harding]
> 
> ## meta-balena-2.110.0
> ### (2023-02-07)
> 
> * Update balena-supervisor to v14.7.1 [Renovate Bot]
> 

</details>

# v2.109.2
## (2023-02-07)


<details>
<summary> Update layers/meta-balena to 4cffdcd9cff0a3a7573811e98f15f44124a00ac0 [Renovate Bot] </summary>

> ## meta-balena-2.109.2
> ### (2023-02-07)
> 
> * efitools: backport patch to fix build failure [Joseph Kogut]
> * efitools: fix cross-compilation on arm [Joseph Kogut]
> * Only include EFI tools if the machine feature is defined [Alex Gonzalez]
> 
> ## meta-balena-2.109.1
> ### (2023-02-06)
> 
> * resin-extra-udev-rules: Remove after all device types have been updated [Alex Gonzalez]
> 
> ## meta-balena-2.109.0
> ### (2023-02-05)
> 
> * kernel-balena: Remove apparmor support [Alex Gonzalez]
> 
> ## meta-balena-2.108.39
> ### (2023-02-03)
> 
> * flasher: handle user mode system w/out secure boot [Joseph Kogut]
> * flasher: fix keys not enrolling with secure boot enabled [Joseph Kogut]
> * flasher: fix secure boot setup with enrolled keys [Joseph Kogut]
> 
> ## meta-balena-2.108.38
> ### (2023-02-03)
> 
> 
> <details>
> <summary> Update leviathan to v2.17.4 [Kyle Harding] </summary>
> 
>> ### leviathan-2.17.4
>> #### (2023-01-28)
>> 
>> * patch: Upgrade client to v18 [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.17.3
>> #### (2023-01-26)
>> 
>> * patch: Update client dependencies [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.17.2
>> #### (2023-01-19)
>> 
>> * chore(deps): update alpine docker tag to v3.17.1 [renovate[bot]]
>> 
>> ### leviathan-2.17.1
>> #### (2023-01-19)
>> 
>> * patch: Convert balenaCloudInteractor to JS [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.17.0
>> #### (2023-01-19)
>> 
>> * chore(deps): update dependency json5 [security] [renovate[bot]]
>> 
>> ### leviathan-2.16.1
>> #### (2023-01-19)
>> 
>> * split swtpm service into separate compose file [Joseph Kogut]
>> 
>> ### leviathan-2.16.0
>> #### (2023-01-18)
>> 
>> * chore(deps): update core/contracts digest to 8392bb2 [renovate[bot]]
>> 
>> ### leviathan-2.15.1
>> #### (2023-01-17)
>> 
>> * patch: Drop config NPM package [Vipul Gupta (@vipulgupta2048)]
>> 
>> ### leviathan-2.15.0
>> #### (2023-01-14)
>> 
>> * chore(deps): update dependency ansi-regex [security] [renovate[bot]]
>> 
>> ### leviathan-2.14.9
>> #### (2023-01-05)
>> 
>> * compose: qemu: add swtpm service [Joseph Kogut]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.108.37
> ### (2023-02-02)
> 
> * Update balena-engine to v20.10.26 [Renovate Bot]
> 
> ## meta-balena-2.108.36
> ### (2023-02-02)
> 
> * flasher: remove duplicate EFI boot entries [Joseph Kogut]
> * flasher: create EFI boot entry [Joseph Kogut]
> * common: os-helpers-fs: fix get_dev_path_from_label w/ luks [Joseph Kogut]
> * flasher: make secure boot opt-in [Joseph Kogut]
> * flasher: ensure image is signed before enrollment [Joseph Kogut]
> * flasher: refactor secure boot block [Joseph Kogut]
> 
> ## meta-balena-2.108.35
> ### (2023-02-01)
> 
> * renovate: Add regex manager for balena-engine [Kyle Harding]
> 
> ## meta-balena-2.108.34
> ### (2023-02-01)
> 
> * docs: Add secure boot and disk encryption overview [Alex Gonzalez]
> * hostapp-update-hooks: Fail if new keys are used [Alex Gonzalez]
> * resin-init-flasher: In setupmode program new keys [Alex Gonzalez]
> 
> ## meta-balena-2.108.33
> ### (2023-02-01)
> 
> * tests: os: skip persistent logging test for pi0 [rcooke-warwick]
> 

</details>

# v2.108.32
## (2023-01-31)


<details>
<summary> Update layers/meta-balena to ccab7759d432f7be780c194087c38eca7e02084d [Renovate Bot] </summary>

> ## meta-balena-2.108.32
> ### (2023-02-01)
> 
> * efitools: Allow builds for ARM architecture [Alex Gonzalez]
> 

</details>

# v2.108.31
## (2023-01-31)


<details>
<summary> Update layers/meta-balena to c3560cf861dbd8505adecd0e12b280c85a0eac88 [Renovate Bot] </summary>

> ## meta-balena-2.108.31
> ### (2023-02-01)
> 
> * rollback-health: bind-mount EFI partition when split from boot [Michal Toman]
> 

</details>

# v2.108.30
## (2023-01-30)


<details>
<summary> Update layers/meta-balena to e7ea08bd6459cb8a0c0c59b61ef3a46caaeaaa68 [Renovate Bot] </summary>

> ## meta-balena-2.108.30
> ### (Invalid date)
> 
> * redsocks: Deploy README and sample configration file [Alexandru Costache]
> * recipes-bsp/u-boot: Import extra uboot environment from scanned devices [Alexandru Costache]
> 

</details>

# v2.108.29
## (2023-01-28)


<details>
<summary> Update layers/meta-balena to bdfe242725e83784931987d85f83a35e861683d8 [Renovate Bot] </summary>

> ## meta-balena-2.108.29
> ### (2023-01-28)
> 
> * bluez: Update to v5.66 [Alex Gonzalez]
> 

</details>


<details>
<summary> Update layers/meta-balena to 00324bf0a842b63ee46b24ab5a19bff68d4b3799 [Renovate Bot] </summary>

> ## meta-balena-2.108.29
> ### (2023-01-28)
> 
> * bluez: Update to v5.66 [Alex Gonzalez]
> 

</details>

# v2.108.27+rev1
## (2023-01-26)

* add meta-perl to bblayers.conf [Alex Gonzalez]

# v2.108.27
## (2023-01-23)


<details>
<summary> Update layers/meta-balena to 73bc1884cad100723ee16dd08c1abd5796260cc2 [renovate[bot]] </summary>

> ## meta-balena-2.108.27
> ### (2023-01-20)
> 
> * tests: os: fix tests that use glider on rpi0 [rcooke-warwick]
> 
> ## meta-balena-2.108.26
> ### (2023-01-20)
> 
> * Enable back connectivity check in NetworkManager [Zahari Petkov]
> 
> ## meta-balena-2.108.25
> ### (2023-01-18)
> 
> * tests: os: add basic SB/FDE tests [Joseph Kogut]
> 
> ## meta-balena-2.108.24
> ### (2023-01-18)
> 
> * networkmanager: Make iptables wait for xtables.lock [Zahari Petkov]
> 
> ## meta-balena-2.108.23
> ### (2023-01-16)
> 
> * balena-keys: rebuild if keys change [Alex Gonzalez]
> * classes: sign-*: resign if keys change [Alex Gonzalez]
> 
> ## meta-balena-2.108.22
> ### (2023-01-16)
> 
> * workflows: esr: use semver compatible versions [Alex Gonzalez]
> 
> ## meta-balena-2.108.21
> ### (2023-01-14)
> 
> * efitools: Package lock down EFI image into its own package [Alex Gonzalez]
> 
> ## meta-balena-2.108.20
> ### (2023-01-12)
> 
> * workflows: meta-balena-esr: Fix version calculation [Alex Gonzalez]
> 

</details>

# v2.108.19+rev2
## (2023-01-23)

* forecr-dsboard-nx2: Add coffee file and yocto machine [Alexandru Costache]

# v2.108.19+rev1
## (2023-01-12)

* Add ESR workflow [Alex Gonzalez]

# v2.108.19
## (2023-01-10)


<details>
<summary> Update layers/meta-balena to 707ed18ca071fb7d7d557e0774f9f479323892af [renovate[bot]] </summary>

> ## meta-balena-2.108.19
> ### (2023-01-10)
> 
> * redsocks: Increase maximum number of open files [Alex Gonzalez]
> 

</details>

# v2.108.18+rev1
## (2023-01-10)


<details>
<summary> Update balena-yocto-scripts to 56bb055d91481023a6b6cff92d61ebfffa884139 [renovate[bot]] </summary>

> ## balena-yocto-scripts-1.19.18
> ### (2023-01-09)
> 
> * balena-generate-ami: Enable TPM support on x86_64 only [Michal Toman]
> 

</details>

# v2.108.18
## (2023-01-10)


<details>
<summary> Update layers/meta-balena to 7b8d9a8b591487aefcdcd522d385ec14abaa1be6 [renovate[bot]] </summary>

> ## meta-balena-2.108.18
> ### (2023-01-09)
> 
> * Revert "flasher: output logs to serial console" [Joseph Kogut]
> 

</details>

# v2.108.17
## (2023-01-09)


<details>
<summary> Update layers/meta-balena to 8347887ab69018c1e4bcf0a7aecbf6faf85af2bd [renovate[bot]] </summary>

> ## meta-balena-2.108.17
> ### (2023-01-09)
> 
> * Update balena-os/balena-supervisor to v14.4.10 [renovate[bot]]
> 
> ## meta-balena-2.108.16
> ### (2023-01-09)
> 
> * balena-supervisor: Set the supervisor package version [Kyle Harding]
> 

</details>

# v2.108.15+rev2
## (2023-01-07)


<details>
<summary> Update contracts to cbc450a40296e716e50344b3d625fb9a9b6975f6 [renovate[bot]] </summary>

> ## contracts-2.0.38
> ### (2023-01-07)
> 
> * Forecr DSBOARD NX2 Xavier NX eMMC: Add community device-type [Alexandru Costache]
> 

</details>

# v2.108.15+rev1
## (2023-01-07)


<details>
<summary> Update contracts to d647331a48dfbc6d398139831054d41fa52f79da [renovate[bot]] </summary>

> ## contracts-2.0.37
> ### (2023-01-07)
> 
> * Add node v18.13.0 and v19.4.0 [Trong Nghia Nguyen]
> 

</details>

# v2.108.15
## (2023-01-05)


<details>
<summary> Update layers/meta-balena to b75d73b4811e1bc37546d0e2329b6acb758852da [renovate[bot]] </summary>

> ## meta-balena-2.108.15
> ### (2023-01-05)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to e23c1bb [renovate[bot]] </summary>
> 
>> ### leviathan-2.14.8
>> #### (2023-01-05)
>> 
>> * chore(deps): update dependency eslint-config-standard to 17.0.0 [renovate[bot]]
>> 
>> ### leviathan-2.14.7
>> #### (2023-01-05)
>> 
>> * worker: Deprecate the WORKER_RELEASE env var [Kyle Harding]
>> 
>> ### leviathan-2.14.6
>> #### (2023-01-05)
>> 
>> * e2e: Switch from rpi4 to rpi3 for e2e tests [Kyle Harding]
>> * core: Increase the default timeout for worker connections to 30s [Kyle Harding]
>> 
>> ### leviathan-2.14.5
>> #### (2023-01-04)
>> 
>> * renovate: Disable automerge for major and minor updates [Kyle Harding]
>> 
>> ### leviathan-2.14.4
>> #### (2023-01-04)
>> 
>> * chore(deps): update dependency typedoc to 0.23.23 [renovate[bot]]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.108.14
> ### (2023-01-04)
> 
> * tests: os: chrony: disable NTP w/ dnsmasq dbus API [Joseph Kogut]
> 

</details>

# v2.108.13
## (2023-01-04)


<details>
<summary> Update layers/meta-balena to 7aaa2abec902574d9e777a88464eda5be2810666 [renovate[bot]] </summary>

> ## meta-balena-2.108.13
> ### (2023-01-04)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 44dceb4 [renovate[bot]] </summary>
> 
>> ### leviathan-2.14.3
>> #### (2023-01-04)
>> 
>> * chore(deps): update dependency eslint to 8.31.0 [renovate[bot]]
>> 
> 
> </details>
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 4383482 [renovate[bot]] </summary>
> 
>> ### leviathan-2.14.3
>> #### (2023-01-04)
>> 
>> * chore(deps): update dependency eslint to 8.31.0 [renovate[bot]]
>> 
> 
> </details>
> 
> 

</details>

# v2.108.12
## (2023-01-04)


<details>
<summary> Update layers/meta-balena to 576d3f249fbab16bf93a4dd5d158bae6f2ad9f9b [renovate[bot]] </summary>

> ## meta-balena-2.108.12
> ### (2023-01-04)
> 
> * tests/hup: Avoid an old engine bug when pulling multiarch images on rpi [Kyle Harding]
> 

</details>

# v2.108.11
## (2023-01-04)


<details>
<summary> Update layers/meta-balena to df321d4ad4831d27188ac9bf538600ccaaabc9b3 [renovate[bot]] </summary>

> ## meta-balena-2.108.11
> ### (2023-01-03)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to d3485ab [renovate[bot]] </summary>
> 
>> ### leviathan-2.13.0
>> #### (2023-01-03)
>> 
>> * Revert "minor: Add @balena/leviathan-test-helpers package" [Kyle Harding]
>> 
>> ### leviathan-2.12.4
>> #### (Invalid date)
>> 
>> * chore(deps): update dependency eslint-plugin-standard to 4.1.0 [renovate[bot]]
>> 
> 
> </details>
> 
> 

</details>

# v2.108.10
## (2022-12-30)


<details>
<summary> Update layers/meta-balena to ef1c2dd3af72fcf8d9ac8b8df74caae0d59f4db3 [renovate[bot]] </summary>

> ## meta-balena-2.108.10
> ### (Invalid date)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 7d6326d [renovate[bot]] </summary>
> 
>> ### leviathan-2.12.3
>> #### (Invalid date)
>> 
>> * chore(deps): update dependency eslint-plugin-node to 11.1.0 [renovate[bot]]
>> 
>> ### leviathan-2.12.2
>> #### (2022-12-29)
>> 
>> * Run out-of-band e2e tests after Flowzone passes [Kyle Harding]
>> 
>> ### leviathan-2.12.1
>> #### (2022-12-29)
>> 
>> * chore(deps): update dependency eslint-plugin-jsdoc to 39.6.4 [renovate[bot]]
>> 
>> ### leviathan-2.12.0
>> #### (2022-12-29)
>> 
>> * chore(deps): update core/contracts digest to 4698e4e [renovate[bot]]
>> 
>> ### leviathan-2.11.9
>> #### (2022-12-29)
>> 
>> * chore(deps): update dependency balena-os/leviathan-worker to 2.6.13 [renovate[bot]]
>> 
> 
> </details>
> 
> 

</details>

# v2.108.9
## (2022-12-29)


<details>
<summary> Update layers/meta-balena to 95d8b0c5bfb36a164081f417b52c8de16f2dc474 [renovate[bot]] </summary>

> ## meta-balena-2.108.9
> ### (2022-12-29)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 1dcb432 [renovate[bot]] </summary>
> 
>> ### leviathan-2.11.8
>> #### (2022-12-28)
>> 
>> * chore(deps): update dependency eslint-config-prettier to 8.5.0 [renovate[bot]]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.108.8
> ### (2022-12-28)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to e09fae4 [renovate[bot]] </summary>
> 
>> ### leviathan-2.11.7
>> #### (2022-12-28)
>> 
>> * renovate: Remove v prefix from leviathan-worker github-tags [Kyle Harding]
>> 
> 
> </details>
> 
> 

</details>

# v2.108.7
## (2022-12-28)


<details>
<summary> Update layers/meta-balena to 68ec8ca1388c8e442acf1235dc573aeb12ff385a [renovate[bot]] </summary>

> ## meta-balena-2.108.7
> ### (2022-12-28)
> 
> * tests: os: fix modem test teardown [rcooke-warwick]
> 

</details>

# v2.108.6
## (2022-12-28)


<details>
<summary> Update layers/meta-balena to 3a45aa111217e64ef6ab8cbd16d34a12ece49a3c [renovate[bot]] </summary>

> ## meta-balena-2.108.6
> ### (2022-12-27)
> 
> * flasher: output logs to serial console [Joseph Kogut]
> 
> ## meta-balena-2.108.5
> ### (2022-12-21)
> 
> * Engine healthcheck: deal with empty uuid file [Leandro Motta Barros]
> 
> ## meta-balena-2.108.4
> ### (2022-12-20)
> 
> * distro: For OS development, enable serial console [Alex Gonzalez]
> 
> ## meta-balena-2.108.3
> ### (2022-12-20)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to f06d285 [renovate[bot]] </summary>
> 
>> ### leviathan-2.11.6
>> #### (2022-12-16)
>> 
>> * Fix renovate extends syntax to include balena-io config [Kyle Harding]
>> 
>> ### leviathan-2.11.5
>> #### (2022-12-16)
>> 
>> * renovate: Inherit settings from balena-io/renovate-config [Kyle Harding]
>> 
>> ### leviathan-2.11.4
>> #### (2022-12-16)
>> 
>> * add logging and timeout to balena push [rcooke-warwick]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.108.2
> ### (2022-12-19)
> 
> * Update balena-os/balena-supervisor to v14.4.9 [renovate[bot]]
> 
> ## meta-balena-2.108.1
> ### (2022-12-18)
> 
> * common: signing: improve debug output on failure [Joseph Kogut]
> 
> ## meta-balena-2.108.0
> ### (2022-12-16)
> 
> * Update NetworkManager to 1.40.4 [Zahari Petkov]
> 
> ## meta-balena-2.107.40
> ### (2022-12-16)
> 
> * Add upstream resolvconf 1.91 recipe for kirkstone [Zahari Petkov]
> 
> ## meta-balena-2.107.39
> ### (2022-12-16)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to f44bbbd [renovate[bot]] </summary>
> 
>> ### leviathan-2.11.3
>> #### (2022-12-16)
>> 
>> * Disable renovate config for now [Kyle Harding]
>> * Restore worker release env var [Kyle Harding]
>> 
>> ### leviathan-2.11.2
>> #### (2022-12-15)
>> 
>> * Update Node.js to v12.22.12 [Renovate Bot]
>> 
>> ### leviathan-2.11.1
>> #### (2022-12-15)
>> 
>> * Remove dependabot as renovate is enabled in balena-io/renovate-config [Kyle Harding]
>> * Pin worker to a release and add renovate regex template [Kyle Harding]
>> 
>> ### leviathan-2.11.0
>> #### (2022-12-15)
>> 
>> * Update core/contracts digest to 08f029b [Renovate Bot]
>> 
>> ### leviathan-2.10.12
>> #### (2022-12-15)
>> 
>> * Revert "Avoid conflicting docker subnets" [Vipul Gupta]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.107.38
> ### (2022-12-16)
> 
> * Update balena-os/balena-supervisor to v14.4.8 [renovate[bot]]
> 
> ## meta-balena-2.107.37
> ### (2022-12-15)
> 
> * tests: cloud: simplify apps to speedup suite [rcooke-warwick]
> 
> ## meta-balena-2.107.36
> ### (2022-12-15)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 48ffd13 [renovate[bot]] </summary>
> 
>> ### leviathan-2.10.11
>> #### (2022-12-14)
>> 
>> * Avoid conflicting docker networks [Kyle Harding]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.107.35
> ### (2022-12-15)
> 
> * patch: Add default debug object to test config [Vipul Gupta (@vipulgupta2048)]
> 
> ## meta-balena-2.107.34
> ### (2022-12-14)
> 
> * initrdscripts: Wait for udev processing to complete when unlocking LUKS devices [Michal Toman]
> 
> ## meta-balena-2.107.33
> ### (2022-12-14)
> 
> * tests: hup: clean up inactive partition pre hup [rcooke-warwick]
> 
> ## meta-balena-2.107.32
> ### (2022-12-14)
> 
> * tests/cloud: Increase the wait time for services to start [Kyle Harding]
> 
> ## meta-balena-2.107.31
> ### (2022-12-14)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 27b78a4 [renovate[bot]] </summary>
> 
>> ### leviathan-2.10.10
>> #### (2022-12-13)
>> 
>> * Enable external contributions via flowzone [Kyle Harding]
>> 
> 
> </details>
> 
> 
> ## meta-balena-2.107.30
> ### (2022-12-13)
> 
> * extra-udev-rules: Update teensy.rules [Alex Gonzalez]
> * extra-udev-rules: Rename recipe [Alex Gonzalez]
> 
> ## meta-balena-2.107.29
> ### (2022-12-13)
> 
> * balena-image-initramfs: disable redundant compression [Joseph Kogut]
> 
> ## meta-balena-2.107.28
> ### (2022-12-12)
> 
> * initrdscripts: Only unlock LUKS partitions on the OS drive [Michal Toman]
> 
> ## meta-balena-2.107.27
> ### (2022-12-12)
> 
> * chrony: disable reverse dns lookups in healthcheck [Ken Bannister]
> 

</details>

# v2.107.26+rev5
## (2022-12-23)


<details>
<summary> Update balena-yocto-scripts to 0f1d0265bbabdb2b869f6cf9363d418b52681ffc [renovate[bot]] </summary>

> ## balena-yocto-scripts-1.19.17
> ### (2022-12-23)
> 
> * jenkins_generate_ami: support using both live and installer images as AMIs [Alex Gonzalez]
> * balena-generate-ami: Enable nitroTPM support [Alex Gonzalez]
> * jenkins_build: add argument to build OS development images [Alex Gonzalez]
> 

</details>

# v2.107.26+rev4
## (2022-12-22)


<details>
<summary> Update contracts to 4698e4ef55fdc61aa3df8d8494f2cbbd306b26c9 [renovate[bot]] </summary>

> ## contracts-2.0.36
> ### (2022-12-22)
> 
> * Fix owa5x slug [Trong Nghia Nguyen]
> 

</details>

# v2.107.26+rev3
## (2022-12-20)


<details>
<summary> Update contracts to b65d5bd372587d4aaabba526d34f67c3f63ea90b [renovate[bot]] </summary>

> ## contracts-2.0.35
> ### (2022-12-20)
> 
> * hw.device-type: Add Owasys owa5X device [Alvaro Guzman]
> 

</details>

# v2.107.26+rev2
## (2022-12-16)


<details>
<summary> Update contracts to b6bdc537c9f9d224301152a0291682172320bf6a [renovate[bot]] </summary>

> ## contracts-2.0.34
> ### (2022-12-16)
> 
> * Flowzone: Allow external contributions [Florin Sarbu]
> 
> ## contracts-2.0.33
> ### (2022-12-16)
> 
> * Flowzone: Use inherited secrets [Florin Sarbu]
> 

</details>

* Update balena-yocto-scripts to 67cb61f9209482ddd22b3f98ebf6cb3609f0acb7 [renovate[bot]]

# v2.107.26+rev1
## (2022-12-15)


<details>
<summary> Update contracts to 08f029b5c82e71b9b25fbeef4805815bfa4c24aa [renovate[bot]] </summary>

> ## contracts-2.0.32
> ### (2022-12-15)
> 
> * Add node v19.3.0 v16.19.0 and v14.21.2 [Trong Nghia Nguyen]
> 

</details>

# v2.107.26
## (2022-12-12)


<details>
<summary> Update layers/meta-balena to d5e33e207a60caaf8fe6b83326cad8b6e94a47e5 [renovate[bot]] </summary>

> ## meta-balena-2.107.26
> ### (2022-12-12)
> 
> * connectivity: Add linux firmware for iwlwifi 9260 [Alex Gonzalez]
> 

</details>

# v2.107.25
## (2022-12-11)


<details>
<summary> Update layers/meta-balena to 1b077510cb474b222865c24677995d59687af06a [renovate[bot]] </summary>

> ## meta-balena-2.107.25
> ### (2022-12-11)
> 
> * image_types_balena: fix inconsistency with flasher image partition naming [Alex Gonzalez]
> 

</details>

# v2.107.24+rev1
## (2022-12-10)


<details>
<summary> Update contracts to 0357433005e9ea7ace7876530d910eeb8386c980 [renovate[bot]] </summary>

> ## contracts-2.0.31
> ### (2022-12-10)
> 
> * Add partials for dotnet v7 [Trong Nghia Nguyen]
> 

</details>

# v2.107.24
## (2022-12-10)


<details>
<summary> Update layers/meta-balena to 5cb3c1438d6959dc31e77851fb070143ef1a82a6 [renovate[bot]] </summary>

> ## meta-balena-2.107.24
> ### (2022-12-09)
> 
> * Update balena-os/balena-supervisor to v14.4.6 [renovate[bot]]
> 

</details>

# v2.107.23+rev1
## (2022-12-09)


<details>
<summary> Update contracts to 7038b0ce71daa96a832540d24fcad5bc5142ff13 [renovate[bot]] </summary>

> ## contracts-2.0.30
> ### (2022-12-09)
> 
> * Add support for Alpine Linux v3.17 [Trong Nghia Nguyen]
> * Add dotnet v7, update v6.x and v3.x to latest versions [Trong Nghia Nguyen]
> * Add Python v3.11.1 v3.10.9 v3.9.16 v3.8.16 and v3.7.16 [Trong Nghia Nguyen]
> * Add Golang v1.19.4 and v1.18.9 [Trong Nghia Nguyen]
> 

</details>

# v2.107.23
## (2022-12-09)


<details>
<summary> Update layers/meta-balena to 581e322552bf300bc136f2bc553558d020cc313c [renovate[bot]] </summary>

> ## meta-balena-2.107.23
> ### (2022-12-09)
> 
> * patch: Add product documentation [Vipul Gupta (@vipulgupta2048)]
> 

</details>

# v2.107.22
## (2022-12-09)


<details>
<summary> Update layers/meta-balena to 0b95d62f50f71a7aea94e383812cb8fcd0927b0b [renovate[bot]] </summary>

> ## meta-balena-2.107.22
> ### (2022-12-09)
> 
> * tests: os: fsck: make compatible with old yocto releaes [rcooke-warwick]
> 

</details>

# v2.107.21
## (2022-12-08)


<details>
<summary> Update layers/meta-balena to be29271a011eec9121d17db5be03824ff78163cd [renovate[bot]] </summary>

> ## meta-balena-2.107.21
> ### (2022-12-08)
> 
> * tests/connectivity: Run the proxy tests with the actual redsocks uid of the DUT [Florin Sarbu]
> 

</details>

# v2.107.20
## (2022-12-08)


<details>
<summary> Update layers/meta-balena to 867c3a93cf533c63fc57703d08f3b3d2af554746 [renovate[bot]] </summary>

> ## meta-balena-2.107.20
> ### (2022-12-07)
> 
> * kernel-balena: enable zstd compression [Joseph Kogut]
> 
> ## meta-balena-2.107.19
> ### (2022-12-06)
> 
> * image_types_balena: generate bmap file [Joseph Kogut]
> * flasher: write disk image skipping sparse blocks [Joseph Kogut]
> * image_types_balena: create sparse disk image [Joseph Kogut]
> 

</details>

# v2.107.18
## (2022-12-04)


<details>
<summary> Update layers/meta-balena to 1ca7d4bad4a759051bb8f30a284ed24070260790 [renovate[bot]] </summary>

> ## meta-balena-2.107.18
> ### (2022-12-04)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to fe4d6a1 [renovate[bot]] </summary>
> 
>> ### leviathan-2.10.9
>> #### (2022-12-02)
>> 
>> * Revert "docker-compose: stop using the default docker bridge" [Kyle Harding]
>> 
> </details>
> 
> 
> ## meta-balena-2.107.17
> ### (2022-12-02)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to de97fa2 [renovate[bot]] </summary>
> 
>> ### leviathan-2.10.8
>> #### (Invalid date)
>> 
>> * patch: Improve archivelogs journalctl command [Vipul Gupta (@vipulgupta2048)]
>> * core: Reduce to 30 the retries number when trying to get the IP address of the DUT [Florin Sarbu]
>> 
>> ### leviathan-2.10.7
>> #### (Invalid date)
>> 
>> * docker-compose: stop using the default docker bridge [Alex Gonzalez]
>> 
>> ### leviathan-2.10.6
>> #### (2022-11-29)
>> 
>> * os/balenaos: Remove hidden attribute from DUT wireless connection file [Alexandru Costache]
>> 
>> ### leviathan-2.10.5
>> #### (2022-11-29)
>> 
>> * patch: Add debug: unstable to docs [Vipul Gupta (@vipulgupta2048)]
>> 
> </details>
> 
> 
</details>

# v2.107.16
## (2022-12-02)


<details>
<summary> Update layers/meta-balena to 4b2fb9d832801f84f90147ec2a5b3fba56cd194e [renovate[bot]] </summary>

> ## meta-balena-2.107.16
> ### (2022-12-01)
> 
> * Refactor and clean up the purge data tests [Kyle Harding]
> 
</details>

# v2.107.15
## (2022-12-01)


<details>
<summary> Update layers/meta-balena to 57b65123e0804b4447c6808db5780dd26cd31dc0 [renovate[bot]] </summary>

> ## meta-balena-2.107.15
> ### (2022-12-01)
> 
> * Updated CBS Docs Updated link to the CDS Product Repo [Ryan H]
> 
</details>

# v2.107.14
## (2022-11-30)


<details>
<summary> Update layers/meta-balena to 8ea20f929eeb3f52b23874c3bd951c961329ad29 [renovate[bot]] </summary>

> ## meta-balena-2.107.14
> ### (Invalid date)
> 
> * test: os: fix search for active interface [rcooke-warwick]
> 
</details>

# v2.107.13+rev1
## (2022-11-30)


<details>
<summary> Update contracts to 5d83fa7ad3a0c95db49ee465c9a77845611f3a3b [renovate[bot]] </summary>

> ## contracts-2.0.29
> ### (Invalid date)
> 
> * Add node v19.2.0 [Trong Nghia Nguyen]
> 
</details>

# v2.107.13
## (2022-11-29)


<details>
<summary> Update layers/meta-balena to e3888e2b46676499f47c148431d9d457535c6871 [renovate[bot]] </summary>

> ## meta-balena-2.107.13
> ### (2022-11-29)
> 
> * balena-image-flasher: Include LUKS variant of GRUB config with FDE in place [Michal Toman]
> 
</details>

# v2.107.12
## (2022-11-28)


<details>
<summary> Update layers/meta-balena to 3e67facb7e983b198f29a67ae70a3ff5d9e7a90c [renovate[bot]] </summary>

> ## meta-balena-2.107.12
> ### (2022-11-28)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to 61016ad [renovate[bot]] </summary>
> 
>> ### leviathan-2.10.4
>> #### (2022-11-25)
>> 
>> * bump contracts to 2.0.27 [rcooke-warwick]
>> 
>> ### leviathan-2.10.3
>> #### (2022-11-24)
>> 
>> * On Apple Silicon we should install balena CLI via npm [Kyle Harding]
>> 
> </details>
> 
> 
</details>

# v2.107.11
## (2022-11-25)


<details>
<summary> Update layers/meta-balena to a539a5fb1d5c036bf513e52e243634722344d4c7 [renovate[bot]] </summary>

> ## meta-balena-2.107.11
> ### (2022-11-25)
> 
> * add os testing docs [rcooke-warwick]
> 
</details>

# v2.107.10
## (2022-11-25)


<details>
<summary> Update layers/meta-balena to fbf651fead37336e826d709f48255897962bdbd5 [renovate[bot]] </summary>

> ## meta-balena-2.107.10
> ### (2022-11-25)
> 
> * balena-image.bb: Include bits for LUKS when FDE is enabled [Michal Toman]
> 
> ## meta-balena-2.107.9
> ### (2022-11-24)
> 
> * resin-init-flasher: Fix double /dev/ prefix when encrypting partitions [Michal Toman]
> * grub-conf: fix partition indexes in LUKS config [Michal Toman]
> * os-helpers-fs: add dependency on parted [Michal Toman]
> * hostapp-update-hooks: use stage2 bootloader GRUB config when using LUKS [Michal Toman]
> * balena-rollback: Fix partition index detection for luks devices [Michal Toman]
> * balena-rollback: Find following symbolic links [Alex Gonzalez]
> * hostapp-update-hooks: Find following symlinks [Alex Gonzalez]
> * hostapp-update-hooks: Fix partition index detection for luks devices [Alex Gonzalez]
> 
</details>

# v2.107.8
## (2022-11-24)


<details>
<summary> Update layers/meta-balena to ce3b3d7d17723fd03a4df278c6baff10b29be22e [renovate[bot]] </summary>

> ## meta-balena-2.107.8
> ### (2022-11-24)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to bdf8eb2 [renovate[bot]] </summary>
> 
>> ### leviathan-2.10.2
>> #### (2022-11-23)
>> 
>> * add high level architecture overview [rcooke-warwick]
>> 
>> ### leviathan-2.10.1
>> #### (2022-11-23)
>> 
>> * Add conditions for Apple Silicon workstations [Kyle Harding]
>> 
> </details>
> 
> 
</details>

# v2.107.7
## (2022-11-23)


<details>
<summary> Update layers/meta-balena to 417b9c6fc8fb6423c9ed71cd7cc098b0b8e97f2b [renovate[bot]] </summary>

> ## meta-balena-2.107.7
> ### (2022-11-23)
> 
> * tests: ssh-auth: rework local authentication with cloud keys to work in testbots [Alex Gonzalez]
> * ssh-auth: do not use a separate custom key [Alex Gonzalez]
> * Revert "test: ssh-auth: fix test cases using custom keys" [Alex Gonzalez]
> 
</details>

# v2.107.6
## (2022-11-22)


<details>
<summary> Update layers/meta-balena to 1add3a4b003475a96b0414a5dec83152eab58bf3 [renovate[bot]] </summary>

> ## meta-balena-2.107.6
> ### (2022-11-22)
> 
> * Update balena-os/balena-supervisor to v14.4.4 [renovate[bot]]
> 
</details>

# v2.107.5
## (2022-11-22)


<details>
<summary> Update layers/meta-balena to d91e674a5bffd7f35944265d244b360bf6e3e8b9 [renovate[bot]] </summary>

> ## meta-balena-2.107.5
> ### (2022-11-22)
> 
> * Update balena-os/balena-supervisor to v14.4.2 [renovate[bot]]
> 
</details>

# v2.107.4
## (2022-11-20)


<details>
<summary> Update layers/meta-balena to 62205779cf90d2ea1c05e95c0a27074822e6e10f [renovate[bot]] </summary>

> ## meta-balena-2.107.4
> ### (2022-11-19)
> 
> * Update balena-os/balena-supervisor to v14.4.1 [renovate[bot]]
> 
</details>

# v2.107.3
## (2022-11-19)


<details>
<summary> Update layers/meta-balena to 8aed005616dd0baa4605440cca234be049354070 [renovate[bot]] </summary>

> ## meta-balena-2.107.3
> ### (2022-11-19)
> 
> * kernel-balena: Kernel version check should include provided version [Alex Gonzalez]
> 
</details>

# v2.107.2
## (2022-11-18)


<details>
<summary> Update layers/meta-balena to a2d882935a9f80b1b685784d7f83d9d81c9805ee [renovate[bot]] </summary>

> ## meta-balena-2.107.2
> ### (2022-11-18)
> 
> * chronyd: allow service status notification socket access to all [Alex Gonzalez]
> * chrony: update to version 4.2 [Alex Gonzalez]
> 
</details>

# v2.107.1
## (2022-11-18)


<details>
<summary> Update layers/meta-balena to df352d2fcc6c70f7eb00e5276208510fe7ec9822 [renovate[bot]] </summary>

> ## meta-balena-2.107.1
> ### (2022-11-17)
> 
> * docs: add RAID setup info [Joseph Kogut]
> 
> ## meta-balena-2.107.0
> ### (2022-11-17)
> 
> * Update balena-os/balena-supervisor to v14.4.0 [renovate[bot]]
> 
</details>

# v2.106.8
## (2022-11-17)


<details>
<summary> Update layers/meta-balena to 8c48d6b05236f1ab2fe8b081181947ed8683b0f1 [renovate[bot]] </summary>

> ## meta-balena-2.106.8
> ### (2022-11-17)
> 
> * classes: kernel-balena: add wireguard module [Alex Gonzalez]
> 
</details>

# v2.106.7
## (2022-11-15)


<details>
<summary> Update layers/meta-balena to f64f63370e54d5ed14e124578ed9193c765ade92 [renovate[bot]] </summary>

> ## meta-balena-2.106.7
> ### (2022-11-15)
> 
> * test: ssh-auth: fix test cases using custom keys [Alex Gonzalez]
> 
</details>

# v2.106.6
## (2022-11-15)


<details>
<summary> Update layers/meta-balena to 0bcd2db1e6e5bf04ad2882028aa26cbab0ee49ea [renovate[bot]] </summary>

> ## meta-balena-2.106.6
> ### (2022-11-15)
> 
> * Update balena-os/balena-supervisor to v14.3.3 [renovate[bot]]
> 
</details>

# v2.106.5
## (2022-11-14)


<details>
<summary> Update layers/meta-balena to af180bb6f4c61940cbf23d0b92dbceadea10aa3f [renovate[bot]] </summary>

> ## meta-balena-2.106.5
> ### (2022-11-14)
> 
> * openvpn: fix a race condition that leaves system with no running supervisor [Alex Gonzalez]
> 
</details>

# v2.106.4+rev1
## (2022-11-12)


<details>
<summary> Update balena-yocto-scripts to 3fbd0884bd7d599664587d0ab25fea22d77323ba [renovate[bot]] </summary>

> ## balena-yocto-scripts-1.19.14
> ### (2022-11-10)
> 
> * jenkins_generate_ami: use a different token [Alex Gonzalez]
> 
</details>

# v2.106.4
## (2022-11-12)


<details>
<summary> Update layers/meta-balena to 5f789c7e57c7be71b8e333ac7127a809d2161935 [renovate[bot]] </summary>

> ## meta-balena-2.106.4
> ### (2022-11-12)
> 
> * ssh-auth: setConfig: run synchronously [Alex Gonzalez]
> * cloud: ssh-auth: use custom path for custom key [Alex Gonzalez]
> * balena-config-vars: Set permissions for cache file [Alex Gonzalez]
> 
> ## meta-balena-2.106.3
> ### (2022-11-11)
> 
> * common: kernel-devsrc: fix pseudo abort [Joseph Kogut]
> 
</details>

# v2.106.2
## (2022-11-11)


<details>
<summary> Update layers/meta-balena to 301f76a3232fb25463f89f6382eb0e14189dcc0e [renovate[bot]] </summary>

> ## meta-balena-2.106.2
> ### (2022-11-10)
> 
> * flasher: minor formatting [Joseph Kogut]
> * flasher: fix detection and exclusion of installation media [Joseph Kogut]
> * flasher: properly expand device_pattern globs [Joseph Kogut]
> 
</details>

# v2.106.1
## (2022-11-10)


<details>
<summary> Update layers/meta-balena to bf237c4f76c4026ed3aea2f30edc7c6a484fcef6 [renovate[bot]] </summary>

> ## meta-balena-2.106.1
> ### (2022-11-10)
> 
> * tests: cloud: use cloud ssh to avoid race cond [rcooke-warwick]
> 
</details>

# v2.106.0+rev2
## (2022-11-10)

* Fix AGX Orin fan running at high speed [Alexandru Costache]

# v2.106.0+rev1
## (2022-11-10)

* balena-image: fix monitor not detected on display port [Alexandru Costache]

# v2.106.0
## (2022-11-10)


<details>
<summary> Update layers/meta-balena to c5f580c7bd8e7d1391331c1611ab340be68d8d6a [renovate[bot]] </summary>

> ## meta-balena-2.106.0
> ### (2022-11-10)
> 
> * Update balena-os/balena-supervisor to v14.3.0 [renovate[bot]]
> 
</details>

# v2.105.32
## (2022-11-09)


<details>
<summary> Update layers/meta-balena to b6e5de2abcadd369a37891b17494048d6a82b1cc [renovate[bot]] </summary>

> ## meta-balena-2.105.32
> ### (2022-11-09)
> 
> * Enable network access for tasks talking to the signing service [Michal Toman]
> 
</details>

# v2.105.31+rev1
## (2022-11-09)


<details>
<summary> Update contracts to b20827d63cbe7b1168f2b63b3bde216231e1b4ba [renovate[bot]] </summary>

> ## contracts-2.0.28
> ### (2022-11-09)
> 
> * Add node v18.12.1 [Trong Nghia Nguyen]
> 
</details>

# v2.105.31
## (2022-11-09)


<details>
<summary> Update layers/meta-balena to 072a02ba1b9b2f5cb4f1a520c7d321e17dca1eb5 [renovate[bot]] </summary>

> ## meta-balena-2.105.31
> ### (2022-11-08)
> 
> * Add meta-balena-esr workflow [Alex Gonzalez]
> 
</details>

# v2.105.30
## (2022-11-08)


<details>
<summary> Update layers/meta-balena to 0d399dcb9ac7ece013f76a119e8643228eb114b7 [renovate[bot]] </summary>

> ## meta-balena-2.105.30
> ### (2022-11-08)
> 
> * tests: os: ensure by-state links are created [Joseph Kogut]
> 
</details>

# v2.105.29
## (2022-11-07)


<details>
<summary> Update layers/meta-balena to ba7bbfb01a96a2dea3d02f01ea37f8bb4b3cb0d8 [renovate[bot]] </summary>

> ## meta-balena-2.105.29
> ### (2022-11-07)
> 
> * prepare-openvpn: do not use cached configuration [Alex Gonzalez]
> 
</details>

# v2.105.28+rev1
## (2022-11-07)


<details>
<summary> Update contracts to 29ecc3f3077027524ea9540cbaa81a12b265d42c [renovate[bot]] </summary>

> ## contracts-2.0.27
> ### (2022-11-07)
> 
> * Add go v1.19.3 and v1.18.8 [Trong Nghia Nguyen]
> * Add node v19.0.1 v16.18.1 and v14.21.1 [Trong Nghia Nguyen]
> 
</details>

# v2.105.28
## (2022-11-06)


<details>
<summary> Update layers/meta-balena to 496bde37adf3bdabcf3baa3c3dbbaba8ed2c59e1 [renovate[bot]] </summary>

> ## meta-balena-2.105.28
> ### (2022-11-06)
> 
> * patch: Delete conf.js for test suites [Vipul Gupta (@vipulgupta2048)]
> 
</details>

# v2.105.27
## (2022-11-05)


<details>
<summary> Update layers/meta-balena to 4f26a52c25bd3b246cc623b271873891da2fd737 [renovate[bot]] </summary>

> ## meta-balena-2.105.27
> ### (2022-11-04)
> 
> * wpa-supplicant: Sync with v2.10 from upstream [Zahari Petkov]
> 
</details>

# v2.105.26
## (2022-11-04)


<details>
<summary> Update layers/meta-balena to 397943469235f9eb67a55ce5c98e01e8afbc641e [renovate[bot]] </summary>

> ## meta-balena-2.105.26
> ### (2022-11-04)
> 
> * patch: Skip HUP suite if no releases found [Vipul Gupta (@vipulgupta2048)]
> 
</details>

# v2.105.25
## (2022-11-04)


<details>
<summary> Update layers/meta-balena to 81cdced65f90570af857c9cf012775558003c1c5 [renovate[bot]] </summary>

> ## meta-balena-2.105.25
> ### (2022-11-04)
> 
> * Update balena-os/balena-supervisor to v14.2.20 [renovate[bot]]
> 
</details>

# v2.105.24
## (2022-11-03)


<details>
<summary> Update layers/meta-balena to 912634a99a4ae09855c2c517c620ec16f843dd95 [renovate[bot]] </summary>

> ## meta-balena-2.105.24
> ### (2022-11-03)
> 
> * Update balena-os/balena-supervisor to v14.2.18 [renovate[bot]]
> 
</details>

# v2.105.23
## (2022-11-01)


<details>
<summary> Update layers/meta-balena to a2b5edbaf873fce9fb0dbe6564aaa590af9849dc [renovate[bot]] </summary>

> ## meta-balena-2.105.23
> ### (2022-11-01)
> 
> * tests: hup: handle exception when unwrapping non-flasher image [Joseph Kogut]
> 
</details>

# v2.105.22
## (2022-10-31)


<details>
<summary> Update layers/meta-balena to 24deb5194be2c96b14f8bd4343555bf855f6ca06 [renovate[bot]] </summary>

> ## meta-balena-2.105.22
> ### (2022-11-01)
> 
> * Update Docs Link Updated the link in the docs to the device-type listings (on hub as SOT) [Ryan H]
> 
</details>

# v2.105.21+rev2
## (2022-10-31)


<details>
<summary> Update contracts to edff7336f8c7fd074aed1fd087a595ee2ca05651 [renovate[bot]] </summary>

> ## contracts-2.0.26
> ### (2022-11-01)
> 
> * Add Python v3.11.0 v3.10.8 v3.9.15 v3.8.15 and v3.7.15 [Trong Nghia Nguyen]
> 
</details>

# v2.105.21+rev1
## (2022-10-28)


<details>
<summary> Update contracts to 3690dee624859ed23f2ee9afaa112638cda5cee3 [renovate[bot]] </summary>

> ## contracts-2.0.25
> ### (2022-10-27)
> 
> * Fix incorrect partials in device type contracts [Micah Halter]
> 
> ## contracts-2.0.24
> ### (2022-10-27)
> 
> * Add node v18.12.0 [Trong Nghia Nguyen]
> 
</details>

# v2.105.21
## (2022-10-27)


<details>
<summary> Update layers/meta-balena to 2e9f69012d326b5925304c9d25427c5cc46dfbd4 [renovate[bot]] </summary>

> ## meta-balena-2.105.21
> ### (2022-10-27)
> 
> * openssh: allow RSA signatures with SHA1 algorithms [Alex Gonzalez]
> 
</details>

# v2.105.20
## (2022-10-26)


<details>
<summary> Update layers/meta-balena to 6fe97ecc67ba4dc83fb5ff21d801e9062d4179d4 [renovate[bot]] </summary>

> ## meta-balena-2.105.20
> ### (2022-10-26)
> 
> * meta-resin-sumo: libical: Fix build QA error [Alex Gonzalez]
> 
</details>

# v2.105.19+rev1
## (2022-10-26)

* l4t-launcher-extlinux: Create extra_uEnv.txt [Alexandru Costache]
* tegra234-flash-dry: Fix generating boot0.img in Jenkins [Alexandru Costache]

# v2.105.19
## (2022-10-26)


<details>
<summary> Update layers/meta-balena to 38055be70d9113801797d97ddeac00012c5b151c [renovate[bot]] </summary>

> ## meta-balena-2.105.19
> ### (2022-10-26)
> 
> * meta-resin-sumo: keep tpm2-tools in 5.0 [Alex Gonzalez]
> 
> ## meta-balena-2.105.18
> ### (2022-10-25)
> 
> 
> <details>
> <summary> Update tests/leviathan digest to f83df7d [renovate[bot]] </summary>
> 
>> ### leviathan-2.10.0
>> #### (2022-10-25)
>> 
>> * minor: Add @balena/leviathan-test-helpers package [Vipul Gupta (@vipulgupta2048)]
>> 
> </details>
> 
> 
</details>

# v2.105.17+rev2
## (2022-10-26)


<details>
<summary> Update balena-yocto-scripts to 7c5b9c44fbd4039c3387c8b74e8efae8fa9f37d6 [renovate[bot]] </summary>

> ## balena-yocto-scripts-1.19.13
> ### (2022-10-21)
> 
> * jenkins_build: Only deploy AMI after deploying a final release [Alex Gonzalez]
> 
</details>

# v2.105.17+rev1
## (2022-10-25)


<details>
<summary> Update contracts to c311e6f8a9832587b3bb687b22a92574b790c688 [renovate[bot]] </summary>

> ## contracts-2.0.23
> ### (2022-10-25)
> 
> * sw.os+hw.device-type: Add distro-config.tpl for jetson-agx-orin-devkit [Alexandru Costache]
> 
</details>

# v2.105.17
## (2022-10-25)


<details>
<summary> Update layers/meta-balena to 5c78a62b8409752294e244bd1ecc111b4b969da7 [renovate[bot]] </summary>

> ## meta-balena-2.105.17
> ### (2022-10-21)
> 
> * tests: hup: reduce num. flashes and  hostapp sends [rcooke-warwick]
> 
> ## meta-balena-2.105.16
> ### (2022-10-20)
> 
> * common: openvpn: remove resin.conf [Joseph Kogut]
> 
> ## meta-balena-2.105.15
> ### (2022-10-19)
> 
> * Revert "chrony: update to version 4.1 to match kirkstone's version" [Alex Gonzalez]
> 
> ## meta-balena-2.105.14
> ### (2022-10-18)
> 
> * patch: Enable RPi3-64 for Device tree tests [Vipul Gupta (@vipulgupta2048)]
> 
> ## meta-balena-2.105.13
> ### (2022-10-18)
> 
> * ntp: Remove race condition from directory creation [Alex Gonzalez]
> 
</details>

# v2.105.12
## (2022-10-25)

* Update meta-balena submodule from v2.105.11 to v2.105.12 [Alexandru Costache]

# v2.105.11
## (2022-10-25)

* VERSION: Add version files, change log and license [Alexandru Costache]
* tegra234-flash-dry: Create signed boot blob for qspi flash [Alexandru Costache]
