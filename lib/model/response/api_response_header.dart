class ApiResponseHeader {
  int? resultCode;
  String? codeName;

  ApiResponseHeader({this.resultCode, this.codeName});

  factory ApiResponseHeader.fromJson(Map<String, dynamic> json) {
    return ApiResponseHeader(
      resultCode: json['resultCode'],
      codeName: json['codeName']
    );
  }

  Map<String, dynamic> toJson() => {
        'resultCode': this.resultCode,
        'codeName': this.codeName ?? '',
      };
}
