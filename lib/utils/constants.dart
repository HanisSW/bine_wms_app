class PreferenceKey {
  static const String USER = 'USER';
  static const String USER_SNS = 'USER_SNS';
  static const String LAST_LOGIN_USER_TYPE = "LAST_LOGIN_USER_TYPE";
}

class ApiResponseCode {
  static const int SUCCESS = 200;
  // 아이디 비밀번호 불일치
  static const int NOT_FOUND_USER = 100;
  // 이용 중지 계정
  static const int NOT_USING_ID = 101;
  //삭제된 유저
  static const int DELETE_USER = 102;
  static const int NOT_FOUND_TOKEN = 103;
  static const int DUPLICATE_EMAIL = 104;
  static const int DUPLICATE_PHONE_NO = 105;
  static const int NOT_FOUND_PRODUCT_SALE = 106;
  static const int DATA_NOT_EXIST_SHOPPING_CART = 107;
  static const int DATA_NOT_EXIST_SHOPPING_CART_DETAIL = 108;
  static const int NOT_ENOUGH_POINT = 109;
  static const int NOT_MATCH_PASSWORD = 110;
  static const int NOT_FOUND_REGISTRATION_PRODUCT_LIST = 111;
  static const int EXIST_USER_PRODUCT = 112;
  static const int WAITING_USER_PRODUCT = 113;
  static const int DELETE_USER_PRODUCT = 114;
}
