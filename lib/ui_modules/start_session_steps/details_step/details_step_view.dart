part of details_step;

@view
class DetailsStep extends View<DetailsStepController> {
  DetailsStep._();

  @override
  Widget buildView(BuildContext context, DetailsStepController con, ViewDetails viewDetails) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start Session',
            style: TextStyle(
              fontSize: 24,
              color: ThemeService.i.themeModel.textColor2,
            ),
          ),
          SizedBox(height: 27),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Insert patient ID',
                  style: TextStyle(
                    fontSize: 16,
                    color: ThemeService.i.themeModel.textColor2,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 482,
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: ThemeService.i.themeModel.gray2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    autofocus: true,
                    controller: con._patientIdController,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: ThemeService.i.themeModel.textColor2),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Patient ID',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: ThemeService.i.themeModel.textColor2,
                      ),
                    ),
                      onChanged: con._onPatientIdChanged,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 27),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose a program',
                  style: TextStyle(
                    fontSize: 16,
                    color: ThemeService.i.themeModel.textColor2,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 482,
                  height: 70,
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: ThemeService.i.themeModel.gray2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: CustomDropdown<String>(
                      items:
                      sessionConfigurationMap.keys.where((name) => !['snr', 'sensitivity'].contains(name)).toList(),
                      initialItem: 'Sleep induction: Theta',
                      excludeSelected: true,
                      onChanged: con._onProgramSelected,
                      closedFillColor: ThemeService.i.themeModel.gray2,
                      expandedFillColor: ThemeService.i.themeModel.gray2,
                      headerBuilder: (BuildContext context, String result) {
                        return Text(
                          result.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeService.i.themeModel.textColor2,
                          ),
                        );
                      },
                      closedSuffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: ThemeService.i.themeModel.textColor2,
                        size: 32,
                      ),
                      expandedSuffixIcon: Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: ThemeService.i.themeModel.textColor2,
                        size: 32,
                      ),
                      listItemBuilder: (BuildContext context, String result) {
                        return Text(
                          result.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeService.i.themeModel.textColor2,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
