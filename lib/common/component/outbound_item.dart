import 'package:flutter/material.dart';
import 'package:wms_project/common/constants/colors.dart';

class OutboundItemData {
  final String outboundId;
  final String materialName;
  final String storage;
  final String angle;
  final String companyName;
  final String outboundExpectedDate;
  final int outboundQty;
  int qty;
  final int backupQty;
  final int stockQuantity;
  final String statusText;
  Color borderColor;
  Color textColor;

  OutboundItemData({
    required this.outboundId,
    required this.materialName,
    required this.storage,
    required this.angle,
    required this.companyName,
    required this.outboundExpectedDate,
    required this.outboundQty,
    required this.qty,
    required this.backupQty,
    required this.stockQuantity,
    required this.statusText,
    required this.borderColor,
    required this.textColor,
  });

  OutboundItemData copyWith({int? qty}) {
    return OutboundItemData(
      outboundId: this.outboundId,
      materialName: this.materialName,
      storage: this.storage,
      angle: this.angle,
      companyName: this.companyName,
      outboundExpectedDate: this.outboundExpectedDate,
      outboundQty: this.outboundQty,
      qty: qty ?? this.qty,
      backupQty: this.backupQty,
      stockQuantity: this.stockQuantity,
      statusText: this.statusText,
      borderColor: getBorderColor(this.backupQty, qty ?? this.qty, this.outboundQty),
      textColor: this.textColor,
    );
  }


}


class OutboundItem extends StatelessWidget {
  //인바운드 아이디
  final String outboundId;
  //아이템 명
  final String materialName;
  //창고명
  final String storage;
  //앵글명
  final String angle;
  //회사명
  final String companyName;
  //출고 예정일
  final String outboundExpectedDate;
  //예정 출고 갯구
  final int outboundQty;
  //출고 갯수
  final int qty;
  //제품 갯수
  final int stockQuantity;
  final String statusText;
  final Color borderColor;
  final Color textColor;

  OutboundItem({
    required this.outboundId,
    required this.materialName,
    required this.storage,
    required this.angle,
    required this.companyName,
    required this.outboundExpectedDate,
    required this.outboundQty,
    required this.qty,
    required this.stockQuantity,
    required this.statusText,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: INPUT_BG_COLOR,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("No : " + outboundId, style: TextStyle(fontWeight: FontWeight.bold)),
                Text('회사: $companyName'),
                Text('제품명: $materialName'),
                Text('창고: $storage'),
                Text('앵글: $angle'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('예정출고날짜: $outboundExpectedDate'),
                Text('제품 갯수 : $stockQuantity'),
                Text('잔여출고수량: $outboundQty'),
                Text('출고수량: $qty'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color getBorderColor(int backupQty, int qty, int outboundQty) {
  if (qty == outboundQty) {
    return Colors.green;
  } else if (qty != backupQty) {
    return Colors.blue;
  } else {
    return Colors.white;
  }
}