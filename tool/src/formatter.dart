import 'item.dart';

extension UsbVendorFormatter on UsbVendor {
  String formatKey() => '_vendor_${id.toHex(4)}';

  String formatValue() {
    final i = id.print(4);
    final n = name.print();
    final d = devices.map((device) => device.formatKey(id)).join(', ');
    return 'UsbVendor(id: $i, name: $n, devices: <UsbDevice>[$d],)';
  }

  String formatVariable() => 'const ${formatKey()} = ${formatValue()};';

  String formatMapEntry() => '${id.print(4)}: ${formatKey()},';
}

extension UsbDeviceFormatter on UsbDevice {
  String formatKey(int vendorId) {
    final v = vendorId.toHex(4);
    final i = id.toHex(4);
    return '_device_${v}_$i';
  }

  String formatValue(int vendorId) {
    final i = id.print(4);
    final n = name.print();
    final s = subsystems
        .map((subsystem) => subsystem.formatKey(vendorId, id))
        .join(', ');
    return 'UsbDevice(id: $i, name: $n, subsystems: <UsbSubsystem>[$s],)';
  }

  String formatVariable(int vendorId) {
    return 'const ${formatKey(vendorId)} = ${formatValue(vendorId)};';
  }

  String formatMapEntry(int vendorId) {
    return '${id.print(4)}: ${formatKey(vendorId)},';
  }
}

extension UsbSubsystemFormatter on UsbSubsystem {
  String formatKey(int vendorId, int deviceId) {
    final v1 = vendorId.toHex(4);
    final d1 = deviceId.toHex(4);
    final v2 = this.vendorId.toHex(4);
    final d2 = this.deviceId.toHex(4);
    return '_subsystem_${v1}_${d1}_${v2}_$d2';
  }

  String formatValue() {
    final v = vendorId.print(4);
    final d = deviceId.print(4);
    final n = name.print();
    return 'UsbSubsystem(vendorId: $v, deviceId: $d, name: $n,)';
  }

  String formatVariable(int vendorId, int deviceId) {
    return 'const ${formatKey(vendorId, deviceId)} = ${formatValue()};';
  }
}

extension UsbDeviceClassFormatter on UsbDeviceClass {
  String formatKey() => '_device_class_${id.toHex(2)}';

  String formatValue() {
    final i = id.print(2);
    final n = name.print();
    final s = subclasses.map((subclass) => subclass.formatKey(id)).join(', ');
    return 'UsbDeviceClass(id: $i, name: $n, subclasses: <UsbSubclass>[$s],)';
  }

  String formatVariable() => 'const ${formatKey()} = ${formatValue()};';

  String formatMapEntry() => '${id.print(2)}: ${formatKey()},';
}

extension UsbSubclassFormatter on UsbSubclass {
  String formatKey(int deviceClassId) {
    final d = deviceClassId.toHex(2);
    final i = id.toHex(2);
    return '_subclass_${d}_$i';
  }

  String formatValue(int deviceClassId) {
    final i = id.print(2);
    final n = name.print();
    final p = programmingInterfaces
        .map((pi) => pi.formatKey(deviceClassId, id))
        .join(', ');
    return 'UsbSubclass(id: $i, name: $n, programmingInterfaces: <UsbProgrammingInterface>[$p],)';
  }

  String formatVariable(int deviceClassId) {
    return 'const ${formatKey(deviceClassId)} = ${formatValue(deviceClassId)};';
  }

  String formatMapEntry(int deviceClassId) {
    return '${id.print(2)}: ${formatKey(deviceClassId)},';
  }
}

extension UsbProgrammingInterfaceFormatter on UsbProgrammingInterface {
  String formatKey(int deviceClassId, int subclassId) {
    final d = deviceClassId.toHex(2);
    final s = subclassId.toHex(2);
    final i = id.toHex(2);
    return '_programming_interface_${d}_${s}_$i';
  }

  String formatValue() {
    final i = id.print(2);
    final n = name.print();
    return 'UsbProgrammingInterface(id: $i, name: $n,)';
  }

  String formatVariable(int deviceClassId, int subclassId) {
    return 'const ${formatKey(deviceClassId, subclassId)} = ${formatValue()};';
  }
}

extension UsbIntFormatter on int {
  String print(int length) => '0x${toHex(length)}';
  String toHex(int length) => toRadixString(16).padLeft(length, '0');
}

extension UsbStringFormatter on String {
  String print() => '\'${escape()}\'';
  String escape() => replaceAll('\'', '\\\'');
}
