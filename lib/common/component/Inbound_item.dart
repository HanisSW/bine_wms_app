import 'package:flutter/material.dart';
import 'package:wms_project/common/constants/colors.dart';

class InboundItemData {
  final String inboundId;
  final String materialName;
  final String storage;
  final String angle;
  final String inboundExpectedDate;
  final int inboundQty;
  int qty;
  final int backupQty;
  final String statusText;
  Color borderColor;
  Color textColor;

  InboundItemData({
    required this.inboundId,
    required this.materialName,
    required this.storage,
    required this.angle,
    required this.inboundExpectedDate,
    required this.inboundQty,
    required this.qty,
    required this.backupQty,
    required this.statusText,
    required this.borderColor,
    required this.textColor,
  });

  InboundItemData copyWith({int? qty}) {
    return InboundItemData(
      inboundId: this.inboundId,
      materialName: this.materialName,
      storage: this.storage,
      angle: this.angle,
      inboundExpectedDate: this.inboundExpectedDate,
      inboundQty: this.inboundQty,
      qty: qty ?? this.qty,
      backupQty: this.backupQty,
      statusText: this.statusText,
      borderColor: getBorderColor(this.backupQty, qty ?? this.qty, this.inboundQty),
      textColor: this.textColor,
    );
  }
}


class InboundItem extends StatelessWidget {
  final String inboundId;
  final String materialName;
  final String storage;
  final String angle;
  final String inboundExpectedDate;
  final int inboundQty;
  final int qty;
  final String statusText;
  final Color borderColor;
  final Color textColor;

  InboundItem({
    required this.inboundId,
    required this.materialName,
    required this.storage,
    required this.angle,
    required this.inboundExpectedDate,
    required this.inboundQty,
    required this.qty,
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
                Text("No : " + inboundId, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4.0),
                Text('제품명: $materialName'),
                Text('창고: $storage'),
                Text('앵글: $angle'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('예정입고날짜: $inboundExpectedDate'),
                SizedBox(height: 15),
                Text('잔여입고수량: $inboundQty'),
                Text('입고수량: $qty'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color getBorderColor(int backupQty, int qty, int inboundQty) {
  if (qty == inboundQty) {
    return Colors.green;
  } else if (qty != backupQty) {
    return Colors.blue;
  } else {
    return Colors.white;
  }
}