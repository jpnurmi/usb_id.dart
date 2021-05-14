# The USB ID Repository for Dart

[![pub](https://img.shields.io/pub/v/usb_id.svg)](https://pub.dev/packages/usb_id)
[![license: BSD](https://img.shields.io/badge/license-BSD-yellow.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
![CI](https://github.com/jpnurmi/usb_id.dart/workflows/CI/badge.svg)
[![codecov](https://codecov.io/gh/jpnurmi/usb_id.dart/branch/main/graph/badge.svg)](https://codecov.io/gh/jpnurmi/usb_id.dart)

A repository of all known ID's used in USB devices: ID's of vendors,
devices, subsystems and device classes. This package can be utilized
to display human-readable names instead of cryptic numeric codes.

### Usage

```dart
import 'package:usb_id/usb_id.dart';

void main() {
  final vendor = UsbId.lookupVendor(0x18d1);
  print('Vendor 0x18d1:     ${vendor!.name}'); // Google Inc.

  final device = UsbId.lookupDevice(0x4e11, vendorId: vendor.id);
  print('  Device 0x4e11:   ${device!.name}'); // Nexus One

  final deviceClass = UsbId.lookupDeviceClass(0xe0);
  print('\nDevice class 0xe0: ${deviceClass!.name}'); // Wireless

  final subclass = UsbId.lookupSubclass(0x02, deviceClassId: deviceClass.id);
  print('  Subclass 0x02:   ${subclass!.name}'); // Wireless USB Wire Adapter
}
```
