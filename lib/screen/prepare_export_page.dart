import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/common/component/day_card.dart';
import 'package:wms_project/common/layouts/default_layout.dart';
import 'package:wms_project/screen/export_inven_page.dart';
import 'package:wms_project/viewmodel/export_date_notifier_provider.dart';


class PrepareExportPage extends ConsumerStatefulWidget {
  const PrepareExportPage({Key? key}) : super(key: key);

  @override
  _PrepareExportPageState createState() => _PrepareExportPageState();
}

class _PrepareExportPageState extends ConsumerState<PrepareExportPage> {
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

  void _onScroll() {
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }



  @override
  Widget build(BuildContext context) {
    final exportDates = ref.watch(exportDateProvider);

    return WillPopScope(
      onWillPop: () async {
        ref.read(exportDateProvider.notifier).clear();
        return true;
      },
      child: DefaultLayout(
        title: "출고페이지",
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                // itemCount: exportDates.length + (_isLoading ? 1 : 0),
                itemCount: exportDates.length,
                itemBuilder: (context, index) {
                  if (index < exportDates.length) {
                    final exportDate = exportDates[index];
                    return GestureDetector(
                      onTap: () {
                        final planDate = exportDate?.planDate ?? 'Unknown';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ExportInvenPage(planDate: planDate),
                          ),
                        );
                        ref.read(exportDateProvider.notifier).clear();
                      },
                      child: DayCard(
                        number: exportDate?.cnt.toString() ?? '0',
                        day: exportDate?.planDate ?? 'Unknown',
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
    await ref.read(exportDateProvider.notifier).exportDatePageCall(1, 15);
  }

  Future<void> _loadMoreData() async {
    await ref.read(exportDateProvider.notifier).loadMoreData();
  }
}