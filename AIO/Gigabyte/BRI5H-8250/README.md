## Hardware Specifications

Mobo: BRI5H-8250
BIOS Version: F5
CPU: Intel Core i5-8250
GPU: Intel UHD620
RAM: 16GB DDR4
NVME: Samsung SSD 970 PRO 512GB
LAN: Intel I219V
WIFI+BT: BCM94360CD

#### Working

- Full CPU and GPU Acceleration
- Dual 4K@60Hz Monitors
- Audio
- HDMI/DP Audio
- Ethernet Lan
- Bluetooth/Wifi - See Hardware Requirements 
- Contiuity, Handoff, Airdrop - With supported wifi card
- USB 3.0 and 3.1

#### Issues

- Sleep - Black scren after waking from sleep

## Hardware Requirements

Original Intel wifi+bt card is not supported in MacOS so it had to be replace with supported one. There are 2 options to achieve that

1. Use one of the following models in combination with [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup) and [BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM)
   1. BCM94352Z/AzureWave AW-CE162NF/DW1560 - 2X2 AC + BT4LE
   2. BCM94350ZAE/DW1820A  - 2X2 AC + BT4LE - Requires injection of pci-aspm-default=0 in device propertis
   3. BCM943602BAED/DW1830 - 3X3 AC + BT4LE  Untested. Requires additional antenna
