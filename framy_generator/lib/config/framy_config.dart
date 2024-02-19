class FramyConfig {
  /// Specified in FramyApp annotation
  bool? useDevicePreview;

  /// Specified in config yaml file
  /// wrap-with-devicepreview: true
  bool wrapWithDevicePreview = true;

  /// Specified in config yaml file
  /// wrap-with-scaffold: true
  bool wrapWithScaffold = true;

  /// Specified in config yaml file
  /// wrap-with-center: true
  bool wrapWithCenter = true;

  /// Specified in config yaml file
  /// wrap-with-safearea: true
  bool wrapWithSafeArea = true;

  /// Specified in config yaml file
  /// show-material-components: true
  bool showMaterialComponents = true;

  /// Specified in config yaml file
  /// show-storyboard: true
  bool showStoryboard = true;
}
