import 'package:flutter/material.dart';

class DefaultLayout2 extends StatelessWidget {
  final Color? backgroundColor;
  final Widget body;
  final String? title;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool isMain;

  const DefaultLayout2(
      {Key? key, required this.body, this.backgroundColor, this.title, this.floatingActionButton, this.bottomNavigationBar, this.isMain = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: isMain ? mainScreenAppBar(context) : renderAppBar(),
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


  AppBar mainScreenAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.logout, color: Colors.black),
        onPressed: () {
          // 로그아웃 처리
          print('로그아웃 버튼 눌림');
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Text(
              // 로그인한 사용자의 ID를 여기에 표시
              '테스트님',
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




