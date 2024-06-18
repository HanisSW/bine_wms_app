
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

  //임시 토큰
  final String token = 'MTY4NjkxNjE0NjQ4M0l1ZW55Q2dsR3A=';


  /**
   *  API 추가
   */
  final String _login = '1';

  /**
   *  Token 필요
   */
  final String _importInvenDateAll = '14';
  final String _importInvenOrderDateCall = '10';
  final String _sendInboundData = '11';
  final String _sendMultipleInboundData = '13';
  final String _exportInvenDateAll = '15';
  final String _exportInvenOrderDateCall = '9';
  final String _sendMultipleOutboundData = '16';
  final String _getInventoryList = '7';
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
      print('------헤더--------');
      print(response.headers);

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


  Future<ApiResponse> importInvenDateAll(int page, int itemsPerPage, String searchStoreDateType, String searchStoreStatus) async {
    final response = await http.get(Uri.http(_baseUrl, '$_basePath',{'API_NUM': _importInvenDateAll, 'page': '$page', 'itemsPerPage': '$itemsPerPage', 'searchStoreDateType':'$searchStoreDateType', 'searchStoreStatus':'$searchStoreStatus'}), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
      }).timeout(Duration(seconds: 10));

    print(response.request);
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('--------------');
      print(response.body);
      print('--------------');
      print(utf8.decode(response.bodyBytes));
      print('--------------');
      print(json.decode(utf8.decode(response.bodyBytes)));
      return ApiResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else {
      throw Exception('fail');
    }
  }

  Future<ApiResponse> importInvenOrderDateCall(int page, int itemsPerPage, String searchStoreDateType, String searchStartDate, String searchEndDate, String searchStoreStatus) async {
    final response = await http.get(Uri.http(_baseUrl, '$_basePath',{'API_NUM': _importInvenOrderDateCall, 'page' : '$page', 'itemsPerPage' : '$itemsPerPage', 'searchStoreDateType' : '$searchStoreDateType',
      'searchStartDate' : '$searchStartDate', 'searchEndDate' : '$searchEndDate', 'searchStoreStatus' : '$searchStoreStatus'}), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    }).timeout(Duration(seconds: 10));

    print(response.request);
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('--------------');
      print(response.body);
      print('--------------');
      print(utf8.decode(response.bodyBytes));
      print('--------------');
      print(json.decode(utf8.decode(response.bodyBytes)));
      return ApiResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else {
      throw Exception('fail');
    }
  }

  Future<void> sendInboundData(int id, int pw) async{
   final response = await http.post(Uri.http(_baseUrl, _basePath),
     headers: {
       'Content-Type': 'application/x-www-form-urlencoded',
     },
     body: {
       'API_NUM': _sendInboundData,
       'inbound_id': '$id',
       'inbound_quantity': '$pw',
     },
   ).timeout(Duration(seconds: 10));

   if (response.statusCode == 200) {
     print('Response status: ${response.statusCode}');
     print('Response body: ${response.body}');
   } else {
     print('Failed to send data. Status code: ${response.statusCode}');
     print('Response body: ${response.body}');
   }
  }

  Future<String> sendMultipleInboundData(List<Map<String, dynamic>> inboundData) async {
      final response = await http.post(Uri.http(_baseUrl, '$_basePath',{'API_NUM': _sendMultipleInboundData}),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode({
          'inbound_data': inboundData,
        }),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        final header = jsonResponse['header'];
        if (header != null) {
          final apiResponseHeader = ApiResponseHeader.fromJson(header);
          if(apiResponseHeader.resultCode == 111){
            return 'errorCount';
          }
        }
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        // return 'SUCCESS';
        return 'true';
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'false';
      }
  }

  Future<ApiResponse> exportInvenDateAll(int page, int itemsPerPage, String searchStoreDateType, String searchStoreStatus) async {
    final response = await http.get(Uri.http(_baseUrl, '$_basePath',{'API_NUM': _exportInvenDateAll, 'page': '$page', 'itemsPerPage': '$itemsPerPage', 'searchStoreDateType':'$searchStoreDateType', 'searchStoreStatus':'$searchStoreStatus'}), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    }).timeout(Duration(seconds: 10));
    print(response.request);
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('--------------');
      print(response.body);
      print('--------------');
      print(utf8.decode(response.bodyBytes));
      print('--------------');
      print(json.decode(utf8.decode(response.bodyBytes)));
      return ApiResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else {
      throw Exception('fail');
    }
  }


  Future<ApiResponse> exportInvenOrderDateCall(int page, int itemsPerPage, String searchStoreDateType, String searchStartDate, String searchEndDate, String searchStoreStatus) async {
    final response = await http.get(Uri.http(_baseUrl, '$_basePath',{'API_NUM': _exportInvenOrderDateCall, 'page' : '$page', 'itemsPerPage' : '$itemsPerPage', 'searchStoreDateType' : '$searchStoreDateType',
      'searchStartDate' : '$searchStartDate', 'searchEndDate' : '$searchEndDate', 'searchStoreStatus' : '$searchStoreStatus'}), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    }).timeout(Duration(seconds: 10));

    print(response.request);
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('--------------');
      print(response.body);
      print('--------------');
      print(utf8.decode(response.bodyBytes));
      print('--------------');
      print(json.decode(utf8.decode(response.bodyBytes)));
      return ApiResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else {
      throw Exception('fail');
    }
  }


  Future<bool> sendMultipleOutboundData(List<Map<String, dynamic>> outboundData) async {
    final response = await http.post(Uri.http(_baseUrl, '$_basePath',{'API_NUM': _sendMultipleOutboundData}),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode({
        'outbound_data': outboundData,
      }),
    ).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return true;
    } else {
      print('Failed to send data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }



  Future<ApiResponse> getInventoryList(int page, int itemsPerPage, String searchType, String keyword, String searchStoreDateType,
      String searchStartDate, String searchEndDate) async {
    final response = await http.get(Uri.http(_baseUrl, '$_basePath',{'API_NUM': _getInventoryList, 'page' : '$page', 'itemsPerPage' : '$itemsPerPage', 'searchType' : '$searchType', 'keyword' : '$keyword',
      'searchStoreDateType' : '$searchStoreDateType', 'searchStartDate' : '$searchStartDate', 'searchEndDate' : '$searchEndDate'}), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    }).timeout(Duration(seconds: 10));

    print(response.request);
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('--------------');
      print(response.body);
      print('--------------');
      print(utf8.decode(response.bodyBytes));
      print('--------------');
      print(json.decode(utf8.decode(response.bodyBytes)));
      return ApiResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else {
      throw Exception('fail');
    }
  }



}