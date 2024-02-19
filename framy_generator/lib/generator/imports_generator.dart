import 'package:framy_generator/framy_object.dart';

String generateImports(List<FramyObject> framyObjects,
    {bool useDevicePreview = false, List<String> extraImports = const []}) {
  final imports = <String?>{};
  imports.addAll(extraImports);
  imports.add('package:flutter/foundation.dart');
  imports.add('package:flutter/material.dart');
  if (useDevicePreview) {
    imports.add('package:device_preview/device_preview.dart');
  }
  framyObjects.forEach((object) {
    imports.add(object.import);
    imports.addAll(object.imports as Iterable<String?>);
    if (object.type == FramyObjectType.widget &&
        object.constructors!.first.dependencies!.any((element) =>
            element.dependencyType == FramyDependencyType.provider)) {
      imports.add('package:provider/provider.dart');
    }
  });
  var importsStr = '';
  final hasProviderDependency =
      imports.contains('package:provider/provider.dart');
  if (hasProviderDependency) {
    imports.remove('package:provider/provider.dart');
    importsStr = 'import \'package:provider/provider.dart\' as provider;\n';
  }
  return imports.fold(importsStr, (s, import) => '${s}import \'$import\';\n');
}
