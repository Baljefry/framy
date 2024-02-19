import 'package:framy_generator/config/framy_config.dart';
import 'package:framy_generator/framy_object.dart';
import 'package:framy_generator/generator/accessible_element_generator.dart';

String generateFramyApp(List<FramyObject> themeObjects, bool usesRiverpod,
        FramyConfig framyConfig) =>
    '''
final framyAppStateKey = GlobalKey<_FramyAppState>();

class FramyApp extends StatefulWidget {
  FramyApp() : super(key: framyAppStateKey);

  @override
  _FramyAppState createState() => _FramyAppState();
}

class _FramyAppState extends State<FramyApp> {
  bool _wrapWithScaffold = ${framyConfig.wrapWithScaffold};
  bool _wrapWithCenter = ${framyConfig.wrapWithCenter};
  bool _wrapWithSafeArea = ${framyConfig.wrapWithSafeArea};
  bool _showNavigationMenu = true;
  bool _wrapWithDevicePreview = ${framyConfig.wrapWithDevicePreview};

  set wrapWithScaffold(bool value) =>
      setState(() => _wrapWithScaffold = value);

  set wrapWithCenter(bool value) =>
      setState(() => _wrapWithCenter = value);

  set wrapWithSafeArea(bool value) =>
      setState(() => _wrapWithSafeArea = value);
      
  void toggleNavigationMenu() => setState(() =>
      _showNavigationMenu = !_showNavigationMenu);
  
  set wrapWithDevicePreview(bool value) =>
      setState(() => _wrapWithDevicePreview = value);

  @override
  Widget build(BuildContext context) {
    return ${_generateFramyAppBuildMethod(themeObjects, usesRiverpod)};
  }
}

class FramyAppSettings extends InheritedWidget {
  final bool wrapWithScaffold;
  final bool wrapWithCenter;
  final bool wrapWithSafeArea;
  final bool showNavigationMenu;
  final bool wrapWithDevicePreview;

  const FramyAppSettings({
    Key key,
    @required Widget child,
    @required this.wrapWithScaffold,
    @required this.wrapWithCenter,
    @required this.wrapWithSafeArea,
    @required this.showNavigationMenu,
    @required this.wrapWithDevicePreview,
  })  : assert(child != null),
        super(key: key, child: child);

  static FramyAppSettings of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FramyAppSettings>();
  }

  @override
  bool updateShouldNotify(FramyAppSettings old) =>
      old.wrapWithScaffold != wrapWithScaffold ||
      old.wrapWithCenter != wrapWithCenter ||
      old.wrapWithSafeArea != wrapWithSafeArea ||
      old.showNavigationMenu != showNavigationMenu ||
      old.wrapWithDevicePreview != wrapWithDevicePreview;
}
''';

String _generateFramyAppBuildMethod(
    List<FramyObject> themeObjects, bool usesRiverpod) {
  var framyAppBuild = ''' FramyAppSettings(
      wrapWithScaffold: _wrapWithScaffold,
      wrapWithCenter: _wrapWithCenter,
      wrapWithSafeArea: _wrapWithSafeArea,
      showNavigationMenu: _showNavigationMenu,
      wrapWithDevicePreview: _wrapWithDevicePreview,
      child: MaterialApp(
        key: Key('FramyApp'),
        debugShowCheckedModeBanner: false,
        ${generateThemeDataLine(themeObjects)}
        onGenerateRoute: onGenerateRoute,
      ),
    )
    ''';
  if (usesRiverpod) {
    framyAppBuild = 'ProviderScope(child: $framyAppBuild,)';
  }
  return framyAppBuild;
}

String generateThemeDataLine(List<FramyObject> themeObjects) {
  if (themeObjects.isEmpty) {
    return '';
  } else {
    final themeObject = themeObjects
        .firstWhere((object) => object.type == FramyObjectType.themeData);
    return 'theme: ${generateAccessibleElement(themeObject)},';
  }
}
