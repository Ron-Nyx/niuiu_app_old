part of start_session_loading;

@view
class StartSessionLoading extends View<StartSessionLoadingController> {
  StartSessionLoading._();

  @override
  Widget buildView(BuildContext context, StartSessionLoadingController con, ViewDetails viewDetails) {
    return Center(
      child: SpinKitCircle(
        size: 150,
        color: ThemeService.i.themeModel.textColor2,
      ),
    );
  }
}
