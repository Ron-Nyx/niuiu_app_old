part of navigation;

class RootNavigationService extends base.NavigationService {
  static RootNavigationService i = RootNavigationService._();

  RootNavigationService._() : super(_routeMap);

  static Map<String, Widget Function([dynamic args])> _routeMap = {

  };
}