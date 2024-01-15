import 'package:talkangels/api/api_helper.dart';
import 'package:talkangels/const/request_constant.dart';
import 'package:talkangels/models/response_item.dart';

class AuthRepo {
  static Future<ResponseItem> userLogin(
      String name, String number, String cCode, String fcmToken) async {
    ResponseItem result;

    dynamic params = {
      "name": name,
      "mobile_number": number,
      "country_code": cCode,
      "fcmToken": fcmToken,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.logIn;

    result = await BaseApiHelper.postRequest(requestUrl, params);

    return result;
  }
}
