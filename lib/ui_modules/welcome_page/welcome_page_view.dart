part of welcome_page;

@view
class WelcomePage extends View<WelcomePageController> {
  WelcomePage._();

  @override
  Widget buildView(BuildContext context, WelcomePageController con, ViewDetails viewDetails) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(left: 133),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 275,
                    height: 172,
                    color: Colors.transparent,
                    child: Text(
                      'Welcome,\nto start a session please select a device',
                      style: TextStyle(fontSize: 33, color: ThemeService.i.themeModel.textColor2),
                    ),
                  ),
                  SizedBox(height: 56),
                  Container(
                    width: 375,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: ThemeService.i.themeModel.primaryColor,
                        width: 1,
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: con._onSelectDevicePressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select a device',
                              style: TextStyle(fontSize: 18, color: ThemeService.i.themeModel.textColor2),
                            ),
                            Icon(
                              Icons.navigate_next,
                              size: 32,
                              color: ThemeService.i.themeModel.textColor2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/images/niura75333.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ]),
    );
  }
}
