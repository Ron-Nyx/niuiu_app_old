part of app_bar_module;

@view
class AppBar extends View<AppBarController> {
  AppBar._();

  @override
  Widget buildView(BuildContext context, AppBarController con, ViewDetails viewDetails) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 133),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            /// logo
            GestureDetector(
              onTap: con._onIconPressed,
              child: Container(
                width: 34,
                child: SvgPicture.asset(
                  'assets/svgs/niura_logo.svg',
                  // fit: BoxFit.fitHeight,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
