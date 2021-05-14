import 'package:usb_id/usb_id.dart';
import 'package:test/test.dart';

void main() {
  test('all vendors', () {
    final vendors = UsbId.allVendors;
    expect(vendors, hasLength(3411));
  });

  test('lookup vendor', () {
    final vendor = UsbId.lookupVendor(0x0bda);
    expect(vendor, isNotNull);
    expect(vendor!.id, equals(0x0bda));
    expect(vendor.name, equals('Realtek Semiconductor Corp.'));
    expect(vendor.devices, hasLength(95));
  });

  test('lookup device', () {
    final device = UsbId.lookupDevice(0x568c, vendorId: 0x0bda);
    expect(device, isNotNull);
    expect(device!.id, equals(0x568c));
    expect(device.name, equals('Integrated Webcam HD'));
  });

  test('all device classes', () {
    final deviceClasses = UsbId.allDeviceClasses;
    expect(deviceClasses, hasLength(19));
  });

  test('lookup device class', () {
    final deviceClass = UsbId.lookupDeviceClass(0x03);
    expect(deviceClass, isNotNull);
    expect(deviceClass!.id, equals(0x03));
    expect(deviceClass.name, equals('Human Interface Device'));
    expect(deviceClass.subclasses, hasLength(2));
  });

  test('lookup subclass', () {
    final subclass = UsbId.lookupSubclass(0x01, deviceClassId: 0x03);
    expect(subclass, isNotNull);
    expect(subclass!.id, equals(0x01));
    expect(subclass.name, equals('Boot Interface Subclass'));
    expect(subclass.programmingInterfaces, hasLength(3));
  });
}
