part of home_page;

@view
class HomePage extends View<HomePageController> {
  HomePage._();

  @override
  Widget buildView(BuildContext context, HomePageController con, ViewDetails viewDetails) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 133),
      child: StateConsumer<SessionPhase>(
        controller: con.sessionPhaseStateController,
        builder: (context, sessionPhase) {
          bool isSessionInProgress = sessionPhase == SessionPhase.IN_PROGRESS;
          return Column(
            children: [
              Container(height: 100),
              Container(
                height: 613,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ThemeService.i.themeModel.gray1,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: ThemeService.i.themeModel.gray2,
                                          width: 1,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(25),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 36,
                                            child: Text(
                                              'Press the start session button to initiate a new session',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: ThemeService.i.themeModel.textColor2,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Container(
                                                width: 155,
                                                height: 47,
                                                child: MaterialButton(
                                                  onPressed: isSessionInProgress ? null : con._onStartSessionPressed,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  color: ThemeService.i.themeModel.primaryColor,
                                                  hoverColor: ThemeService.i.themeModel.primaryColor2,
                                                  disabledColor: ThemeService.i.themeModel.disabledSurface,
                                                  child: Center(
                                                    child: Text(
                                                      'Start session',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: isSessionInProgress
                                                            ? ThemeService.i.themeModel.disabledText
                                                            : ThemeService.i.themeModel.textColor2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                width: 155,
                                                height: 47,
                                                child: MaterialButton(
                                                  onPressed: isSessionInProgress ? con._onStopSessionPressed : null,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  color: ThemeService.i.themeModel.stopColor1,
                                                  hoverColor: ThemeService.i.themeModel.stopColor2,
                                                  disabledColor: ThemeService.i.themeModel.disabledSurface,
                                                  child: Center(
                                                    child: Text(
                                                      'Stop session',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: isSessionInProgress
                                                            ? ThemeService.i.themeModel.textColor2
                                                            : ThemeService.i.themeModel.disabledText,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Expanded(
                                    flex: 27,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ThemeService.i.themeModel.gray1,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: ThemeService.i.themeModel.gray2,
                                          width: 1,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Patient ID',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor1,
                                                  ),
                                                ),
                                                Text(
                                                  isSessionInProgress ? con.patientId ?? 'N/A' : 'N/A',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Device',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor1,
                                                  ),
                                                ),
                                                Text(
                                                  con.device?.id ?? 'N/A',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ThemeService.i.themeModel.gray1,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: ThemeService.i.themeModel.gray2,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Status',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: ThemeService.i.themeModel.textColor1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 17),
                                    child: Divider(
                                      color: ThemeService.i.themeModel.gray2,
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Connection status',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor1,
                                                  ),
                                                ),
                                                StateConsumer<DA14531ConnectionEvent>(
                                                  controller: con.da14531Module!.connectionEventStateController,
                                                  builder: (context, connectionEvent) {
                                                    return Text(
                                                      convert<ConnectionPhase, String>(
                                                              connectionEvent.state.connectionPhase)!
                                                          .titleCase,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ThemeService.i.themeModel.textColor2,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Battery level',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor1,
                                                  ),
                                                ),
                                                StateConsumer(
                                                  controller: con.batteryStateController,
                                                  builder: (context, battery) {
                                                    Color textColor;
                                                    if (battery <= 50) {
                                                      textColor = Color.lerp(
                                                          Color(0xFFFD6A4E), Color(0xFFE1C16E), battery / 50)!;
                                                    } else {
                                                      textColor = Color.lerp(
                                                          Color(0xFFE1C16E), Color(0xFF3ED598), (battery - 50) / 50)!;
                                                    }
                                                    return Text(
                                                      '$battery%',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: textColor,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Firmware version',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor1,
                                                  ),
                                                ),
                                                Text(
                                                  '1.9.0',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Session state',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor1,
                                                  ),
                                                ),
                                                Text(
                                                  isSessionInProgress ? 'In Progress' : 'Idle',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Session run time',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeService.i.themeModel.textColor1,
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.transparent,
                                                  width: 100,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: StopWatch(
                                                      controller: con.stopWatchController,
                                                      fromUnit: StopWatchTimeUnit.HOURS,
                                                      toUnit: StopWatchTimeUnit.SECONDS,
                                                      defaultLeadingDigits: 2,
                                                      textStyle: TextStyle(
                                                        fontSize: 16,
                                                        color: ThemeService.i.themeModel.textColor2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ThemeService.i.themeModel.gray1,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: ThemeService.i.themeModel.gray2,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'List of Device Events',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: ThemeService.i.themeModel.textColor1,
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: con._clearLogs,
                                        elevation: 0,
                                        child: Center(
                                          child: Text(
                                            'Clear logs',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: ThemeService.i.themeModel.primaryColor2,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 17),
                                    child: Divider(
                                      color: ThemeService.i.themeModel.gray2,
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: StateConsumer<List<String>>(
                                      controller: con.logsStateController,
                                      builder: (context, sessionEvents) {
                                        return Container(
                                          child: ListView.builder(
                                            controller: con._scrollController,
                                            itemCount: sessionEvents.length,
                                            itemBuilder: (context, i) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(vertical: 2),
                                                child: Text(
                                                  sessionEvents[i],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: ThemeService.i.themeModel.textColor2,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                    SizedBox(height: 25),
                    Expanded(
                      flex: 1,
                      child: StateConsumer<bool>(
                        controller: con.liveGraphController.isListeningDataStateController,
                        builder: (context, liveDataEnabled) {
                          return StateConsumer<GraphBooleans>(
                            controller: con.liveGraphController.displayGraphsStateController,
                            builder: (context, displays) {
                              bool rawDisplayed = displays.raw;
                              bool thetaBandPassDisplayed = displays.thetaBandPass;
                              return Container(
                                decoration: BoxDecoration(
                                  color: ThemeService.i.themeModel.gray1,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ThemeService.i.themeModel.gray2,
                                    width: 1,
                                  ),
                                ),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Live data',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: ThemeService.i.themeModel.textColor1,
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 128,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: ThemeService.i.themeModel.gray2,
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 20,
                                                        height: 12,
                                                        child: IgnorePointer(
                                                          ignoring: !isSessionInProgress,
                                                          child: AnimatedSwitch(
                                                            turnState: liveDataEnabled,
                                                            width: 20,
                                                            height: 12,
                                                            backgroundColorOn: ThemeService.i.themeModel.primaryColor,
                                                            backgroundColorOff: ThemeService.i.themeModel.gray3,
                                                            switchColorOn: ThemeService.i.themeModel.textColor2,
                                                            switchColorOff: ThemeService.i.themeModel.textColor1,
                                                            onChanged: con._onLiveDataSwitchToggle,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Live data on',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: isSessionInProgress
                                                              ? ThemeService.i.themeModel.textColor2
                                                              : ThemeService.i.themeModel.disabledText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Container(
                                                  width: 128,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: ThemeService.i.themeModel.gray2,
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 20,
                                                        height: 12,
                                                        child: IgnorePointer(
                                                          ignoring: !isSessionInProgress,
                                                          child: AnimatedSwitch(
                                                            turnState: liveDataEnabled && rawDisplayed,
                                                            width: 20,
                                                            height: 12,
                                                            backgroundColorOn: ThemeService.i.themeModel.primaryColor,
                                                            backgroundColorOff: ThemeService.i.themeModel.gray3,
                                                            switchColorOn: ThemeService.i.themeModel.textColor2,
                                                            switchColorOff: ThemeService.i.themeModel.textColor1,
                                                            onChanged: con._onRawSwitchToggle,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Raw',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: isSessionInProgress
                                                              ? ThemeService.i.themeModel.textColor2
                                                              : ThemeService.i.themeModel.disabledText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Container(
                                                  width: 128,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: ThemeService.i.themeModel.gray2,
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 20,
                                                        height: 12,
                                                        child: IgnorePointer(
                                                          ignoring: !isSessionInProgress,
                                                          child: AnimatedSwitch(
                                                            turnState: liveDataEnabled && thetaBandPassDisplayed,
                                                            width: 20,
                                                            height: 12,
                                                            backgroundColorOn: ThemeService.i.themeModel.primaryColor,
                                                            backgroundColorOff: ThemeService.i.themeModel.gray3,
                                                            switchColorOn: ThemeService.i.themeModel.textColor2,
                                                            switchColorOff: ThemeService.i.themeModel.textColor1,
                                                            onChanged: con._onThetaBandPassSwitchToggle,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Theta Filter',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: isSessionInProgress
                                                              ? ThemeService.i.themeModel.textColor2
                                                              : ThemeService.i.themeModel.disabledText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Container(
                                                  width: 243,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: ThemeService.i.themeModel.gray2,
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: StreamBuilder<SignalStatus>(
                                                    stream: con.device?.session.getSignalStatusStream(),
                                                    initialData: SignalStatus.IDLE,
                                                    builder: (context, snapshot) {
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                isSessionInProgress
                                                                    ? AnimatedSwitcher(
                                                                        duration: Duration(milliseconds: 400),
                                                                        child: <SignalStatus, Widget>{
                                                                          SignalStatus.IDLE: SolidIndicatorWidget(
                                                                            key: UniqueKey(),
                                                                            color:
                                                                                ThemeService.i.themeModel.disabledText,
                                                                            size: 8,
                                                                            innerFactor: 1,
                                                                          ),
                                                                          SignalStatus.BAD: SolidIndicatorWidget(
                                                                            key: UniqueKey(),
                                                                            color: Color(0xFFFE6C6C),
                                                                            size: 8,
                                                                            innerFactor: 1,
                                                                          ),
                                                                          SignalStatus.STABILIZING:
                                                                              BlinkingIndicatorWidget(
                                                                            key: UniqueKey(),
                                                                            duration: Duration(milliseconds: 1200),
                                                                            end: 0.5,
                                                                            color: Color(0xFF3ED598),
                                                                            size: 8,
                                                                            innerFactor: 1,
                                                                            // margin: margin,
                                                                          ),
                                                                          SignalStatus.STABLE: SolidIndicatorWidget(
                                                                            key: UniqueKey(),
                                                                            color: Color(0xFF3ED598),
                                                                            size: 8,
                                                                            innerFactor: 1,
                                                                          ),
                                                                        }[snapshot.data]!,
                                                                      )
                                                                    : SolidIndicatorWidget(
                                                                        key: UniqueKey(),
                                                                        color: ThemeService.i.themeModel.disabledText,
                                                                        size: 8,
                                                                        innerFactor: 1,
                                                                      ),
                                                                SizedBox(width: 8),
                                                                Text(
                                                                  'Sensors signal quality',
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: isSessionInProgress
                                                                        ? ThemeService.i.themeModel.textColor2
                                                                        : ThemeService.i.themeModel.disabledText,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          isSessionInProgress
                                                              ? Text(
                                                                  <SignalStatus, String>{
                                                                    SignalStatus.IDLE: 'N/A',
                                                                    SignalStatus.BAD: 'Unstable',
                                                                    SignalStatus.STABILIZING: 'Stabilizing',
                                                                    SignalStatus.STABLE: 'Stable',
                                                                  }[snapshot.data!]!,
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: <SignalStatus, Color>{
                                                                        SignalStatus.IDLE:
                                                                            ThemeService.i.themeModel.disabledText,
                                                                        SignalStatus.BAD: Color(0xFFFE6C6C),
                                                                        SignalStatus.STABILIZING: Color(0xFF3ED598),
                                                                        SignalStatus.STABLE: Color(0xFF3ED598),
                                                                      }[snapshot.data!]!),
                                                                )
                                                              : Text(
                                                                  'N/A',
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: ThemeService.i.themeModel.disabledText,
                                                                  ),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30.5),
                                    Expanded(
                                      child: $LiveGraph.fromController(con.liveGraphController),

                                      // AnimatedSwitcher(
                                      //   duration: const Duration(milliseconds: 150),
                                      //   child: liveDataEnabled
                                      //       ? $LiveGraph.fromController(con.liveGraphController)
                                      //       : Container(
                                      //           key: UniqueKey(),
                                      //         ),
                                      // ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
