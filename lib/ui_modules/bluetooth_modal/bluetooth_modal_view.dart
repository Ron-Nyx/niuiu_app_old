part of bluetooth_modal;

@view
class BluetoothModal extends View<BluetoothModalController> {
  BluetoothModal._();

  @override
  Widget buildView(BuildContext context, BluetoothModalController con, ViewDetails viewDetails) {
    return Material(
      color: Colors.transparent,
      child: FlexContainer(
        width: 550,
        height: 600,
        decoration: BoxDecoration(
          color: Color.fromRGBO(20, 20, 20, 0.95),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ThemeService.i.themeModel.primaryColor,
            width: 1,
          ),
        ),
        child: StateConsumer<UnmodifiableListView<Device>?>(
          controller: con.discoveredDevicesStateController,
          builder: (context, discoveredDevices) {
            return StateConsumer<Device?>(
              controller: con.selectedDeviceStateController,
              builder: (context, selectedDevice) {
                bool anySelected = selectedDevice != null;
                return DA14531ConnectionBuilder(
                  module: (selectedDevice?.bluetooth as DA14531Module?),
                  builder: (context, connectionEvent) {
                    ConnectionPhase connectionPhase =
                        connectionEvent?.state.connectionPhase ?? ConnectionPhase.DISCONNECTED;
                    bool isConnecting = connectionPhase == ConnectionPhase.CONNECTING;
                    bool isConnected = connectionPhase == ConnectionPhase.CONNECTED;
                    bool isDisconnected = connectionPhase == ConnectionPhase.DISCONNECTED;
                    bool isDisconnecting = connectionPhase == ConnectionPhase.DISCONNECTING;
                    return Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Container(
                          //     color: Colors.transparent,
                          //     width: 30,
                          //     padding: EdgeInsets.all(0),
                          //     child: MaterialButton(
                          //       padding: EdgeInsets.all(0),
                          //       onPressed: () => con.exitModal(),
                          //       child: Icon(
                          //         Icons.clear,
                          //         size: 30,
                          //         color: ThemeService.i.themeModel.textColor2,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select a device',
                              style: TextStyle(
                                fontSize: 24,
                                color: ThemeService.i.themeModel.textColor2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: ThemeService.i.themeModel.textColor2,
                                  width: 1,
                                ),
                              ),
                              child: ListView.separated(
                                  itemCount: discoveredDevices!.length,
                                  itemBuilder: (context, index) {
                                    Device device = discoveredDevices[index];
                                    DA14531Module da14531Module = device.bluetooth as DA14531Module;
                                    bool isSelected = selectedDevice?.id == device.id;
                                    return Container(
                                      height: 50,
                                      color: Colors.transparent,
                                      child: MaterialButton(
                                        onPressed: () => con._onDeviceSelected(device),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        color: isSelected
                                            ? ThemeService.i.themeModel.primaryColor2.withOpacity(0.3)
                                            : Colors.transparent,
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Text(
                                            da14531Module.device.id,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: ThemeService.i.themeModel.textColor2,
                                            ),
                                          ),
                                          Text(
                                            da14531Module.bleDevice.address.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: ThemeService.i.themeModel.textColor2,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10);
                                  }),
                            ),
                          ),
                          Container(
                            height: 80,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 200,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SpinKitCircle(
                                        size: ScreenService.i.pixelRelHeight(50),
                                        color: ThemeService.i.themeModel.textColor2,
                                      ),
                                      StateConsumer<String>(
                                        controller: con.statusTextStateController,
                                        builder: (context, statusText) {
                                          String text = statusText.isNotEmpty ? statusText : 'Scanning...';
                                          return AutoSizeText(
                                            text,
                                            style: TextStyle(
                                              // fontSize: 18,
                                              color: ThemeService.i.themeModel.textColor2,
                                            ),
                                            maxLines: 2,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: 100,
                                        height: 47,
                                        child: MaterialButton(
                                          onPressed: (anySelected && isDisconnected)
                                              ? () => con._onConnectPressed(selectedDevice!)
                                              : null,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          color: ThemeService.i.themeModel.primaryColor,
                                          hoverColor: ThemeService.i.themeModel.primaryColor2,
                                          disabledColor: ThemeService.i.themeModel.disabledSurface,
                                          disabledTextColor: ThemeService.i.themeModel.disabledText,
                                          child: Center(
                                            child: Text(
                                              'Connect',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: anySelected
                                                    ? ThemeService.i.themeModel.textColor2
                                                    : ThemeService.i.themeModel.disabledText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: 100,
                                        height: 47,
                                        child: MaterialButton(
                                          onPressed: con.exitModal,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: BorderSide(
                                              color: ThemeService.i.themeModel.gray3,
                                              width: 1,
                                            ),
                                          ),
                                          color: ThemeService.i.themeModel.textColor2,
                                          disabledColor: ThemeService.i.themeModel.disabledSurface,
                                          disabledTextColor: ThemeService.i.themeModel.disabledText,
                                          child: Center(
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: ThemeService.i.themeModel.gray3,
                                              ),
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
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
