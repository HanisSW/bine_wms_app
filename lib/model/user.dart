class User {
  String? userIdx;
  String? userId;
  String? userName;
  String? userPw;
  String? userRole;
  String? userRdate;
  String? userUse;
  String? delYN;

  User({
    this.userIdx,
    this.userId,
    this.userName,
    this.userPw,
    this.userRole,
    this.userRdate,
    this.userUse,
    this.delYN,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userIdx: json['user_idx'],
      userId: json['user_id'],
      userName: json['user_name'],
      userPw: json['user_pw'],
      userRole: json['user_role'],
      userRdate: json['user_rdate'],
      userUse: json['user_use'],
      delYN: json['delYN'],
    );
  }

  Map<String, dynamic> toJson() => {
    'user_idx': this.userIdx,
    'user_id': this.userId ?? '',
    'user_name': this.userName ?? '',
    'user_pw': this.userPw ?? '',
    'user_role': this.userRole ?? '',
    'user_rdate': this.userRdate ?? '',
    'user_use': this.userUse ?? '',
    'delYN': this.delYN ?? '',
  };

// static List<User> jsonToList(dynamic json) {
  //   return (json as List).map((data) => User.fromJson(data)).toList();
  // }


}
