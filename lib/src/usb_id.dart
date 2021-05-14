import 'usb_types.dart';

part 'usb_id.g.dart';

/// A repository of all known ID's used in USB devices: ID's of vendors,
/// devices, subsystems and device classes. This package can be utilized
/// to display human-readable names instead of cryptic numeric codes.
class UsbId {
  /// Holds a collection of all USB vendors.
  static Iterable<UsbVendor> get allVendors => _vendors.values;

  /// Looks up a USB vendor by the [id].
  ///
  /// Returns `null` if not found.
  static UsbVendor? lookupVendor(int id) => _vendors[id];

  /// Looks up a USB device by the [id] and [vendorId].
  ///
  /// Returns `null` if not found.
  static UsbDevice? lookupDevice(int id, {required int vendorId}) {
    return _devices[vendorId]?[id];
  }

  /// Holds a collection all USB device classes.
  static Iterable<UsbDeviceClass> get allDeviceClasses {
    return _device_classes.values;
  }

  /// Looks up a USB device class by the [id].
  ///
  /// Returns `null` if not found.
  static UsbDeviceClass? lookupDeviceClass(int id) {
    return _device_classes[id];
  }

  /// Looks up a USB subclass by the [id] and [deviceClassId].
  ///
  /// Returns `null` if not found.
  static UsbSubclass? lookupSubclass(int id, {required int deviceClassId}) {
    return _subclasses[deviceClassId]?[id];
  }
}