2. Use OEM Apple wifi card with proper [Flex Cable Extension Adapter](https://www.ebay.com/itm/12-6-Pin-Wireless-WIFI-Card-to-M-2-Key-A-E-Adapter-Cable-Extension-Cord-20/163992495423?hash=item262eb6e53f:g:~88AAOSwAHFd91s2) Using regular m.2 adapters is not possible due to NVME being over the wifi card. So this adapter is used and card is located in SSD tray. Due to short cables all antennas are either to be replaced or [extension cables](https://www.aliexpress.com/item/32862630916.html?spm=a2g0s.12269583.0.0.297a65acktzfCj) should be used . Card models which can be used
   1. BCM94360CS2 - 2X2 AC + BT4LE
   2. BCM94360CSAX - 3X3 AC + BT4LE - Requres aaditional antenna
   3. BCM94360CD - 3X3 AC + BT4LE - Separate BT antenna. Requires 2 addditional antennas
   4. BCM94361CD - 3X3 AC + BT4LE - Separate BT antenna. Requires 2 addditional antennas

## Bios Configuration

Version: F5 Latest

- Advanced 
  - CPU Configuration
    - Intel Virtualization Technology : Enabled
    - EIST : Enabled
      - Turbo Mode : Enabled
    - CPU C States : Enabled
    - CPU P States : Enabled
    - CFG-Lock : Disabled
  - Trusted Computing
    - Security Device Support : Disabled
  - CSM Configuration
    - CSM Support : Disabled
    - LAN EFI Driver : Disabled
- Chipset
  - VT-d : Enabled
  - DVMT Pre-Alocated : 64M
  - Onboard Audio : Enabled
  - Onboard Lan : Enabled
  - ERP Lowest Power State Mode : Disabled - **Maybe should be enabled**
  - USB S5 Wakeup Support : Disabled 
  - XHCI Hand-off : Enabled
  - Restore AC Power Loss : Power Off
  - BIOS Lock : Enabled
- Security
  - Secure Boot : Disabled

## OpenCore Configuration

Version: 0.5.7

#### ACPI Patches

Sources and original dump can be found in ACPI directory.

- HPET _CRS to XCRS Rename - **Not sure If Needed**
- TIMR IRQ 0 Patch - **Not sure If Needed**
- RTC IRQ 8 Patch - **Not sure If Needed**
- RTC Length Fix 0x8 to 0x2 - **Not sure If Needed**
- SAT0 to SATA Rename - For better sata compatibility

#### SSDT Injections

- SSDT-HPET.aml - FIX HPET - **Not sure If Needed**
- SSDT-EC-USBX.aml - Fake EC and USB Power Injection
- SSDT-PLUG.aml - CPU plugin-type 1 for Power Management
- SSDT-UIAC.aml - USB Ports injection

#### Booter Quirks

- AvoidRuntimeDefrag - Needed for most mackintoshes
- RebuildAppleMemoryMap - In favor of EnableWriteUnprotector
- SyncRuntimePermission - **Boots without it. Not sure if needed**

#### Device Properties

- PciRoot(0x0)/Pci(0x2,0x0) - GPU
  - device-id = 0x80865919 - GPU Is not natively supported so we need fake id
  - AAPL,ig-platform-id = 0x5916000 - Connectors LVDS + DP + HDMI 
  - enable-dpcd-max-link-rate-fix = 1 - Fixes issue with 4K
  - #framebuffer-patch-enable = 1 and #framebuffer-unifiedmem 0000F0FF  - 4GB VRAM Disabled by default
- PciRoot(0x0)/Pci(0x1F,0x3) - HD Audio
  - layout-id  = 0F000000 - Layout ID 15 - Added by me in AppleALC specifically for BRI5H-8250
  - hda-gfx = onboard-1 - HDMI/DP Audio Injection

#### Kernel Extension

- [Lilu](https://github.com/acidanthera/lilu/) - 1.4.3 - Arbitrary kext and process patching on macOS
- [VirtualSMC](https://github.com/acidanthera/VirtualSMC) with SMCProcesor and SMCSuperIO - 1.1.2 - SMC emulator layer
- [WhateverGreen](https://github.com/acidanthera/WhateverGreen) - 1.1.2 - GPU Patches
- [AppleALC](https://github.com/acidanthera/AppleALC) - 1.4.8 - Audio Injection
- [NVMeFix](https://github.com/acidanthera/NVMeFix) - 1.0.2 - Power management for NVMe
- [USBInjectAll](https://github.com/Sniki/OS-X-USB-Inject-All) - 0.7.3 - USB Injection - **As of now version 0.7.5 is broken does not load**
- [IntelMausiEthernet](https://github.com/acidanthera/IntelMausi) - Lan Driver
- [RTCMemoryFixup](https://github.com/acidanthera/RTCMemoryFixup) -  **Untested** Fixes RTC 
- [Hibernation Fixup](https://github.com/lvs1974/HibernationFixup) - **Untested** Fixes Hibernation

#### Kernel Quirks

- DisableIoMapper - This patches VT-d so it can be left enabled in BIOS for use in other OS-e
- PanicNoKextDump - Disable kext dump on kernel panic so that issue can be seen in log
- PowerTimoutKerenlPanic - Fixes kernel panic that may occure due to poewer timeouts, may not be needed

#### Misc

Preferences set are mostly cosmetic in nature so it wont be explained. One thing worh mentioning is that OpenCanopy is uses external picker acpidump available in tools. There is no OpenShell.efi sinc the board already have built-in EFI Shell which should be used for running acpidump in order not to dump already patched tables. For more info related to this section check the offical [OpenCore documentation](https://github.com/acidanthera/OpenCorePkg/blob/80a82ed86edc5a203389e9524d43dc3158ce760b/Docs/Configuration.pdf)

#### NVRAM

**Quirks:**

- WriteFlash - Alows writing to hardware nvram

Some values are set by default:

- 4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14:DefaulBakcgroundColor : 00000000 Black
- 4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14:UIScale: 02 HiDPI - For non HiDPI use 01
- 7C436110-AB2A-4BBB-A880-FE41995C9F82:SystemAudioVolume: 46
- 7C436110-AB2A-4BBB-A880-FE41995C9F82:boot-args: -v - Verbose Boot
- 7C436110-AB2A-4BBB-A880-FE41995C9F82:csr-active-config: E7030000 - CSR System Protection Disabled
- 7C436110-AB2A-4BBB-A880-FE41995C9F82:prev-lang:kbd - en:US

#### PlatformInfo

**SMBIOS : Macmini8,1**

Before using the config file you should add prameters into **Generic** section related to serial numbers. [MacInfoPkg](https://github.com/acidanthera/MacInfoPkg) can be used to generate Serial Number and MLB. The values that need to be set:

- System Serial Number - Generated with macserial --generate --model Macmini8,1
- System UUID - Randomly Generated UUID
- MLB - Generated with macserial --generate --model Macmini8,1
- ROM - Should be unique 6 byte value. It's best to put Ethernet mac address here

All other values should be left blank and OpenCore will generate them using the automatic setting

#### UEFI

##### Auido

Plays chime on boot via headphone jack more info in offical [OpenCore documentation](https://github.com/acidanthera/OpenCorePkg/blob/80a82ed86edc5a203389e9524d43dc3158ce760b/Docs/Configuration.pdf)

- AudioDevice - PciRoot(0x0)/Pci(0x1F,0x3)
- AudioCodec - 0
- AudioOut - 0

##### Drivers

- ConnectDrivers - Must be enabled for APFS and Audio, Also needed if multiple filesystem drivers are used

- ApfsDriverLoader.efi - Support for APFS
- HfsPlus.efi - Support for HFS+
- AudioDxe - Adds support for boot chime audio if disabled boot may be faster
- OpenRuntime - OpenCore driver
- OpenCanopy - OpenCore GUI picker - **Experimetnal**

##### Input

Default recommended values are used

- KeyForgetTreshold: 5
- KeyMergeTreshold: 2
- KeySupport: Enabled

##### Output

- TextRenderer - BuiltinGraphics
- Resolution - Max
- ProvideConsoleGop - Enabled

##### Protocols

None the protocols are needed

##### Quirks:

- RequestBootVarFallback - Rotutes boot varieable through OpenCore - Fixes update and hibernation - More info in official docs
- RequestBootVarRouting - Prevents other OS from ovewriting boot entries