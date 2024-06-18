import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wms_project/common/component/login_text_field.dart';
import 'package:wms_project/common/constants/colors.dart';
import 'package:wms_project/utils/api_client.dart';
import 'package:wms_project/viewmodel/user_notifier_provider.dart';
import 'package:wms_project/screen/main_page.dart';
import 'package:wms_project/common/layouts/default_layout.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  DateTime? prePressTime;

  Future<bool> onWillPop() {
    var isExist = false;
    if (prePressTime == null) {
      prePressTime = DateTime.now();
    } else {
      final timeGap = DateTime.now().difference(prePressTime!);
      isExist = timeGap <= Duration(milliseconds: 1500);
      prePressTime = DateTime.now();
    }
    if (!isExist) {
      Fluttertoast.showToast(
        msg: "앱을 종료하려면 한 번 더 누르세요.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: DefaultLayout(
        backgroundColor: BG_COLOR,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Title(),
                SizedBox(height: 16),
                _SubTitle(),
                SizedBox(height: 16),
                CustomLoginTextField(
                  hintText: '아이디를 입력해주세요',
                  onChanged: (String value) {},
                  controller: _idController,
                ),
                SizedBox(height: 16),
                CustomLoginTextField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (String value) {},
                  controller: _passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String id = _idController.text;
                      String password = _passwordController.text;
                      await ref.read(userProvider.notifier).login(id, password);
                      final user = ref.read(userProvider);
                      print(user);
                      if(user != null){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('로그인 실패: 아이디 및 비밀번호 확인')),
                        );
                      }
                      // ApiClient().getInventoryList(1, 10, '', '', 'STORE_EXPECTED_DATE', '', '');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('로그인 실패: $e')),
                      );
                      print('로그인 실패: $e');
                    }
                  },
                  child: Text('로그인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hanis WMS",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "지급받은 아이디와 비밀번호를 입력해 로그인 해주세요",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w200,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}