import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/inventory_item_list.dart';
import 'package:wms_project/utils/api_client.dart';

final invenListProvider = StateNotifierProvider<InvenItemListNotifier, List<InventoryItemList>>((ref) => InvenItemListNotifier());

class InvenItemListNotifier extends StateNotifier<List<InventoryItemList>> {
  InvenItemListNotifier() : super([]);

  int _currentPage = 1;

  Future<void> getInvenList(int page, int itemsPerPage, String searchType, String keyword, String searchStartDate, String searchEndDate) async {
    try {
      var response = await ApiClient().getInventoryList(page, itemsPerPage, searchType, keyword, 'STORE_EXPECTED_DATE', searchStartDate, searchEndDate);
      print('${response.body?.data}');
      if (response.header?.resultCode == 200) {
        List<InventoryItemList> invenList = InventoryItemList.jsonToList(response.body?.data);
        if (page == 1) {
          state = invenList;  // 첫 페이지일 때는 상태를 초기화
        } else {
          state = [...state, ...invenList];  // 첫 페이지가 아닐 때는 기존 데이터에 추가
        }
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

  Future<void> loadMoreData() async {
    _currentPage++;
    await getInvenList(_currentPage, 15, '', '', '', '');
  }

  void clear(){
    state= [];
    _currentPage = 1;
  }

}

