part of background;

@view
class Background extends View<BackgroundController> {
  Background._();

  @override
  Widget buildView(BuildContext context, BackgroundController con, ViewDetails viewDetails) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: ThemeService.i.themeModel.backgroundColor,
          ),
        ),
      ],
    );
  }
}
