import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/export_date.dart';
import 'package:wms_project/utils/api_client.dart';

final exportDateProvider = StateNotifierProvider<ExportDateNotifier, List<ExportDate?>>((ref) => ExportDateNotifier());

class ExportDateNotifier extends StateNotifier<List<ExportDate?>>{
  ExportDateNotifier() : super([]);

  int _currentPage = 1;

  Future<void> exportDatePageCall(int page, int itemsPerPage) async {
    try {
      var response = await ApiClient().exportInvenDateAll(page, itemsPerPage, 'STORE_EXPECTED_DATE', '0');
      print("API Response: ${response.body?.data}");
      if (response.header?.resultCode == 200) {
        List<ExportDate> exportDates = ExportDate.jsonToList(response.body?.data);
        state = [...state, ...exportDates];
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

  Future<void> loadMoreData() async {
    _currentPage++;
    await exportDatePageCall(_currentPage, 15);
  }

  void clear(){
    state= [];
    _currentPage = 1;
  }
}