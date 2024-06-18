import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/common/component/Inbound_item.dart';
import 'package:wms_project/common/component/custom_snackbar.dart';
import 'package:wms_project/common/layouts/default_layout.dart';
import 'package:wms_project/utils/api_client.dart';
import 'package:wms_project/viewmodel/import_date_notifier_provider.dart';
import 'package:wms_project/viewmodel/import_inven_notifier_provider.dart';
import 'package:wms_project/viewmodel/user_notifier_provider.dart';

class ImportInvenPage extends ConsumerStatefulWidget {
  final String planDate;

  const ImportInvenPage({Key? key, required this.planDate}) : super(key: key);

  @override
  _ImportInvenPageState createState() => _ImportInvenPageState();
}

class _ImportInvenPageState extends ConsumerState<ImportInvenPage> {
  late List<InboundItemData> inboundItems;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadData() async {
    final response = await ref
        .read(importInvenProvider.notifier)
        .importInvenList(1, 100, widget.planDate, widget.planDate);
    if (response.header?.codeName == "SUCCESS_ZERO") {
      CustomSnackBar.show(context, '모든 입고처리가 완료 되었습니다', Colors.black87);
      Future.delayed(Duration(seconds: 2), () async {
        ref.read(importInvenProvider.notifier).clear();
        await ref.read(importDateProvider.notifier).importDatePageCall(1, 15);
        Navigator.of(context).pop();
      });
    }
  }


  // void _showDialog(BuildContext context, InboundItemData item) {
  //   TextEditingController qtyController = TextEditingController();
  //   bool isPositive = true;
  //
  //   qtyController.addListener(() {
  //     final inputText = qtyController.text;
  //     final parsedValue = int.tryParse(inputText);
  //     if (parsedValue == null && inputText.isNotEmpty) {
  //       qtyController.clear();
  //     } else if (parsedValue != null && parsedValue.abs() > (item.inboundQty - item.qty)) {
  //       qtyController.clear();
  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('입고 수량은 필요 수량을 초과할 수 없습니다.'),
  //           backgroundColor: Colors.red,
  //           duration: Duration(milliseconds: 500),
  //         ),
  //       );
  //     }
  //   });
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             titlePadding: EdgeInsets.all(0),
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Text('입고 처리'),
  //                 ),
  //                 IconButton(
  //                   icon: Image.asset('assets/images/deleteIcon.png'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text('총 예정 수량: ${item.inboundQty}'),
  //                 Text('입고 된 수량 : ${item.qty}'),
  //                 SizedBox(height: 20),
  //                 Row(
  //                   children: [
  //                     ToggleButtons(
  //                       children: [Text('+'), Text('-')],
  //                       isSelected: [isPositive, !isPositive],
  //                       onPressed: (int index) {
  //                         setState(() {
  //                           isPositive = index == 0;
  //                           // - 토글 상태 변경시 텍스트 필드 업데이트
  //                           final currentValue = qtyController.text;
  //                           if (currentValue.isNotEmpty) {
  //                             final parsedValue = int.tryParse(currentValue) ?? 0;
  //                             qtyController.value = TextEditingValue(
  //                               text: isPositive
  //                                   ? parsedValue.abs().toString()
  //                                   : (-parsedValue.abs()).toString(),
  //                               selection: TextSelection.fromPosition(
  //                                 TextPosition(offset: qtyController.text.length),
  //                               ),
  //                             );
  //                           }
  //                         });
  //                       },
  //                     ),
  //                     SizedBox(width: 10),
  //                     Expanded(
  //                       child: TextField(
  //                         controller: qtyController,
  //                         keyboardType: TextInputType.number,
  //                         decoration: InputDecoration(
  //                           labelText: '수량',
  //                         ),
  //                         onChanged: (value) {
  //                           final parsedValue = int.tryParse(value);
  //                           if (parsedValue != null) {
  //                             final newValue = isPositive ? value : '-$value';
  //                             qtyController.value = TextEditingValue(
  //                               text: newValue,
  //                               selection: TextSelection.fromPosition(
  //                                 TextPosition(offset: newValue.length),
  //                               ),
  //                             );
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   final inputText = qtyController.text;
  //                   final parsedValue = int.tryParse(inputText) ?? 0;
  //                   ref.read(importInvenProvider.notifier).updateItem(
  //                     int.tryParse(item.inboundId ?? '0')!,
  //                     parsedValue,
  //                   );
  //                   int newQty = item.qty + parsedValue;
  //                   _forceUpdateQty(item.inboundId, newQty);
  //                   Navigator.of(context).pop(); // 팝업창 닫기
  //                 },
  //                 child: Text('입고 등록'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // 팝업창 닫기
  //                 },
  //                 child: Text('취소'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showDialog(BuildContext context, InboundItemData item) {
    TextEditingController qtyController = TextEditingController();

    // qtyController.addListener(() {
    //   final inputText = qtyController.text;
    //   final parsedValue = int.tryParse(inputText);
    //   if (parsedValue == null && inputText.isNotEmpty) {
    //     qtyController.clear();
    //   } else if (parsedValue != null && parsedValue.abs() > (item.inboundQty - item.qty)) {
    //     qtyController.clear();
    //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('입고 수량은 필요 수량을 초과할 수 없습니다.'),
    //         backgroundColor: Colors.red,
    //         duration: Duration(milliseconds: 500),
    //       ),
    //     );
    //   }
    // });

