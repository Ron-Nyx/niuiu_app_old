part of app_bar_module;

@controller
class AppBarController extends Controller with _$AppBarControllerMixin {

  AppBarController._();

  bool black = true;

  void _onIconPressed() {
    if (black) {
      windowManager.setIcon('assets\\icons\\niura_logo_red.ico');
      windowManager.setTitle('niura (session in progress)');
      black = false;
    } else {
      windowManager.setIcon('assets\\icons\\niura_logo_black.ico');
      windowManager.setTitle('niura');
      black = true;
    }
  }
}
