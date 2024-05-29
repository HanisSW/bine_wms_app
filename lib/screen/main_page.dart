import 'package:flutter/material.dart';
import 'package:wms_project/common/constants/colors.dart';
import 'package:wms_project/common/layouts/default_layout.dart';
import 'package:wms_project/screen/inven_move_page.dart';
import 'package:wms_project/screen/product_import_page.dart';
import 'package:wms_project/screen/product_release_page.dart';
import 'package:wms_project/screen/test_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
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
                    '입고',
                    Icons.add_box,
                    Colors.blue,
                    () => ProductImportPage(),
                  ),
                  _buildMenuButton(
                    context,
                    '출고',
                    Icons.outbox,
                    Colors.red,
                    () => ProductReleasePage(),
                  ),
                  _buildMenuButton(
                    context,
                    '재고 이동',
                    Icons.compare_arrows,
                    Colors.green,
                    () => InvenMovepage(),
                  ),
                  _buildMenuButton(
                    context,
                    '재고 입고',
                    Icons.storage,
                    Colors.orange,
                    () => TestPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuButton(BuildContext context, String title, IconData icon,
    Color color, Widget Function() pageBuilder) {
  return GestureDetector(
    onTap: () {
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
