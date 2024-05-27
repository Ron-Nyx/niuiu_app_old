part of welcome_page;

@controller
class WelcomePageController extends Controller with _$WelcomePageControllerMixin {
  WelcomePageController._();

  @override
  void onInit() async {

  }

  void _onSelectDevicePressed() =>
      RootNavigationService.i.showDialog(builder: (BuildContext context) => $BluetoothModal());
}
