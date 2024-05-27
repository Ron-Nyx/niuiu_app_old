import 'package:ban_communication/ban_communication.dart';
import 'package:enums/enums.dart';

Map<String, SessionConfiguration Function([dynamic args])> sessionConfigurationMap = {
  'snr': ([dynamic args]) => SessionConfiguration(
    duration: Duration(milliseconds: 3),
    sensorChannels: storageFalseSensorChannels,
    analyzers: analyzerFiller([
      commonSnrAnalyzer,
    ]),
  ),
  'sensitivity': ([dynamic args]) => SessionConfiguration(
    duration: Duration(milliseconds: 3),
    sensorChannels: storageFalseSensorChannels,
    analyzers: analyzerFiller([
      Analyzer(
        analyzerType: AnalyzerType.STIMULATION_THRESHOLD,
        enable: true,
        channelNum: 3,
        bufferSize: 500,
        triggerSample: 0,
        repeat: false,
        priority: 1,
        metaData: [5000, 0, 0, 0, 0],
      ),
    ]),
  ),
  'Sleep induction: Theta': ([dynamic args]) => SessionConfiguration(
    duration: Duration(milliseconds: 3),
    sensorChannels: storageTrueSensorChannels,
    analyzers: analyzerFiller([
      commonSnrAnalyzer,
      Analyzer(
        analyzerType: AnalyzerType.DOMINANT_FREQUENCY,
        enable: true,
        channelNum: 1,
        bufferSize: 500,
        triggerSample: 500,
        repeat: true,
        priority: 1,
        metaData: [0, 0, 0, 0, 0],
      ),
      Analyzer(
        analyzerType: AnalyzerType.BASIC_STIMULATION,
        enable: true,
        channelNum: 3,
        bufferSize: 500,
        triggerSample: 0,
        repeat: false,
        priority: 1,
        metaData: [5000, args['maxStrengthPercentage'], args['stimulationStartTime'].inSeconds * 250, args['stimulationDuration'].inSeconds * 250, 0],
      )
    ]),
  ),
  'Sham': ([dynamic args]) => SessionConfiguration(
    duration: Duration(milliseconds: 3),
    sensorChannels: storageTrueSensorChannels,
    analyzers: analyzerFiller([
      commonSnrAnalyzer,
    ]),
  ),
};

Analyzer _emptyAnalyzer = Analyzer(
  analyzerType: AnalyzerType.values[0],
  enable: false,
  channelNum: 0,
  bufferSize: 0,
  triggerSample: 0,
  repeat: false,
  priority: 0,
  metaData: [0, 0, 0, 0, 0],
);

const int NUM_OF_ANALYZERS = 5;

List<Analyzer> analyzerFiller(List<Analyzer> analyzers) => (analyzers.length < NUM_OF_ANALYZERS)
    ? [
        ...analyzers,
        ...List.generate(NUM_OF_ANALYZERS - analyzers.length, (_) => _emptyAnalyzer),
      ]
    : analyzers;

Analyzer commonSnrAnalyzer = Analyzer(
  analyzerType: AnalyzerType.SNR,
  enable: true,
  channelNum: 1,
  bufferSize: 750,
  triggerSample: 250,
  repeat: true,
  priority: 1,
  metaData: [0, 0, 0, 0, 0],
);

List<SensorChannel> storageFalseSensorChannels = [
  SensorChannel(
    channelNum: 1,
    enable: true,
    gain: Gain.GAIN_24,
    srb2: true,
    mux: 0,
    storageEnable: false,
    notificationsEnable: true,
  ),
  SensorChannel(
    channelNum: 2,
    enable: false,
    gain: Gain.GAIN_1,
    srb2: false,
    mux: 0,
    storageEnable: false,
    notificationsEnable: true,
  ),
  SensorChannel(
    channelNum: 3,
    enable: true,
    gain: Gain.GAIN_1,
    srb2: false,
    mux: 0,
    storageEnable: false,
    notificationsEnable: true,
  ),
  SensorChannel(
    channelNum: 4,
    enable: true,
    gain: Gain.GAIN_1,
    srb2: false,
    mux: 0,
    storageEnable: false,
    notificationsEnable: true,
  ),
];

List<SensorChannel> storageTrueSensorChannels = [
  SensorChannel(
    channelNum: 1,
    enable: true,
    gain: Gain.GAIN_24,
    srb2: true,
    mux: 0,
    storageEnable: true,
    notificationsEnable: true,
  ),
  SensorChannel(
    channelNum: 2,
    enable: false,
    gain: Gain.GAIN_1,
    srb2: false,
    mux: 0,
    storageEnable: true,
    notificationsEnable: true,
  ),
  SensorChannel(
    channelNum: 3,
    enable: true,
    gain: Gain.GAIN_1,
    srb2: false,
    mux: 0,
    storageEnable: true,
    notificationsEnable: true,
  ),
  SensorChannel(
    channelNum: 4,
    enable: true,
    gain: Gain.GAIN_1,
    srb2: false,
    mux: 0,
    storageEnable: true,
    notificationsEnable: true,
  ),
];
