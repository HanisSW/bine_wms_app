import 'dart:convert';
import 'package:wms_project/model/response/api_response_body.dart';
import 'package:wms_project/model/response/api_response_header.dart';
import 'package:wms_project/model/user.dart';

class ApiResponse {
  ApiResponseHeader? header;
  ApiResponseBody? body;

  ApiResponse({this.header, this.body});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      header: ApiResponseHeader.fromJson(json['header']),
      body: ApiResponseBody.fromJson(json['body']),
    );
  }

  Map<String, dynamic> toJson() => {
        'header': this.header,
        'body': this.body,
      };
}
