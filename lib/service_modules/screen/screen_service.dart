part of screen;

class ScreenService extends base.ScreenService with base.CustomScreenMixin {
  static ScreenService i = ScreenService._();
  ScreenService._();

  @override
  double get screenPhysicalWidthPixels => 800;
  @override
  double get screenPhysicalHeightPixels => 1280;
}