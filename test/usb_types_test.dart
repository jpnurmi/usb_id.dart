import 'package:usb_id/usb_id.dart';
import 'package:test/test.dart';

void main() {
  test('vendors', () {
    final subsystem1 = UsbSubsystem(
      vendorId: 1,
      deviceId: 2,
      name: 'Subsystem 1',
    );
    final subsystem2 = UsbSubsystem(
      vendorId: 3,
      deviceId: 4,
      name: 'Subsystem 2',
    );
    expect(subsystem1, equals(subsystem1));
    expect(subsystem1, isNot(equals(subsystem2)));
    expect(
      subsystem1.toString(),
      matches(
        r'UsbSubsystem\(1, 2, Subsystem 1\)',
      ),
    );

    final device1 = UsbDevice(
      id: 1,
      name: 'Device 1',
      subsystems: [subsystem1, subsystem2],
    );
    final device2 = UsbDevice(
      id: 2,
      name: 'Device 2',
      subsystems: [subsystem2, subsystem1],
    );
    expect(device1, equals(device1));
    expect(device1, isNot(equals(device2)));
    expect(
      device1.toString(),
      matches(
        r'UsbDevice\(1, Device 1, \[.*\]\)',
      ),
    );

    final vendor1 = UsbVendor(
      id: 1,
      name: 'Vendor 1',
      devices: [device1, device2],
    );
    final vendor2 = UsbVendor(
      id: 2,
      name: 'Vendor 2',
      devices: [device2, device1],
    );
    expect(vendor1, equals(vendor1));
    expect(vendor1, isNot(equals(vendor2)));
    expect(
      vendor1.toString(),
      matches(
        r'UsbVendor\(1, Vendor 1\, \[.*\]\)',
      ),
    );
  });

  test('device classes', () {
    final programmingInterface1 = UsbProgrammingInterface(
      id: 1,
      name: 'Programming interface 1',
    );
    final programmingInterface2 = UsbProgrammingInterface(
      id: 2,
      name: 'Programming interface 2',
    );
    expect(programmingInterface1, equals(programmingInterface1));
    expect(programmingInterface1, isNot(equals(programmingInterface2)));
    expect(
      programmingInterface1.toString(),
      matches(
        r'UsbProgrammingInterface\(1, Programming interface 1\)',
      ),
    );

    final subclass1 = UsbSubclass(
      id: 1,
      name: 'Subclass 1',
      programmingInterfaces: [programmingInterface1, programmingInterface2],
    );
    final subclass2 = UsbSubclass(
      id: 2,
      name: 'Subclass 2',
      programmingInterfaces: [programmingInterface2, programmingInterface1],
    );
    expect(subclass1, equals(subclass1));
    expect(subclass1, isNot(equals(subclass2)));
    expect(
      subclass1.toString(),
      matches(
        r'UsbSubclass\(1, Subclass 1, \[.*\]\)',
      ),
    );

    final deviceClass1 = UsbDeviceClass(
      id: 1,
      name: 'Device class 1',
      subclasses: [subclass1, subclass2],
    );
    final deviceClass2 = UsbDeviceClass(
      id: 2,
      name: 'Device class 2',
      subclasses: [subclass2, subclass1],
    );
    expect(deviceClass1, equals(deviceClass1));
    expect(deviceClass1, isNot(equals(deviceClass2)));
    expect(
      deviceClass1.toString(),
      matches(
        r'UsbDeviceClass\(1, Device class 1, \[.*\]\)',
      ),
    );
  });
}
