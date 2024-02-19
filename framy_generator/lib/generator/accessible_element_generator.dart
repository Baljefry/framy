import 'package:framy_generator/framy_object.dart';

String generateAccessibleElement(FramyObject? object) {
  var text = '';

  text += object!.parentObject!.name!;
  if (!object.isStatic!) {
    text += '()';
  }
  text += '.';
  text += object.name!;
  if (object.kind == ElementKind.FUNCTION ||
      object.kind == ElementKind.METHOD) {
    text += '()';
  }
  return text;
}
