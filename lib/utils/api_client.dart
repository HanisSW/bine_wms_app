
//Singleton으로 선언
import 'dart:convert';
import 'package:wms_project/model/response/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:wms_project/model/user.dart';

import '../model/response/api_response_body.dart';
import '../model/response/api_response_header.dart';

class ApiClient {

  ApiClient._();

  static final ApiClient _apiClient = ApiClient._();

  factory ApiClient() => _apiClient;

  final String _baseUrl = 'devhanis.shop';

  final String _basePath = '/gn/inc/fn_api.php';


  /**
   *  API 추가
   */
  final String _login = '1'; // 어플리케이션 로그인 체크 API_NUM 코드


  /**
   * Login Api
   */
  Future<ApiResponse> login(String id, String pw) async {
    final response = await http.post(Uri.http(_baseUrl, _basePath),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'API_NUM': _login,
        'user_id': id,
        'user_pw': pw,
      },
    ).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      print(response.statusCode);
      print('--------------');
      print(response.body);
      print('--------------');
      print(utf8.decode(response.bodyBytes));
      print('--------------');
      print(json.decode(utf8.decode(response.bodyBytes)));

      final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final userJson = jsonResponse['body'];
      final userHeader = jsonResponse['header'];
      if (userJson != null && userHeader != null) {
        final user = User.fromJson(userJson);
        final apiResponseHeader = ApiResponseHeader.fromJson(userHeader);
        print("나오냐");
        return ApiResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      }else {
        throw Exception('login fail : body null');
      }
    } else {
      throw Exception('login failed check id & pw');
    }
  }

}