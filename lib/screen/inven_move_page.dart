import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/common/component/Inventory_item_bottom_sheet.dart';
import 'package:wms_project/common/component/inven_item.dart';
import 'package:wms_project/common/component/search_condition.dart';
import 'package:wms_project/common/layouts/default_layout.dart';
import 'package:wms_project/viewmodel/inven_item_list_notifier_provider.dart';

class InvenMovePage extends ConsumerStatefulWidget {
  const InvenMovePage({Key? key}) : super(key: key);

  @override
  _InvenMovePageState createState() => _InvenMovePageState();
}

class _InvenMovePageState extends ConsumerState<InvenMovePage> {
  final ScrollController _scrollController = ScrollController();

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
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> _loadData() async {
    await ref.read(invenListProvider.notifier).getInvenList(1, 15, '', '', '', '');
  }

  Future<void> _loadMoreData() async {
    await ref.read(invenListProvider.notifier).loadMoreData();
  }

  void _onSearch(String startDate, String endDate) async {
    await ref.read(invenListProvider.notifier).getInvenList(1, 15, '', '', startDate, endDate);
  }

  @override
  Widget build(BuildContext context) {
    final invenList = ref.watch(invenListProvider);
    return DefaultLayout(
      title: '재고 관리 페이지',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchCondition(onSearch: _onSearch),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: invenList.length,
                itemBuilder: (context, index) {
                  final item = invenList[index];
                  return InventoryItems(
                    item: item,
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return InventoryItemBottomSheet(item: item);
                        },
                      );
                      _loadData(); // 바텀시트가 닫힐 때 데이터 다시 로드
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}