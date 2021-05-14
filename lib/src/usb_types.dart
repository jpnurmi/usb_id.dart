import 'package:equatable/equatable.dart';

/// Describes a USB vendor and its devices.
class UsbVendor extends Equatable {
  /// Holds the ID of the USB vendor.
  final int id;

  /// Holds the name of the USB vendor.
  final String name;

  /// Holds the devices of the USB vendor.
  final Iterable<UsbDevice> devices;

  /// Constructs a USB vendor.
  const UsbVendor({
    required this.id,
    required this.name,
    required this.devices,
  });

  @override
  List<Object?> get props => <Object?>[id, name, devices];

  @override
  bool? get stringify => true;
}

/// Describes a USB device and its subsystems.
class UsbDevice extends Equatable {
  /// Holds the ID of the USB device.
  final int id;

  /// Holds the name of the USB device.
  final String name;

  /// Holds the subsystems of the USB device.
  final Iterable<UsbSubsystem> subsystems;

  /// Constructs a USB device.
  const UsbDevice({
    required this.id,
    required this.name,
    required this.subsystems,
  });

  @override
  List<Object?> get props => <Object?>[id, name, subsystems];

  @override
  bool? get stringify => true;
}

/// Describes a USB subsystem.
class UsbSubsystem extends Equatable {
  /// Holds the vendor ID of the USB subsystem.
  final int vendorId;

  /// Holds the device ID of the USB subsystem.
  final int deviceId;

  /// Holds the name of the USB subsystem.
  final String name;

  /// Constructs a USB subsystem.
  const UsbSubsystem({
    required this.vendorId,
    required this.deviceId,
    required this.name,
  });

  @override
  List<Object?> get props => <Object?>[vendorId, deviceId, name];

  @override
  bool? get stringify => true;
}

/// Describes a USB device class and its subclasses.
class UsbDeviceClass extends Equatable {
  /// Holds the ID of the USB device class.
  final int id;

  /// Holds the name of the USB device class.
  final String name;

  /// Holds the subclasses of the USB device class.
  final Iterable<UsbSubclass> subclasses;

  /// Constructs a USB device class.
  const UsbDeviceClass({
    required this.id,
    required this.name,
    required this.subclasses,
  });

  @override
  List<Object?> get props => <Object?>[id, name, subclasses];

  @override
  bool? get stringify => true;
}

/// Describes a USB subclass and its programming interfaces.
class UsbSubclass extends Equatable {
  /// Holds the ID of the USB subclass.
  final int id;

  /// Holds the name of the USB subclass.
  final String name;

  /// Holds the programming interfaces of the USB subclass.
  final Iterable<UsbProgrammingInterface> programmingInterfaces;

  /// Constructs a USB subclass.
  const UsbSubclass({
    required this.id,
    required this.name,
    required this.programmingInterfaces,
  });

  @override
  List<Object?> get props => <Object?>[id, name, programmingInterfaces];

  @override
  bool? get stringify => true;
}

/// Describes a USB programming interface.
class UsbProgrammingInterface extends Equatable {
  /// Holds the ID of the USB programming interface.
  final int id;

  /// Holds the name of the USB subclass.
  final String name;

  /// Constructs a USB programming interface.
  const UsbProgrammingInterface({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => <Object?>[id, name];

  @override
  bool? get stringify => true;
}
