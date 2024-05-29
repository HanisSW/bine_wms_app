import 'package:flutter/material.dart';
import 'package:wms_project/common/constants/colors.dart';
import 'package:wms_project/common/layouts/default_layout.dart';

class ProductImportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: BG_COLOR,
      title: '입고 관리',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchConditions(),
            SizedBox(height: 10),
            Expanded(child: InboundList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                      child: Text('입고 처리'),
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/delete_icon.png'),
                      onPressed: () {
                        // 삭제 로직 추가
                        Navigator.of(context).pop(); // 팝업창 닫기
                      },
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('필요 수량: 100'), // 여기서는 예시로 고정값을 사용했습니다.
                    TextField(
                      decoration: InputDecoration(
                        labelText: '입고된 수량 (이전)',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: '입고수량 (이번)',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 팝업창 닫기
                    },
                    child: Text('취소'),
                  ),
                  TextButton(
                    onPressed: () {
                      // 입고 등록 로직 추가
                      Navigator.of(context).pop(); // 팝업창 닫기
                    },
                    child: Text('입고 등록'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add), // 버튼에 표시될 아이콘
        tooltip: '입고 등록',
      ),
    );
  }
}

class SearchConditions extends StatelessWidget {
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '실적기간',
                      hintText: '2020-06-22',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '2020-06-29',
                    ),
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

class InboundList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InboundItem(
          code: '33',
          materialName: 'a2',
          storage: 'ware2',
          angle: 'a4',
          inboundExpectedDate: '2012-02-13',
          inboundQty: 300,
          statusText: '입고완료',
          borderColor: Colors.teal,
          textColor: Colors.teal,
        ),
        InboundItem(
          code: '32',
          materialName: 'a2',
          angle: "w23",
          storage: 'ware2',
          inboundExpectedDate: '2012-02-13',
          inboundQty: 300,
          statusText: '입고대기',
          borderColor: Colors.red,
          textColor: Colors.red,
        ),
      ],
    );
  }
}


class InboundItem extends StatelessWidget {
  final String code;
  final String materialName;
  final String storage;
  final String angle;
  final String inboundExpectedDate;
  final int inboundQty;
  final String statusText;
  final Color borderColor;
  final Color textColor;

  InboundItem({
    required this.code,
    required this.materialName,
    required this.storage,
    required this.angle,
    required this.inboundExpectedDate,
    required this.inboundQty,
    required this.statusText,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
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
                      // 삭제 로직 추가
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('필요 수량: $inboundQty'),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     labelText: '입고된 수량 (이전)',
                  //   ),
                  // ),
                  SizedBox(height: 20,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: '입고수량 (이번)',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업창 닫기
                  },
                  child: Text('입고 등록'),
                ),
                TextButton(
                  onPressed: () {
                    // 입고 등록 로직 추가
                    Navigator.of(context).pop(); // 팝업창 닫기
                  },
                  child: Text('취소'),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        color: INPUT_BG_COLOR,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("No : "+code, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.0),
                  Text('창고: $storage'),
                  Text('앵글: $angle'),
                  Text('예정입고날짜: $inboundExpectedDate'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatusItem(
                    statusText: statusText,
                    borderColor: borderColor,
                    textColor: textColor,
                  ),
                  SizedBox(height: 15),
                  Text('제품명: $materialName'),
                  Text('잔여입고수량: $inboundQty'),
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
