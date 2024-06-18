import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wms_project/common/constants/colors.dart';
import 'package:wms_project/common/layouts/default_layout.dart';

class TestPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '재고 입고',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchConditions(),
            SizedBox(height: 10),
            Expanded(child: InventoryInboundList()),
          ],
        ),
      ),
    );
  }
}

class SearchConditions extends StatefulWidget {
  @override
  _SearchConditionsState createState() => _SearchConditionsState();
}

class _SearchConditionsState extends State<SearchConditions> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: const Locale('ko', 'KR'), // Set the locale to Korean
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('검색조건'),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: _startDateController,
                        decoration: InputDecoration(
                          labelText: '실적기간 시작일',
                          hintText: '2020-06-22',
                        ),
                        readOnly: true,
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, _startDateController),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: _endDateController,
                        decoration: InputDecoration(
                          labelText: '실적기간 종료일',
                          hintText: '2020-06-29',
                        ),
                        readOnly: true,
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, _endDateController),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Search action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryInboundList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InvenInboundItem(
          materialName: 'a2',
          storage: 'ware2',
          angleName: 'AG1072',
          updateDate: '2012-02-13',
          inboundQty: 200,
          statusText: '이동완료',
          borderColor: Colors.teal,
          textColor: Colors.teal,
        ),
        InvenInboundItem(
          angleName: 'AG1072',
          materialName: 'a2',
          storage: 'ware2',
          updateDate: '2012-02-13',
          inboundQty: 300,
          statusText: '이동대기',
          borderColor: Colors.red,
          textColor: Colors.red,
        ),
      ],
    );
  }
}

class InvenInboundItem extends StatelessWidget {
  final String materialName;
  final String storage;
  final String angleName;
  final String updateDate;
  final int inboundQty;
  final String statusText;
  final Color borderColor;
  final Color textColor;

  InvenInboundItem({
    required this.materialName,
    required this.storage,
    required this.angleName,
    required this.updateDate,
    required this.inboundQty,
    required this.statusText,
    required this.borderColor,
    required this.textColor,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           String selectedWarehouse = 'Warehouse A';
  //           String selectedAngle = 'AG1001';
  //           TextEditingController quantityController = TextEditingController();
  //
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(16)),
  //             titlePadding: EdgeInsets.all(0),
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Text('앵글로 제품 이동'),
  //                 ),
  //                 IconButton(
  //                   icon: Image.asset('assets/images/deleteIcon.png'),
  //                   onPressed: () {
  //                     // 삭제 로직 추가
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 DropdownButtonFormField<String>(
  //                   value: selectedWarehouse,
  //                   decoration: InputDecoration(labelText: '창고 선택'),
  //                   items: ['Warehouse A', 'Warehouse B', 'Warehouse C']
  //                       .map((String value) {
  //                     return DropdownMenuItem<String>(
  //                       value: value,
  //                       child: Text(value),
  //                     );
  //                   }).toList(),
  //                   onChanged: (String? newValue) {
  //                     if (newValue != null) {
  //                       selectedWarehouse = newValue;
  //                     }
  //                   },
  //                 ),
  //                 DropdownButtonFormField<String>(
  //                   value: selectedAngle,
  //                   decoration: InputDecoration(labelText: '앵글 선택'),
  //                   items: ['AG1001', 'AG1002', 'AG1003'].map((String value) {
  //                     return DropdownMenuItem<String>(
  //                       value: value,
  //                       child: Text(value),
  //                     );
  //                   }).toList(),
  //                   onChanged: (String? newValue) {
  //                     if (newValue != null) {
  //                       selectedAngle = newValue;
  //                     }
  //                   },
  //                 ),
  //                 TextField(
  //                   controller: quantityController,
  //                   decoration: InputDecoration(
  //                     labelText: '수량',
  //                   ),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // 팝업창 닫기
  //                 },
  //                 child: Text('취소'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   // 입고 등록 로직 추가
  //                   Navigator.of(context).pop(); // 팝업창 닫기
  //                 },
  //                 child: Text('앵글로 이동완료'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            String selectedWarehouse = 'Warehouse A';
            String selectedAngle = 'AG1001';
            TextEditingController quantityController = TextEditingController();

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
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
                          value: selectedWarehouse,
                          decoration: InputDecoration(labelText: '창고 선택'),
                          items: ['Warehouse A', 'Warehouse B', 'Warehouse C']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedWarehouse = newValue;
                              });
                            }
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedAngle,
                          decoration: InputDecoration(labelText: '앵글 선택'),
                          items: ['AG1001', 'AG1002', 'AG1003']
                              .map((String value) {
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
                              onPressed: () {
                                // 입고 등록 로직 추가
                                Navigator.of(context).pop(); // 팝업창 닫기
                              },
                              child: Text('앵글로 이동완료'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: Card(
        color: Colors.white, // Replace with your INPUT_BG_COLOR
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('제품명: ' + materialName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.0),
                  Text('창고: $storage'),
                  Text('앵글: $angleName'),
                  Text('업데이트날짜: $updateDate'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('수량 : $inboundQty'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusItem extends StatelessWidget {
  final String statusText;
  final Color borderColor;
  final Color textColor;

  StatusItem({
    required this.statusText,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        statusText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
