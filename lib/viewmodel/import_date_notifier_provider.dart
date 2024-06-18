import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/import_date.dart';
import 'package:wms_project/utils/api_client.dart';

final importDateProvider = StateNotifierProvider<ImportDateNotifier, List<ImportDate?>>((ref) => ImportDateNotifier());

class ImportDateNotifier extends StateNotifier<List<ImportDate?>>{
  ImportDateNotifier() : super([]);

  int _currentPage = 1;

  Future<void> importDatePageCall(int page, int itemsPerPage) async {
    try {
      var response = await ApiClient().importInvenDateAll(page, itemsPerPage, 'STORE_EXPECTED_DATE', '0');
      print("API Response: ${response.body?.data}");
      if (response.header?.resultCode == 200) {
        List<ImportDate> importDates = ImportDate.jsonToList(response.body?.data);
        state = [...state, ...importDates];
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
    await importDatePageCall(_currentPage, 15);
  }

  void clear(){
    state= [];
    _currentPage = 1;
  }
}