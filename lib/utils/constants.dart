class PreferenceKey {
  static const String USER = 'USER';
  static const String USER_SNS = 'USER_SNS';
  static const String LAST_LOGIN_USER_TYPE = "LAST_LOGIN_USER_TYPE";
}

class ApiResponseCode {
  static const int SUCCESS = 200;
  static const int NOT_FOUND_USER = 100;
  static const int NOT_FOUND_SNS_ID = 101;
  static const int NOT_FOUND_USER_SNS = 102;
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
