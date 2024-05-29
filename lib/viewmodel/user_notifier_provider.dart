import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/model/user.dart';
import 'package:wms_project/utils/api_client.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  Future<void> login(String id, String pw) async {
    try {
      var response = await ApiClient().login(id, pw);
      if (response.header?.resultCode == 200) {
        User user = User.fromJson(response.body?.data);
        print(user.userName);
        state = user;
      } else {
        // 로그인 실패 처리
        state = null;
      }
    } catch (e) {
      // 에러 처리
      state = null;
    }
  }

  void logout() {
    state = null;
  }
}
