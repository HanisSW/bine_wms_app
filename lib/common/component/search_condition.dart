import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SearchCondition extends StatefulWidget {
  final Function(String, String) onSearch;

  SearchCondition({required this.onSearch});

  @override
  _SearchConditionState createState() => _SearchConditionState();
}

class _SearchConditionState extends State<SearchCondition> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: const Locale('ko', 'KR'), // 한국어로 로케일 설정
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
                          labelText: '입고 시작일',
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
                          labelText: '입고 종료일',
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
                    widget.onSearch(_startDateController.text, _endDateController.text);
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