import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/common/component/custom_snackbar.dart';
import 'package:wms_project/common/component/outbound_item.dart';
import 'package:wms_project/common/layouts/default_layout.dart';
import 'package:wms_project/utils/api_client.dart';
import 'package:wms_project/viewmodel/export_date_notifier_provider.dart';
import 'package:wms_project/viewmodel/export_inven_notifier_provider.dart';

class ExportInvenPage extends ConsumerStatefulWidget {
  final String planDate;

  const ExportInvenPage({Key? key, required this.planDate}) : super(key: key);

  @override
  _ExportInvenPageState createState() => _ExportInvenPageState();
}

class _ExportInvenPageState extends ConsumerState<ExportInvenPage> {
  late List<OutboundItemData> outboundItems;


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
    final response = await ref.read(exportInvenProvider.notifier).exportInvenList(1, 100, widget.planDate, widget.planDate);
    if (response.header?.codeName == "SUCCESS_ZERO") {
      CustomSnackBar.show(context, '모든 출고처리가 완료 되었습니다', Colors.black87);
      Future.delayed(Duration(seconds: 2), () async {
        ref.read(exportInvenProvider.notifier).clear();
        await ref.read(exportDateProvider.notifier).exportDatePageCall(1, 15);
        Navigator.of(context).pop();
      });
    }
  }


  void _showDialog(BuildContext context, OutboundItemData item) {
    TextEditingController qtyController = TextEditingController();

    qtyController.addListener(() {
      final inputText = qtyController.text;
      final parsedValue = int.tryParse(inputText);
      if (parsedValue == null) {
        qtyController.clear();
      } else if (parsedValue > (item.outboundQty - item.qty)) {
        qtyController.clear();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('출고 수량은 필요 수량을 초과할 수 없습니다.'),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                child: Text('출고 처리'),
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
              Text('총 예정 수량: ${item.outboundQty}'),
              Text('출고 된 수량 : ${item.qty}'),
              SizedBox(height: 20),
              TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '출고수량 (이번)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final inputText = qtyController.text;
                final parsedValue = int.tryParse(inputText) ?? 0;
                ref.read(exportInvenProvider.notifier).updateItem(
                  int.tryParse(item.outboundId ?? '0')!,
                  parsedValue,
                );
                int newQty = item.qty + parsedValue;
                _forceUpdateQty(item.outboundId, newQty);
                Navigator.of(context).pop(); // 팝업창 닫기
              },
              child: Text('출고 등록'),
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
  }


  Future<void> _saveAll() async {
    bool saveSuccess = await ApiClient().sendMultipleOutboundData(ref.read(exportInvenProvider.notifier).getModifiedData());
    ref.read(exportInvenProvider.notifier).clear();
    ref.read(exportInvenProvider.notifier).clearItem();
    if(saveSuccess){
      CustomSnackBar.show(context, '출고 처리 되었습니다', Colors.blue);
    } else {
      CustomSnackBar.show(context, '출고처리 중 오류가 발생했습니다', Colors.redAccent);
    }
    await _loadData();
  }

  void _cancelAll() {
    ref.read(exportInvenProvider.notifier).saveResetData();
    ref.read(exportInvenProvider.notifier).clearItem();
  }

  void _forceUpdateQty(String outboundId, int qty) {
    ref.read(exportInvenProvider.notifier).forceUpdateQty(int.tryParse(outboundId)!, qty);
  }


  @override
  Widget build(BuildContext context) {
    final exportInvenData = ref.watch(exportInvenProvider);

    outboundItems = exportInvenData.map((data) => OutboundItemData(
      outboundId: data!.outboundId.toString(),
      materialName: data.itemName ?? 'Unknown',
      storage: data.warehouseName ?? 'Unknown',
      angle: data.angleName ?? 'Unknown',
      companyName: data.companyName ?? 'Unknown',
      outboundExpectedDate: data.planDate ?? 'Unknown',
      outboundQty: data.plannedQuantity ?? 0,
      qty: data.outboundQuantity ?? 0,
      stockQuantity: data.stockQuantity ?? 0,
      backupQty: data.backupQty ?? 0,
      statusText: '출고대기',
      borderColor: getBorderColor(data.backupQty ?? 0, data.outboundQuantity ?? 0, data.plannedQuantity ?? 0),
      textColor: Colors.teal,
    )).toList();

    // return WillPopScope(
    //   onWillPop: () async {
    //     ref.read(exportInvenProvider.notifier).clear();
    //     await ref.read(exportDateProvider.notifier).exportDatePageCall(1, 15);
    //     return true;
    //   },
    return WillPopScope(
      onWillPop: () async {
        if (await ref.read(exportInvenProvider.notifier).backCheckBool()) {
          bool? shouldPop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('확인'),
              content: Text('출고 대기중입니다 정말 나가시겠습니까?'),
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
            ref.read(exportInvenProvider.notifier).clear();
            await ref.read(exportDateProvider.notifier).exportDatePageCall(1, 15);
            return true;
          } else {
            return false;
          }
        }
        ref.read(exportInvenProvider.notifier).clear();
        await ref.read(exportDateProvider.notifier).exportDatePageCall(1, 15);
        return true; // importInvenProvider.notifier.a()가 false를 반환한 경우
      },
      child: DefaultLayout(
        title: '출고 관리',
        body: exportInvenData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: outboundItems.length,
                itemBuilder: (context, index) {
                  final item = outboundItems[index];
                  // return GestureDetector(
                  //   onTap: () => _showDialog(context, item),
                  //   child: OutboundItem(
                  //     outboundId: item.outboundId,
                  //     materialName: item.materialName,
                  //     storage: item.storage,
                  //     angle: item.angle,
                  //     companyName : item.companyName,
                  //     outboundExpectedDate: item.outboundExpectedDate,
                  //     outboundQty: item.outboundQty,
                  //     qty: item.qty,
                  //     stockQuantity : item.stockQuantity,
                  //     statusText: item.statusText,
                  //     borderColor: item.borderColor,
                  //     textColor: item.textColor,
                  //   ),
                  // );
                  return GestureDetector(
                    onTap: item.stockQuantity > 0 ? () => _showDialog(context, item) : null,
                    child: Opacity(
                      opacity: item.stockQuantity > 0 ? 1.0 : 0.5,
                      child: OutboundItem(
                        outboundId: item.outboundId,
                        materialName: item.materialName,
                        storage: item.storage,
                        angle: item.angle,
                        companyName : item.companyName,
                        outboundExpectedDate: item.outboundExpectedDate,
                        outboundQty: item.outboundQty,
                        qty: item.qty,
                        stockQuantity : item.stockQuantity,
                        statusText: item.statusText,
                        borderColor: item.borderColor,
                        textColor: item.textColor,
                      ),
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
