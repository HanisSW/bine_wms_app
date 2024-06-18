class ImportDate {
  String? planDate;
  int? cnt;

  ImportDate({
    this.planDate,
    this.cnt
  });

  factory ImportDate.fromJson(Map<String, dynamic> json) {
    return ImportDate(
      planDate: json['plan_date'],
      cnt: json['cnt']
    );
  }

  Map<String, dynamic> toJson() => {
    'plan_date': this.planDate ?? '',
    'cnt': this.cnt ?? '',
  };

  static List<ImportDate> jsonToList(dynamic json) {
    return (json as List).map((data) => ImportDate.fromJson(data)).toList();
  }


}
