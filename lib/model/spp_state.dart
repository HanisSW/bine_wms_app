import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SppState {
  final bool isConnected;
  final String deviceName;
  final List<BluetoothDevice> devicesList;
  final String convert;
  final List<String> convertTextList;
  final BluetoothState bluetoothState;

  SppState({
    this.isConnected = false,
    this.deviceName = '',
    this.devicesList = const [],
    this.convert = '',
    this.convertTextList = const [],
    this.bluetoothState = BluetoothState.UNKNOWN,
  });

  SppState copyWith({
    bool? isConnected,
    String? deviceName,
    List<BluetoothDevice>? devicesList,
    String? convert,
    List<String>? convertTextList,
    BluetoothState? bluetoothState,
  }) {
    return SppState(
      isConnected: isConnected ?? this.isConnected,
      deviceName: deviceName ?? this.deviceName,
      devicesList: devicesList ?? this.devicesList,
      convert: convert ?? this.convert,
      convertTextList: convertTextList ?? this.convertTextList,
      bluetoothState: bluetoothState ?? this.bluetoothState,
    );
  }
}