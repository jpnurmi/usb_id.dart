import 'package:usb_id/src/usb_types.dart';
export 'package:usb_id/src/usb_types.dart';

enum UsbType {
  vendor,
  device,
  subsystem,
  deviceClass,
  subclass,
  programmingInterface,
}

class UsbItem {
  final String line;
  final UsbType type;

  UsbItem.vendor(this.line) : type = UsbType.vendor;
  UsbItem.device(this.line) : type = UsbType.device;
  UsbItem.subsystem(this.line) : type = UsbType.subsystem;
  UsbItem.deviceClass(this.line) : type = UsbType.deviceClass;
  UsbItem.subclass(this.line) : type = UsbType.subclass;
  UsbItem.programmingInterface(this.line) : type = UsbType.programmingInterface;

  int get id => int.parse(ids.first, radix: 16);
  int get subid => int.parse(ids.last, radix: 16);
  String get name => tokens.last;

  List<String> get tokens => line.split('  ');
  List<String> get ids => tokens.first.split(' ');

  UsbVendor toVendor(Iterable<UsbDevice> devices) {
    return UsbVendor(id: id, name: name, devices: devices);
  }

  UsbDevice toDevice(Iterable<UsbSubsystem> subsystems) {
    return UsbDevice(id: id, name: name, subsystems: subsystems);
  }

  UsbSubsystem toSubsystem() {
    return UsbSubsystem(vendorId: id, deviceId: subid, name: name);
  }

  UsbDeviceClass toDeviceClass(Iterable<UsbSubclass> subclasses) {
    return UsbDeviceClass(id: id, name: name, subclasses: subclasses);
  }

  UsbSubclass toSubclass(
    Iterable<UsbProgrammingInterface> programmingInterfaces,
  ) {
    return UsbSubclass(
      id: id,
      name: name,
      programmingInterfaces: programmingInterfaces,
    );
  }

  UsbProgrammingInterface toProgrammingInterface() {
    return UsbProgrammingInterface(id: id, name: name);
  }
}
