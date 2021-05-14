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
