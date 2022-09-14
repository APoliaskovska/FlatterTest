import 'package:easy_localization/easy_localization.dart';

class Strings {
  static const String appTitle = "appTitle";

  //AUTH

  static const String auth_title = "auth_title";
  static const String login_field = "login_field";
  static const String password_field = "password_field";
  static const String sign_in_button = "sign_in_button";
  static const String user_not_found_error = "user_not_found_error";
  static const String error = "error";

  //MENU ITEMS

  static const String dashboard = "dashboard_title";
  static const String messages = "messages_title";
  static const String utility_bills = "utility_bills_title";
  static const String funds_transfer = "funds_transfer_title";

  //CARDS

  static const String cards = "cards_title";
  static const String transactions = "transactions_string";

  static const String language = "language";

  static const String card_limits = "card_limits";
  static const String change_pin = "change_pin";
  static const String freeze_card = "freeze_card";
  static const String close_card = "close_card";

  //PASSCODE STRINGS

  static const String enter_passcode = "enter_passcode_title";
  static const String create_passcode = "create_passcode_title";
  static const String confirm_passcode = "confirm_passcode_title";
  static const String biometric_error = "biometric_error";

  //TRANSACTIONS

  static const String expires = "expires";
  static const String search = "search";
  static const String search_transaction = "search_transaction";
  static const String success_status = "success_status";
  static const String fail_status = "fail_status";
  static const String transactions_not_found_error = "transactions_not_found_error";
  static const String fee = "fee";
  static const String status = "status";
  static const String no_transactions_text = "no_transactions";

  //PROFILE

  static const String profile_title = "profile_title";

  //FORLDERS

  static const String forlders_title = "forlders_title";

  //UPLOAD

  static const String upload_title = "upload_title";

  //TOP UP

  static const String top_up_title = "top_up_title";

  //SECURITY

  static const String security_item = "security_item";
  static const String enable_face_id = "enable_face_id";
  static const String show_passcode = "show_passcode";
  static const String settings = "settings_title";

  //CONTACT US

  static const String contact_us_title = "contact_us_title";
  static const String contact_us_text = "contact_us_text";

  //NOTIFICATIONS

  static const String notifications_title = "notifications_title";

}

extension Translation on String {
  String translate() {
    return this.tr();
  }
}
