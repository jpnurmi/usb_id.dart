import 'item.dart';

class UsbParser {
  Iterable<UsbItem> parse(Iterable<String> lines) {
    for (final line in lines) {
      final trimmed = line.removeComment();
      if (trimmed.isNotEmpty) {
        final item = parseLine(trimmed);
        _type = item.type;
        _items.add(item);
      }
    }
    return _items;
  }

  bool isDeviceClass(String line) {
    return line.startsWith('C ') || _type.index >= UsbType.deviceClass.index;
  }

  UsbItem parseLine(String line) {
    final indentation = line.indexOf(RegExp(r'[^\t]'));
    switch (indentation) {
      case 0:
        if (isDeviceClass(line)) {
          return UsbItem.deviceClass(line.substring(2).trim());
        } else {
          return UsbItem.vendor(line.trim());
        }
      case 1:
        if (isDeviceClass(line)) {
          return UsbItem.subclass(line.trim());
        } else {
          return UsbItem.device(line.trim());
        }
      case 2:
        if (isDeviceClass(line)) {
          return UsbItem.programmingInterface(line.trim());
        } else {
          return UsbItem.subsystem(line.trim());
        }
      default:
        throw UnsupportedError('Malformed usb.ids');
    }
  }

  final _items = <UsbItem>[];
  UsbType _type = UsbType.device;
}

extension UsbComment on String {
  String removeComment() {
    final hash = indexOf('#');
    if (hash == -1) {
      return this;
    }
    return substring(0, hash);
  }
}
