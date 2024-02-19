import 'package:framy_generator/framy_object.dart';

String generateAvailableConstructorNames(List<FramyObject> modelObjects) => '''
Map<String, List<String>> framyAvailableConstructorNames = {
  ${modelObjects.fold('', (prev, model) => prev.toString() + _modelToConstructorNames(model))}
};
''';

String _modelToConstructorNames(FramyObject modelObject) {
  final name = modelObject.name;
  final constructorNames = modelObject.constructors
      ?.map((constructor) => "'${constructor.name}'")
      .toList();
  if (constructorNames!.isEmpty) {
    return '';
  }
  return "'$name': $constructorNames,";
}
