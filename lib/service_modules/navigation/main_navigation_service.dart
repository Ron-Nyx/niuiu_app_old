part of navigation;

class MainNavigationService extends base.NavigationService {
  static MainNavigationService i = MainNavigationService._();
  static const String INITIAL_ROUTE = MainRoutes.WELCOME;

  MainNavigationService._() : super(_routeMap);

  static Map<String, Widget Function([dynamic args])> _routeMap = {
    MainRoutes.WELCOME: ([dynamic args]) =>  $WelcomePage(controllerId: 'welcome_page'),
    MainRoutes.HOME: ([dynamic args]) => $HomePage(controllerId: 'home_page', device: args,),

    // MainRoutes.DEVICES: () =>  $DevicesPage(controllerId: DevicesPageController.NAME),
    // MainRoutes.SESSIONS: () =>  $SessionsPage(),
  };
}