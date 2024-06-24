class WarehouseAngleList {
  int? warehouseId;
  String? warehouseName;
  int? angleCnt;
  int? angleId;
  String? angleName;


  WarehouseAngleList({
    this.warehouseId,
    this.warehouseName,
    this.angleCnt,
    this.angleId,
    this.angleName
  });

  factory WarehouseAngleList.fromJson(Map<String, dynamic> json) {
    return WarehouseAngleList(
      warehouseId: json['warehouse_id'],
      warehouseName: json['warehouse_name'],
      angleCnt: json['angle_cnt'],
      angleId: json['angle_id'],
      angleName: json['angle_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'warehouse_id': this.warehouseId,
    'warehouse_name': this.warehouseName ?? '',
    'angle_cnt': this.angleCnt ?? '',
    'angle_id': this.angleId ?? '',
    'angle_name': this.angleName ?? '',
  };

  static List<WarehouseAngleList> jsonToList(dynamic json) {
    return (json as List).map((data) => WarehouseAngleList.fromJson(data)).toList();
  }

}
