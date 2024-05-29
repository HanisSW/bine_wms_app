import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/screen/login_page.dart';
import 'package:wms_project/viewmodel/user_notifier_provider.dart';

class DefaultLayout extends ConsumerWidget {
  final Color? backgroundColor;
  final Widget body;
  final String? title;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool isMain;

  const DefaultLayout(
      {Key? key, required this.body, this.backgroundColor, this.title, this.floatingActionButton, this.bottomNavigationBar, this.isMain = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: isMain ? mainScreenAppBar(context, ref) : renderAppBar(),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }


  AppBar mainScreenAppBar(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.logout, color: Colors.black),
        onPressed: () {
          // 로그아웃 처리
          ref.read(userProvider.notifier).logout();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
          print('로그아웃 버튼 눌림');
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Text(
              user?.userName != null ? '${user!.userName}님' : '로그아웃',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
      foregroundColor: Colors.black,
    );
  }
}


