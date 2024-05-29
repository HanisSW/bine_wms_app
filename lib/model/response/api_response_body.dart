class ApiResponseBody {
  dynamic data;
  dynamic totalCount;

  ApiResponseBody({this.data, this.totalCount});


  factory ApiResponseBody.fromJson(Map<String, dynamic> json) {
    return ApiResponseBody(
      data: json['data'],
      totalCount : json['total_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': this.data,
        'total_count' : this.totalCount,
      };
}
