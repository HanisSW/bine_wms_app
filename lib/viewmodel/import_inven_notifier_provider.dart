import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/inbound_instruction.dart';
import 'package:wms_project/utils/api_client.dart';

final importInvenProvider = StateNotifierProvider<ImportInvenNotifier, List<InboundInstruction?>>((ref) => ImportInvenNotifier());

class ImportInvenNotifier extends StateNotifier<List<InboundInstruction>>{

  ImportInvenNotifier() : super([]);

  late List<Map<String, dynamic>> _inboundData = [];
  late List<InboundInstruction> saveList = [];

   Future<dynamic> importInvenList(int page, int itemsPerPage, String searchStartDate, String searchEndDate) async {
    try{
      var response = await ApiClient().importInvenOrderDateCall(page, itemsPerPage,'STORE_EXPECTED_DATE', searchStartDate, searchEndDate, '0');
      print('${response.body?.data}');
      if(response.header?.resultCode == 200){
        if(page == 1){
          saveList = InboundInstruction.jsonToList(response.body?.data);
        }
        print("세이브리스트값");
        print(saveList.length);
        List<InboundInstruction> stockInstructionList = InboundInstruction.jsonToList(response.body?.data);
        state = [...state, ...stockInstructionList];
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

  void updateItem(int inboundId, int qty){
    _inboundData.add({'inbound_id': inboundId, 'inbound_quantity': qty});
    print(_inboundData);
  }

  void clearItem(){
    _inboundData = [];
  }

  List<Map<String, dynamic>> getModifiedData(){
    return _inboundData;
  }

  void forceUpdateQty(int inboundId, int qty) {
    state = [
      for (final item in state)
        if (item.inboundId == inboundId) item.copyWith(inboundQuantity: qty) else item
    ];
  }

  // 매칭하는거 까지 확인
  void checkBarcodeMatch(String barcode) {
     print('일단 실행?');
     print("$barcode");
     int count = 0;
    for (var item in state) {
      print(item.itemCode);
      if (item.itemCode.toString() == barcode) {
        count ++;
        // 일치하는 항목이 있으면 해당 항목을 선택
        item.inboundQuantity = (item.inboundQuantity ?? 0) + 1;
        print('일치함>????');
        print("Matched item: ${item.itemName}");
      }
    }
    state = List.from(state); // 상태 갱신
  }
}