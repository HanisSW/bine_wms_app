import 'package:flutter/material.dart';
import 'package:wms_project/common/component/Inventory_item_bottom_sheet.dart';
import 'package:wms_project/model/inventory_item_list.dart';

class InventoryItems extends StatelessWidget {
  final InventoryItemList item;
  final VoidCallback onTap;

  const InventoryItems({Key? key, required this.item, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('NO: ${item.stockId ?? ''}', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('수량: ${item.quantity ?? ''}', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 4),
              Text('제품명: ${item.itemName ?? ''}'),
              SizedBox(height: 4),
              Text('창고: ${item.warehouseName ?? ''}'),
              SizedBox(height: 4),
              Text('업데이트 날짜: ${item.rdate ?? ''}'),
              SizedBox(height: 4),
              Text('앵글: ${item.angleName ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}