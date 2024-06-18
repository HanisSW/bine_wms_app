class ExportDate {
  String? planDate;
  int? cnt;

  ExportDate({
    this.planDate,
    this.cnt
  });

  factory ExportDate.fromJson(Map<String, dynamic> json) {
    return ExportDate(
        planDate: json['plan_date'],
        cnt: json['cnt']
    );
  }

  Map<String, dynamic> toJson() => {
    'plan_date': this.planDate ?? '',
    'cnt': this.cnt ?? '',
  };

  static List<ExportDate> jsonToList(dynamic json) {
    return (json as List).map((data) => ExportDate.fromJson(data)).toList();
  }


}
