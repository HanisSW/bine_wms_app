import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/warehouse_angle_list.dart';
import 'package:wms_project/utils/api_client.dart';

final warehouseAngleListProvider = StateNotifierProvider<WarehouseAngleListNotifier, List<WarehouseAngleList>>((ref) => WarehouseAngleListNotifier());

class WarehouseAngleListNotifier extends StateNotifier<List<WarehouseAngleList>> {
  WarehouseAngleListNotifier() : super([]);


  Future<void> getWarehouseAngle() async {
    try {
      var response = await ApiClient().getWarehouseAngle();
      print('${response.body?.data}');
      if (response.header?.resultCode == 200) {
        state = WarehouseAngleList.jsonToList(response.body?.data);
        print('state값 확인');
        print(state);
      } else {
        print("API Error: ${response.header?.resultCode}");
      }
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("Stack Trace: $stackTrace");
      state = [];
    }
  }

  }