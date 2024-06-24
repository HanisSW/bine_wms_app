class InventoryItemList {
  int? stockId;
  int? itemId;
  int? warehouseId;
  int? angleId;
  int? quantity;
  String? rdate;
  String? delYN;
  String? itemName;
  int? warehouseIdNull;
  String? warehouseName;
  String? angleName;


  InventoryItemList({
    this.stockId,
    this.itemId,
    this.warehouseId,
    this.angleId,
    this.quantity,
    this.rdate,
    this.delYN,
    this.itemName,
    this.warehouseIdNull,
    this.warehouseName,
    this.angleName
  });

  factory InventoryItemList.fromJson(Map<String, dynamic> json) {
    return InventoryItemList(
      stockId: json['stock_id'],
      itemId: json['item_id'],
      warehouseId: json['warehouse_id'],
      angleId: json['angle_id'],
      quantity: json['quantity'],
      rdate: json['rdate'],
      delYN: json['delYN'],
      itemName: json['item_name'],
      warehouseIdNull: json['warehouse_id_null'],
      warehouseName: json['warehouse_name'],
      angleName: json['angle_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'stock_id': this.stockId,
    'item_id': this.itemId ?? '',
    'warehouse_id': this.warehouseId ?? '',
    'angle_id': this.angleId ?? '',
    'quantity': this.quantity ?? '',
    'rdate': this.rdate ?? '',
    'delYN': this.delYN ?? '',
    'item_name': this.itemName ?? '',
    'warehouse_id_null': this.warehouseIdNull ?? '',
    'warehouse_name': this.warehouseName ?? '',
    'angle_name': this.angleName ?? '',
  };

  static List<InventoryItemList> jsonToList(dynamic json) {
    return (json as List).map((data) => InventoryItemList.fromJson(data)).toList();
  }

  // InventoryItem copyWith({
  //   int? stockId,
  //   int? itemId,
  //   int? warehouseId,
  //   int? angleId,
  //   int? quantity,
  //   String? rdate,
  //   String? delYN,
  //   String? itemName,
  //   int? warehouseIdNull,
  //   String? warehouseName,
  //   String? angleName,
  // }) {
  //   return InventoryItem(
  //     inboundId: inboundId ?? this.inboundId,
  //     itemName: itemName ?? this.itemName,
  //     itemCode: itemCode ?? this.itemCode,
  //     warehouseName: warehouseName ?? this.warehouseName,
  //     angleName: angleName ?? this.angleName,
  //     companyName: companyName ?? this.companyName,
  //     plannedQuantity: plannedQuantity ?? this.plannedQuantity,
  //     inboundQuantity: inboundQuantity ?? this.inboundQuantity,
  //     backupQty: backupQty ?? this.backupQty,
  //     planDate: planDate ?? this.planDate,
  //     rdate: rdate ?? this.rdate,
  //     state: state ?? this.state,
  //   );
  // }
}
