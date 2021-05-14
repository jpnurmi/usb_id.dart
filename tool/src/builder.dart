import 'item.dart';

class UsbBuilder {
  UsbBuilder.build(Iterable<UsbItem> items) {
    buildVendors(items);
    buildDeviceClasses(items);
  }

  void buildVendors(Iterable<UsbItem> items) {
    final devices = <UsbDevice>[];
    final subsystems = <UsbSubsystem>[];

    final vendorStack = <UsbItem>[];
    void pushVendor(UsbItem item) => vendorStack.add(item);
    void popVendor() {
      if (vendorStack.isEmpty) return;
      final item = vendorStack.removeLast();
      vendors.add(item.toVendor(List<UsbDevice>.of(devices)));
      devices.clear();
    }

    final deviceStack = <UsbItem>[];
    void pushDevice(UsbItem item) => deviceStack.add(item);
    void popDevice() {
      if (deviceStack.isEmpty) return;
      final item = deviceStack.removeLast();
      devices.add(item.toDevice(List<UsbSubsystem>.of(subsystems)));
      subsystems.clear();
    }

    for (final item in items) {
      switch (item.type) {
        case UsbType.vendor:
          popDevice();
          popVendor();
          pushVendor(item);
          break;
        case UsbType.device:
          popDevice();
          pushDevice(item);
          break;
        case UsbType.subsystem:
          subsystems.add(item.toSubsystem());
          break;
        default:
          break;
      }
    }
    popDevice();
    popVendor();
  }

  void buildDeviceClasses(Iterable<UsbItem> items) {
    final subclasses = <UsbSubclass>[];
    final programmingInterfaces = <UsbProgrammingInterface>[];

    final deviceClassStack = <UsbItem>[];
    void pushDeviceClass(UsbItem item) => deviceClassStack.add(item);
    void popDeviceClass() {
      if (deviceClassStack.isEmpty) return;
      final item = deviceClassStack.removeLast();
      deviceClasses.add(item.toDeviceClass(List<UsbSubclass>.of(subclasses)));
      subclasses.clear();
    }

    final subclassStack = <UsbItem>[];
    void pushSubclass(UsbItem item) => subclassStack.add(item);
    void popSubclass() {
      if (subclassStack.isEmpty) return;
      final item = subclassStack.removeLast();
      subclasses.add(item
          .toSubclass(List<UsbProgrammingInterface>.of(programmingInterfaces)));
      programmingInterfaces.clear();
    }

    for (final item in items) {
      switch (item.type) {
        case UsbType.deviceClass:
          popSubclass();
          popDeviceClass();
          pushDeviceClass(item);
          break;
        case UsbType.subclass:
          popSubclass();
          pushSubclass(item);
          break;
        case UsbType.programmingInterface:
          programmingInterfaces.add(item.toProgrammingInterface());
          break;
        default:
          break;
      }
    }
    popSubclass();
    popDeviceClass();
  }

  final vendors = <UsbVendor>[];
  final deviceClasses = <UsbDeviceClass>[];
}
