class OutboundInstruction {
  int? outboundId;
  String? itemName;
  String? warehouseName;
  String? angleName;
  String? companyName;
  //출고 예정 갯수
  int? plannedQuantity;
  //실제 출고 갯수
  int? outboundQuantity;
  //백업용 qty
  int? backupQty;
  String? planDate;
  //입고 완료 전환 날짜
  String? rdate;
  int? state;
  //아이템 네임의 재고수량
  int? stockQuantity;

  OutboundInstruction({
    this.outboundId,
    this.itemName,
    this.warehouseName,
    this.angleName,
    this.companyName,
    this.plannedQuantity,
    this.outboundQuantity,
    int? backupQty,
    this.planDate,
    this.rdate,
    this.state,
    this.stockQuantity,
  }) : backupQty = backupQty ?? outboundQuantity;

  factory OutboundInstruction.fromJson(Map<String, dynamic> json) {
    int? outboundQuantity = json['outbound_quantity'];
    return OutboundInstruction(
      outboundId: json['outbound_id'],
      itemName: json['item_name'],
      warehouseName: json['warehouse_name'],
      angleName: json['angle_name'],
      companyName: json['company_name'],
      plannedQuantity: json['planned_quantity'],
      outboundQuantity: outboundQuantity,
      backupQty: outboundQuantity,
      planDate: json['plan_date'],
      rdate: json['rdate'],
      state: json['state'],
      stockQuantity: json['stock_quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'outbound_id': this.outboundId,
    'item_name': this.itemName ?? '',
    'warehouse_name': this.warehouseName ?? '',
    'angle_name': this.angleName ?? '',
    'company_name': this.companyName ?? '',
    'planned_quantity': this.plannedQuantity ?? '',
    'outbound_quantity': this.outboundQuantity ?? '',
    'backup_qty': this.backupQty ?? '',
    'plan_date': this.planDate ?? '',
    'rdate': this.rdate ?? '',
    'state': this.state ?? '',
    'stock_quantity': this.stockQuantity ?? '',
  };

  static List<OutboundInstruction> jsonToList(dynamic json) {
    return (json as List).map((data) => OutboundInstruction.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'OutboundInstruction{id: $outboundId, quantity: $outboundQuantity}';
  }

  //state와 saveList를 비교할때 같은 데이터를 가져도 같은 객체를 참조하지 않는지 동일하다고 판단하지 않음
  // == 연산자를 오버라이드해 데이터값을 비교
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OutboundInstruction &&
        other.outboundId == outboundId &&
        other.outboundQuantity == outboundQuantity;
  }

  @override
  int get hashCode => outboundId.hashCode ^ outboundQuantity.hashCode;



  OutboundInstruction copyWith({
    int? outboundId,
    String? itemName,
    String? warehouseName,
    String? angleName,
    String? companyName,
    int? plannedQuantity,
    int? outboundQuantity,
    int? backupQty,
    String? planDate,
    String? rdate,
    int? state,
    int? stockQuantity,
  }) {
    return OutboundInstruction(
      outboundId: outboundId ?? this.outboundId,
      itemName: itemName ?? this.itemName,
      warehouseName: warehouseName ?? this.warehouseName,
      angleName: angleName ?? this.angleName,
      companyName: companyName ?? this.companyName,
      plannedQuantity: plannedQuantity ?? this.plannedQuantity,
      outboundQuantity: outboundQuantity ?? this.outboundQuantity,
      backupQty: backupQty ?? this.backupQty,
      planDate: planDate ?? this.planDate,
      rdate: rdate ?? this.rdate,
      state: state ?? this.state,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }
}
