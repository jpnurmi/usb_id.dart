import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:usb_id/src/usb_types.dart';

import 'src/builder.dart';
import 'src/formatter.dart';
import 'src/item.dart';
import 'src/parser.dart';

const String kDefaultOutputFileName = 'usb_id.g.dart';

const kIndexTemplate = '''
const {{variable}} = <int, {{type}}>{
  {{entries}}
};
''';

const kEntryTemplate = '''
{{id}}: <int, {{type}}>{
  {{entries}}
},
''';

const String kOutputTemplate = '''
part of 'usb_id.dart';

{{variables}}

{{index}}
''';

// ignore_for_file: avoid_print

void main(List<String> args) {
  final parser = ArgParser();
  parser.addOption(
    'output',
    abbr: 'o',
    defaultsTo: kDefaultOutputFileName,
    help: 'The output file or directory',
  );

  final options = parser.parse(args);
  if (options.rest.length != 1) {
    printUsage(parser.usage);
    exit(-1);
  }

  final inputFile = File(options.rest.first);
  if (!inputFile.existsSync()) {
    printError('Cannot find ${inputFile.path}');
    printUsage(parser.usage);
    exit(-1);
  }

  final outputFile = File(resolveOutputFile(options['output'] as String));

  final lines = inputFile.readAsLinesSync();
  final items = UsbParser().parse(lines);

  final output = generateDart(items);
  outputFile.writeAsStringSync(output);

  print('Generated ${outputFile.path}');
}

void printError(String error) {
  print('ERROR: $error');
}

void printUsage(String usage) {
  final exe = p.basename(Platform.resolvedExecutable);
  final script = p.basename(p.fromUri(Platform.script));
  print('Usage: $exe run $script [options] <usb.ids>');
  print(usage);
}

String resolveOutputFile(String output) {
  if (FileSystemEntity.isDirectorySync(output)) {
    return p.join(output, kDefaultOutputFileName);
  }
  return output;
}

String generateDart(Iterable<UsbItem> items) {
  final builder = UsbBuilder.build(items);
  return kOutputTemplate
      .replaceFirst('{{index}}', generateIndex(builder))
      .replaceFirst('{{variables}}', generateVariables(builder));
}

String generateIndex(UsbBuilder builder) {
  final lines = <String>[];
  lines.add(generateVendorIndex(builder.vendors));
  lines.add(generateDeviceIndex(builder.vendors));
  lines.add(generateDeviceClassIndex(builder.deviceClasses));
  lines.add(generateSubclassIndex(builder.deviceClasses));
  return lines.join('\n');
}

String generateVendorIndex(Iterable<UsbVendor> vendors) {
  final lines = <String>[];
  for (final vendor in vendors) {
    lines.add(vendor.formatMapEntry());
  }
  return kIndexTemplate
      .replaceFirst('{{type}}', 'UsbVendor')
      .replaceFirst('{{variable}}', '_vendors')
      .replaceFirst('{{entries}}', lines.join('\n'));
}

String generateDeviceIndex(Iterable<UsbVendor> vendors) {
  final lines = <String>[];
  for (final vendor in vendors) {
    final entries = vendor.devices.map<String>(
      (device) => device.formatMapEntry(vendor.id),
    );
    lines.add(kEntryTemplate
        .replaceFirst('{{id}}', vendor.id.print(4))
        .replaceFirst('{{type}}', 'UsbDevice')
        .replaceFirst('{{entries}}', entries.join('\n')));
  }
  return kIndexTemplate
      .replaceFirst('{{type}}', 'Map<int, UsbDevice>')
      .replaceFirst('{{variable}}', '_devices')
      .replaceFirst('{{entries}}', lines.join('\n'));
}

String generateDeviceClassIndex(Iterable<UsbDeviceClass> deviceClasses) {
  final lines = <String>[];
  for (final deviceClass in deviceClasses) {
    lines.add(deviceClass.formatMapEntry());
  }
  return kIndexTemplate
      .replaceFirst('{{type}}', 'UsbDeviceClass')
      .replaceFirst('{{variable}}', '_device_classes')
      .replaceFirst('{{entries}}', lines.join('\n'));
}

String generateVariables(UsbBuilder builder) {
  final lines = <String>[];
  lines.addAll(generateVendorVariables(builder.vendors));
  lines.addAll(generateDeviceClassVariables(builder.deviceClasses));
  return lines.join('\n');
}

String generateSubclassIndex(Iterable<UsbDeviceClass> deviceClasses) {
  final lines = <String>[];
  for (final deviceClass in deviceClasses) {
    final entries = deviceClass.subclasses.map<String>(
      (subclass) => subclass.formatMapEntry(deviceClass.id),
    );
    lines.add(kEntryTemplate
        .replaceFirst('{{id}}', deviceClass.id.print(2))
        .replaceFirst('{{type}}', 'UsbSubclass')
        .replaceFirst('{{entries}}', entries.join('\n')));
  }
  return kIndexTemplate
      .replaceFirst('{{type}}', 'Map<int, UsbSubclass>')
      .replaceFirst('{{variable}}', '_subclasses')
      .replaceFirst('{{entries}}', lines.join('\n'));
}

List<String> generateVendorVariables(Iterable<UsbVendor> vendors) {
  final lines = <String>[];
  for (final vendor in vendors) {
    lines.add(vendor.formatVariable());
    for (final device in vendor.devices) {
      lines.add(device.formatVariable(vendor.id));
      for (final subsystem in device.subsystems) {
        lines.add(subsystem.formatVariable(vendor.id, device.id));
      }
    }
  }
  return lines;
}

List<String> generateDeviceClassVariables(
  Iterable<UsbDeviceClass> deviceClasses,
) {
  final lines = <String>[];
  for (final deviceClass in deviceClasses) {
    lines.add(deviceClass.formatVariable());
    for (final subclass in deviceClass.subclasses) {
      lines.add(subclass.formatVariable(deviceClass.id));
      for (final programmingInterface in subclass.programmingInterfaces) {
        lines.add(
          programmingInterface.formatVariable(deviceClass.id, subclass.id),
        );
      }
    }
  }
  return lines;
}
