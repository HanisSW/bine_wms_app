// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:wms_project/model/spp_state.dart';
//
// final sppProvider = StateNotifierProvider<SppNotifier, SppState>((ref) => SppNotifier());
//
// // StateNotifier 정의
// class SppNotifier extends StateNotifier<SppState> {
//   SppNotifier() : super(SppState());
//
//   final FlutterBluetoothSerial _sppBluetooth = FlutterBluetoothSerial.instance;
//   BluetoothConnection? sppConnection;
//   StreamSubscription<Uint8List>? _dataSubscription;
//   List<int> hexList = [];
//
//   Future<List<BluetoothDevice>> getPairedDevices() async {
//     List<BluetoothDevice> devices = await _sppBluetooth.getBondedDevices();
//     return devices;
//   }
//
//   void searchDevices() async {
//     List<BluetoothDevice> devices = await getPairedDevices();
//     state = state.copyWith(devicesList: devices);
//   }
//
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     state = state.copyWith(isConnected: false);
//     sppConnection = await BluetoothConnection.toAddress(device.address);
//     _dataSubscription = sppConnection?.input?.listen(
//           (Uint8List data) {
//         for (int i = 0; i < data.length; i++) {
//           var ch = data[i];
//           if (ch == 13) { // Carriage Return (CR) 문자
//             String convertBarcode = utf8.decode(hexList);
//             state = state.copyWith(convert: convertBarcode);
//             List<String> convertTextList = List.from(state.convertTextList)..add(convertBarcode);
//             print('$convertBarcode');
//             print('$convertTextList');
//             hexList.clear();
//             state = state.copyWith(convertTextList: convertTextList);
//           } else {
//             hexList.add(ch);
//           }
//         }
//       },
//       onDone: () {
//         state = state.copyWith(isConnected: false);
//       },
//       onError: (e) {
//         state = state.copyWith(isConnected: false);
//         print(e);
//       },
//     );
//     state = state.copyWith(deviceName: device.name ?? "", isConnected: true);
//   }
//
//   void disconnect() {
//     sppConnection?.close();
//     _dataSubscription?.cancel();
//     state = state.copyWith(isConnected: false, devicesList: [], deviceName: "", convertTextList: []);
//   }
//
//   void checkBluetoothState() async {
//     BluetoothState bluetoothState = await _sppBluetooth.state;
//     state = state.copyWith(bluetoothState: bluetoothState);
//   }
// }
//


import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:wms_project/model/spp_state.dart';
import 'package:wms_project/viewmodel/import_inven_notifier_provider.dart';

final sppProvider = StateNotifierProvider<SppNotifier, SppState>((ref) => SppNotifier(ref));

class SppNotifier extends StateNotifier<SppState> {
  final Ref ref;
  SppNotifier(this.ref) : super(SppState());

  final FlutterBluetoothSerial _sppBluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? sppConnection;
  StreamSubscription<Uint8List>? _dataSubscription;
  List<int> hexList = [];

  Future<List<BluetoothDevice>> getPairedDevices() async {
    List<BluetoothDevice> devices = await _sppBluetooth.getBondedDevices();
    return devices;
  }

  void searchDevices() async {
    List<BluetoothDevice> devices = await getPairedDevices();
    state = state.copyWith(devicesList: devices);
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    state = state.copyWith(isConnected: false);
    sppConnection = await BluetoothConnection.toAddress(device.address);
    _dataSubscription = sppConnection?.input?.listen(
          (Uint8List data) {
        for (int i = 0; i < data.length; i++) {
          var ch = data[i];
          if (ch == 13) { // Carriage Return (CR) 문자
            String convertBarcode = utf8.decode(hexList);
            state = state.copyWith(convert: convertBarcode);
            List<String> convertTextList = List.from(state.convertTextList)..add(convertBarcode);
            print('$convertBarcode');
            print('$convertTextList');
            hexList.clear();
            state = state.copyWith(convertTextList: convertTextList);

            // 바코드 데이터와 일치하는 항목이 있는지 확인
            ref.read(importInvenProvider.notifier).checkBarcodeMatch(convertBarcode);
          } else {
            hexList.add(ch);
          }
        }
      },
      onDone: () {
        state = state.copyWith(isConnected: false);
      },
      onError: (e) {
        state = state.copyWith(isConnected: false);
        print(e);
      },
    );
    state = state.copyWith(deviceName: device.name ?? "", isConnected: true);
  }

  void disconnect() {
    sppConnection?.close();
    _dataSubscription?.cancel();
    state = state.copyWith(isConnected: false, devicesList: [], deviceName: "", convertTextList: []);
  }

  void checkBluetoothState() async {
    BluetoothState bluetoothState = await _sppBluetooth.state;
    state = state.copyWith(bluetoothState: bluetoothState);
  }
}
