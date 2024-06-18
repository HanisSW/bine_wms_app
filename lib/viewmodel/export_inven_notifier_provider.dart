import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/outbound_instruction.dart';
import 'package:wms_project/utils/api_client.dart';

final exportInvenProvider = StateNotifierProvider<ExportInvenNotifier, List<OutboundInstruction?>>((ref) => ExportInvenNotifier());

class ExportInvenNotifier extends StateNotifier<List<OutboundInstruction>> {
  ExportInvenNotifier() : super([]);

  late List<Map<String, dynamic>> _outboundData = [];
  late List<OutboundInstruction> saveList = [];


  Future<dynamic> exportInvenList(int page, int itemsPerPage, String searchStartDate, String searchEndDate) async {
    try{
      var response = await ApiClient().exportInvenOrderDateCall(page, itemsPerPage,'STORE_EXPECTED_DATE', searchStartDate, searchEndDate, '0');
      print('${response.body?.data}');
      if(response.header?.resultCode == 200){
        if(page == 1){
          saveList = OutboundInstruction.jsonToList(response.body?.data);
        }
        List<OutboundInstruction> stockList = OutboundInstruction.jsonToList(response.body?.data);
        state = [...state, ...stockList];
        print('state값 확인');
        print(state);
      }else{
        print("API Error: ${response.header?.resultCode}");
      }
      return response;
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("Stack Trace: $stackTrace");
      state = [];
    }
  }


  void saveResetData(){
    state = saveList;
  }

  // state == saveList (처음 호춣 됐을때 기본 상태)
  // state != saveList (수정 사항이 있음)
  Future<bool> backCheckBool() async{
    if (!listEquals(state, saveList)) {
      print('Current state: ${state.toString()}');
      print('Save list: ${saveList.toString()}');
      return true;
    }else{
      return false;
    }
  }

  void clear(){
    state= [];
  }

  void updateItem(int code, int qty){
    _outboundData.add({'outbound_id': code, 'outbound_quantity': qty});
  }

  void clearItem(){
    _outboundData = [];
  }

  List<Map<String, dynamic>> getModifiedData(){
    return _outboundData;
  }

  void forceUpdateQty(int outboundId, int qty) {
    state = [
      for (final item in state)
        if (item.outboundId == outboundId) item.copyWith(outboundQuantity: qty) else item
    ];
  }


}