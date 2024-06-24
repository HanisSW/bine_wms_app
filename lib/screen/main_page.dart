import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wms_project/common/constants/colors.dart';
import 'package:wms_project/common/layouts/default_layout.dart';
import 'package:wms_project/screen/blue_tooth_test.dart';
import 'package:wms_project/screen/inven_move_page.dart';
import 'package:wms_project/screen/prepare_export_page.dart';
import 'package:wms_project/screen/prepare_import_page.dart';
import 'package:wms_project/screen/bottom_sheet_test_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  DateTime? prePressTime;

  Future<bool> onWillPop() {
    var isExist = false;
    if (prePressTime == null) {
      prePressTime = DateTime.now();
    } else {
      final timeGap = DateTime.now().difference(prePressTime!);
      isExist = timeGap <= Duration(milliseconds: 1500);
      prePressTime = DateTime.now();
    }
    if (!isExist) {
      Fluttertoast.showToast(
        msg: "앱을 종료하려면 한 번 더 누르세요.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: DefaultLayout(
        backgroundColor: BG_COLOR,
        isMain: true,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '입출고 관리 시스템',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildMenuButton(
                      context,
                      ref,
                      '입고',
                      Icons.add_box,
                      Colors.blue,
                          () => PrepareImportPage(),
                    ),
                    _buildMenuButton(
                      context,
                      ref,
                      '출고',
                      Icons.outbox,
                      Colors.red,
                          () => PrepareExportPage(),
                    ),
                    _buildMenuButton(
                      context,
                      ref,
                      '재고 이동',
                      Icons.storage,
                      Colors.green,
                          () => InvenMovePage(),
                    ),
                    _buildMenuButton(
                      context,
                      ref,
                      '블루투스 설정',
                      Icons.bluetooth,
                      Colors.orange,
                          () => BluetoothPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMenuButton(BuildContext context, WidgetRef ref, String title, IconData icon,
    Color color, Widget Function() pageBuilder) {
  return GestureDetector(
    onTap: () async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageBuilder()),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}