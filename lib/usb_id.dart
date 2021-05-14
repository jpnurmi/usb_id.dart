/// A repository of all known ID's used in USB devices: ID's of vendors,
/// devices, subsystems and device classes. This package can be utilized
/// to display human-readable names instead of cryptic numeric codes.
///
/// ```dart
/// import 'package:usb_id/usb_id.dart';
///
/// void main() {
///   final vendor = UsbId.lookupVendor(0x1ae0);
///   print('Vendor 0x1ae0:     ${vendor!.name}'); // Google, Inc.
///
///   final device = UsbId.lookupDevice(0xabcd, vendorId: vendor.id);
///   print('  Device 0xabcd:   ${device!.name}'); // ...Pixel Neural Core...
///
///   final deviceClass = UsbId.lookupDeviceClass(0x03);
///   print('\nDevice class 0x03: ${deviceClass!.name}'); // Display controller
///
///   final subclass = UsbId.lookupSubclass(0x00, deviceClassId: 0x03);
///   print('  Subclass 0x00:   ${subclass!.name}'); // VGA compatible controller
/// }
/// ```
library usb_id;

export 'src/usb_id.dart';
export 'src/usb_types.dart';