    qtyController.addListener(() {
      final inputText = qtyController.text;
      final parsedValue = int.tryParse(inputText);

        if (parsedValue!.abs() > (item.inboundQty - item.qty)) {
          qtyController.clear();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('입고 수량은 필요 수량을 초과할 수 없습니다.'),
              backgroundColor: Colors.red,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              titlePadding: EdgeInsets.all(0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('입고 처리'),
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/deleteIcon.png'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('총 예정 수량: ${item.inboundQty}'),
                  Text('입고 된 수량 : ${item.qty}'),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: qtyController,
                          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                          decoration: InputDecoration(
                            labelText: '수량',
                          ),
                          onChanged: (value) {
                            final parsedValue = int.tryParse(value);
                            if (parsedValue != null) {
                              final newValue = parsedValue.toString();
                              qtyController.value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: newValue.length),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final inputText = qtyController.text;
                    final parsedValue = int.tryParse(inputText) ?? 0;
                    ref.read(importInvenProvider.notifier).updateItem(
                      int.tryParse(item.inboundId ?? '0')!,
                      parsedValue,
                    );
                    int newQty = item.qty + parsedValue;
                    _forceUpdateQty(item.inboundId, newQty);
                    Navigator.of(context).pop(); // 팝업창 닫기
                  },
                  child: Text('입고 등록'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업창 닫기
                  },
                  child: Text('취소'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  Future<void> _saveAll() async {
    String saveSuccess = await ApiClient().sendMultipleInboundData(
        ref.read(importInvenProvider.notifier).getModifiedData());
    ref.read(importInvenProvider.notifier).clear();
    ref.read(importInvenProvider.notifier).clearItem();
    if (saveSuccess == 'true') {
      CustomSnackBar.show(context, '입고 처리 되었습니다', Colors.blue);
    } else if(saveSuccess == 'errorCount'){
      CustomSnackBar.show(context, '입고수량이 0미만 일 수 없습니다', Colors.deepOrangeAccent);
    } else {
      CustomSnackBar.show(context, '입고처리 중 오류가 발생했습니다', Colors.redAccent);
    }
    await _loadData();
  }

  void _cancelAll() {
    ref.read(importInvenProvider.notifier).saveResetData();
    ref.read(importInvenProvider.notifier).clearItem();
  }

  void _forceUpdateQty(String inboundId, int qty) {
    ref
        .read(importInvenProvider.notifier)
        .forceUpdateQty(int.tryParse(inboundId)!, qty);
  }

  @override
  Widget build(BuildContext context) {
    final importInvenData = ref.watch(importInvenProvider);
    String? token = ref.read(userProvider.notifier).state!.userToken;

    inboundItems = importInvenData
        .map((data) => InboundItemData(
              inboundId: data!.inboundId.toString(),
              materialName: data.itemName ?? 'Unknown',
              storage: data.warehouseName ?? 'Unknown',
              angle: data.angleName ?? 'Unknown',
              inboundExpectedDate: data.planDate ?? 'Unknown',
              inboundQty: data.plannedQuantity ?? 0,
              qty: data.inboundQuantity ?? 0,
              backupQty: data.backupQty ?? 0, // 초기 qty 값을 설정
              statusText: '입고대기',
              borderColor: getBorderColor(data.backupQty ?? 0,
                  data.inboundQuantity ?? 0, data.plannedQuantity ?? 0),
              textColor: Colors.teal,
            ))
        .toList();

    return WillPopScope(
      onWillPop: () async {
        if (await ref.read(importInvenProvider.notifier).backCheckBool()) {
          bool? shouldPop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('확인'),
              content: Text('입고 대기중입니다 정말 나가시겠습니까?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // "예" 클릭 시 true 반환
                  },
                  child: Text('예'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // "아니오" 클릭 시 false 반환
                  },
                  child: Text('아니오'),
                ),
              ],
            ),
          );
          if (shouldPop == true) {
            ref.read(importInvenProvider.notifier).clear();
            await ref
                .read(importDateProvider.notifier)
                .importDatePageCall(1, 15);
            return true;
          } else {
            return false;
          }
        }
        ref.read(importInvenProvider.notifier).clear();
        await ref.read(importDateProvider.notifier).importDatePageCall(1, 15);
        return true; // importInvenProvider.notifier.a()가 false를 반환한 경우
      },
      child: DefaultLayout(
        title: '입고 지시서 목록',
        body: importInvenData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: inboundItems.length,
                      itemBuilder: (context, index) {
                        final item = inboundItems[index];
                        return GestureDetector(
                          onTap: () => _showDialog(context, item),
                          child: InboundItem(
                            inboundId: item.inboundId,
                            materialName: item.materialName,
                            storage: item.storage,
                            angle: item.angle,
                            inboundExpectedDate: item.inboundExpectedDate,
                            inboundQty: item.inboundQty,
                            qty: item.qty,
                            statusText: item.statusText,
                            borderColor: item.borderColor,
                            textColor: item.textColor,
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _saveAll,
                        child: Text('저장'),
                      ),
                      ElevatedButton(
                        onPressed: _cancelAll,
                        child: Text('일괄 취소'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
