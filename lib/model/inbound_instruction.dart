class InboundInstruction {
  int? inboundId;
  String? itemName;
  int? itemCode;
  String? warehouseName;
  String? angleName;
  String? companyName;
  //입고 예정 갯수
  int? plannedQuantity;
  //실 입고 갯수
  int? inboundQuantity;
  //백업용 qty
  int? backupQty;
  String? planDate;
  //입고 완료 전환 날짜
  String? rdate;
  int? state;

  InboundInstruction({
    this.inboundId,
    this.itemName,
    this.itemCode,
    this.warehouseName,
    this.angleName,
    this.companyName,
    this.plannedQuantity,
    this.inboundQuantity,
    int? backupQty,
    this.planDate,
    this.rdate,
    this.state,
  }) : backupQty = backupQty ?? inboundQuantity;

  factory InboundInstruction.fromJson(Map<String, dynamic> json) {
    int? inboundQuantity = json['inbound_quantity'];
    return InboundInstruction(
      inboundId: json['inbound_id'],
      itemName: json['item_name'],
      itemCode: json['item_code'],
      warehouseName: json['warehouse_name'],
      angleName: json['angle_name'],
      companyName: json['company_name'],
      plannedQuantity: json['planned_quantity'],
      inboundQuantity: inboundQuantity,
      backupQty: inboundQuantity,
      planDate: json['plan_date'],
      rdate: json['rdate'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() => {
    'inbound_id': this.inboundId,
    'item_name': this.itemName ?? '',
    'item_code': this.itemCode ?? '',
    'warehouse_name': this.warehouseName ?? '',
    'angle_name': this.angleName ?? '',
    'company_name': this.companyName ?? '',
    'planned_quantity': this.plannedQuantity ?? '',
    'inbound_quantity': this.inboundQuantity ?? '',
    'backup_qty': this.backupQty ?? '',
    'plan_date': this.planDate ?? '',
    'rdate': this.rdate ?? '',
    'state': this.state ?? '',
  };

  static List<InboundInstruction> jsonToList(dynamic json) {
    return (json as List).map((data) => InboundInstruction.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'InboundInstruction{id: $inboundId, quantity: $inboundQuantity}';
  }

  //state와 saveList를 비교할때 같은 데이터를 가져도 같은 객체를 참조하지 않는지 동일하다고 판단하지 않음
  // == 연산자를 오버라이드해 데이터값을 비교
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InboundInstruction &&
        other.inboundId == inboundId &&
        other.inboundQuantity == inboundQuantity;
  }

  @override
  int get hashCode => inboundId.hashCode ^ inboundQuantity.hashCode;

  InboundInstruction copyWith({
    int? inboundId,
    String? itemName,
    int? itemCode,
    String? warehouseName,
    String? angleName,
    String? companyName,
    int? plannedQuantity,
    int? inboundQuantity,
    int? backupQty,
    String? planDate,
    String? rdate,
    int? state,
  }) {
    return InboundInstruction(
      inboundId: inboundId ?? this.inboundId,
      itemName: itemName ?? this.itemName,
      itemCode: itemCode ?? this.itemCode,
      warehouseName: warehouseName ?? this.warehouseName,
      angleName: angleName ?? this.angleName,
      companyName: companyName ?? this.companyName,
      plannedQuantity: plannedQuantity ?? this.plannedQuantity,
      inboundQuantity: inboundQuantity ?? this.inboundQuantity,
      backupQty: backupQty ?? this.backupQty,
      planDate: planDate ?? this.planDate,
      rdate: rdate ?? this.rdate,
      state: state ?? this.state,
    );
  }
}
