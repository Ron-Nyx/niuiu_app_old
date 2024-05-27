part of start_session_modal;

@view
class StartSessionModal extends View<StartSessionModalController> {
  StartSessionModal._();

  @override
  Widget buildView(BuildContext context, StartSessionModalController con, ViewDetails viewDetails) {
    return Material(
      color: Colors.transparent,
      child: FlexContainer(
        width: 775,
        height: 500,
        decoration: BoxDecoration(
          color: ThemeService.i.themeModel.gray1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: StateConsumer<Step>(
          controller: con.stepStateController,
          transitionDuration: Duration(milliseconds: 300),
          builder: (BuildContext context, Step step) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => con.exitModal(false),
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.clear,
                          size: 30,
                          color: ThemeService.i.themeModel.textColor2,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 43, right: 30),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: con._getStepWidget(step),
                    ),
                  ),
                )),
                StateConsumer<bool>(
                  controller: con.showNextButtonStateController,
                  builder: (context, show) {
                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: show
                            ? StateConsumer<bool>(
                                controller: con.enableNextButtonStateController,
                                builder: (context, enabled) {
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Container(
                                        width: 93,
                                        height: 47,
                                        child: MaterialButton(
                                          onPressed: enabled ? con._onNextPressed : null,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          color: ThemeService.i.themeModel.primaryColor,
                                          textColor: enabled ? ThemeService.i.themeModel.textColor2 : ThemeService.i.themeModel.disabledText,
                                          hoverColor: ThemeService.i.themeModel.primaryColor2,
                                          disabledColor: ThemeService.i.themeModel.disabledSurface,
                                          disabledTextColor: ThemeService.i.themeModel.disabledText,
                                          child: Center(
                                            child: Text(
                                              step.isLast ? 'Done' : 'Next',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : SizedBox());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
