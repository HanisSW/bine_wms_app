import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/inventory_item_list.dart';
import 'package:wms_project/utils/api_client.dart';
import 'package:wms_project/viewmodel/inven_item_list_notifier_provider.dart';
import 'package:wms_project/viewmodel/warehouse_angle_list_notifier_provider.dart';

class InventoryItemBottomSheet extends ConsumerStatefulWidget {
  final InventoryItemList item;

  const InventoryItemBottomSheet({Key? key, required this.item}) : super(key: key);

  @override
  _InventoryItemBottomSheetState createState() => _InventoryItemBottomSheetState();
}

class _InventoryItemBottomSheetState extends ConsumerState<InventoryItemBottomSheet> {
  String selectedWarehouse = '';
  String selectedAngle = '';
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    ref.read(warehouseAngleListProvider.notifier).getWarehouseAngle();
    quantityController = TextEditingController();
    selectedWarehouse = '';
    selectedAngle = '';
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final warehouseAngleList = ref.watch(warehouseAngleListProvider);
    final warehouseNames = warehouseAngleList.map((e) => e.warehouseName!).toSet().toList();

    List<String> getAngleNames(String warehouse) {
      return warehouseAngleList
          .where((e) => e.warehouseName == warehouse)
          .map((e) => e.angleName!)
          .toSet()
          .toList();
    }

    int getWarehouseId(String warehouse) {
      return warehouseAngleList.firstWhere((e) => e.warehouseName == warehouse).warehouseId!;
    }

    int getAngleId(String angle) {
      return warehouseAngleList.firstWhere((e) => e.angleName == angle).angleId!;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('앵글로 제품 이동', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedWarehouse.isEmpty ? null : selectedWarehouse,
              decoration: InputDecoration(labelText: '창고 선택'),
              items: warehouseNames.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedWarehouse = newValue;
                    selectedAngle = '';
                  });
                }
              },
            ),
            if (selectedWarehouse.isNotEmpty)
              DropdownButtonFormField<String>(
                value: selectedAngle.isEmpty ? null : selectedAngle,
                decoration: InputDecoration(labelText: '앵글 선택'),
                items: getAngleNames(selectedWarehouse).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAngle = newValue;
                    });
                  }
                },
              ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: '수량',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업창 닫기
                  },
                  child: Text('취소'),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    int warehouseId = getWarehouseId(selectedWarehouse);
                    int angleId = getAngleId(selectedAngle);
                    int quantity = int.tryParse(quantityController.text) ?? 0;
                    // 데이터를 원하는 대로 사용
                    print('Selected Warehouse ID: $warehouseId');
                    print('Selected Angle ID: $angleId');
                    print('Quantity: $quantity');
                    ApiClient().sendInvenMoveData(widget.item.stockId.toString(), warehouseId.toString(), angleId.toString(), quantityController.text);
                    await ref.read(invenListProvider.notifier).getInvenList(1, 15, '', '', '', '');
                    Navigator.of(context).pop();
                  },
                  child: Text('앵글로 이동완료'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}