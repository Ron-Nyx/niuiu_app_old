part of ready_step;

@view
class ReadyStep extends View<ReadyStepController> {
  ReadyStep._();

  @override
  Widget buildView(BuildContext context, ReadyStepController con, ViewDetails viewDetails) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// icon
          Container(
            height: 60,
            width: 60,
            child: SvgPicture.asset(
              'assets/svgs/bed_frame.svg',
              width: 60,
            ),
          ),

          /// title
          Container(
            child: Text(
              'Ready to begin',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: ThemeService.i.themeModel.textColor2,
              ),
            ),
            margin: EdgeInsets.only(top: 20),
          ),

          /// instructions
          Container(
            color: Colors.transparent,
            width: 600,
            child: Text(
              'Make sure the patient is ready and in bed before beginning the session',
              style: TextStyle(
                fontSize: 24,
                color: ThemeService.i.themeModel.textColor2,
                height: 1.7,
              ),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(top: 12),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
