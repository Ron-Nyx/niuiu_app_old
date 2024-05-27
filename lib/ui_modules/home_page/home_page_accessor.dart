part of home_page;

mixin HomePageAccessor {
  HomePageController get homePageController => $HomePage.getControllerWhere((c) => true);
  Device? get device => homePageController.device;
  DA14531Module? get da14531Module => device?.bluetooth as DA14531Module?;
}
