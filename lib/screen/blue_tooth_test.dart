
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wms_project/viewmodel/test_bluetooth_notifier.dart';

class BluetoothPage extends ConsumerStatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends ConsumerState<BluetoothPage> {



  List<BluetoothDevice> get filteredDevicesList {
    final devicesList = ref.watch(sppProvider).devicesList;
    return devicesList.where((device) {
      return (device.name ?? '').contains("HANIS");
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sppNotifier = ref.read(sppProvider.notifier);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.black54,
      titleTextStyle: TextStyle(color: Colors.white),
      title: Text("device_list"),
      content: Container(
        width: 150,
        height: 350,
        child: ListView.builder(
          itemCount: filteredDevicesList.length,
          itemBuilder: (context, index) {
            String displayName = filteredDevicesList[index].name?.replaceAll("spp", "").replaceAll("BLE", "").trim() ?? '';
            return ListTile(
              title: Text(
                displayName,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                filteredDevicesList[index].address,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // 연결 시도 전에 BLE 연결 해제
                // BleUtil.instance.ble_dispose(); // 이 부분은 필요에 따라 사용하세요.

                // 디바이스 연결
                sppNotifier.connectToDevice(filteredDevicesList[index]);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: sppNotifier.searchDevices,
          child: Text(
            "device_search",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "close",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ].request();
  }
}
