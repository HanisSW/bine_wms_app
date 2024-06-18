import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/common/component/day_card.dart';
import 'package:wms_project/common/layouts/default_layout.dart';
import 'package:wms_project/screen/import_inven_page.dart';
import 'package:wms_project/viewmodel/import_date_notifier_provider.dart';
import 'package:wms_project/viewmodel/user_notifier_provider.dart';


class PrepareImportPage extends ConsumerStatefulWidget {
  const PrepareImportPage({Key? key}) : super(key: key);

  @override
  _PrepareImportPageState createState() => _PrepareImportPageState();
}

class _PrepareImportPageState extends ConsumerState<PrepareImportPage> {
  final ScrollController _scrollController = ScrollController();
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if(_scrollController.offset == _scrollController.position.maxScrollExtent){
      _loadMoreData();
    }
  }


  @override
  Widget build(BuildContext context) {
    final importDates = ref.watch(importDateProvider);

    return WillPopScope(
      onWillPop: () async {
        ref.read(importDateProvider.notifier).clear();
        return true;
      },
      child: DefaultLayout(
        title: "입고 지시 날짜 선택",
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                // itemCount: importDates.length + (_isLoading ? 1 : 0),
                itemCount: importDates.length,
                itemBuilder: (context, index) {
                  if (index < importDates.length) {
                    final importDate = importDates[index];
                    return GestureDetector(
                      onTap: (){
                        final planDate = importDate?.planDate ?? 'Unknown';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImportInvenPage(planDate: planDate),
                          ),
                        );
                        ref.read(importDateProvider.notifier).clear();
                      },
                      child: DayCard(
                        number: importDate?.cnt.toString() ?? '0',
                        day: importDate?.planDate ?? 'Unknown',
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadData() async {
    await ref.read(importDateProvider.notifier).importDatePageCall(1, 15);
  }

  Future<void> _loadMoreData() async {
    await ref.read(importDateProvider.notifier).loadMoreData();
  }
}