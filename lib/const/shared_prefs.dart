import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  final getData = GetStorage();

  final String login = "LOGIN";
  final String userName = "USER_NAME";
  final String userId = "USER_ID";
  final String userNumber = "USER_NUMBER";
  final String userToken = "USER_TOKEN";
  final String fcmNotificationToken = "FCM_NOTIFICATION_TOKEN";
  final String userDetails = "USER_DETAILS";
  final String roles = "ROLE";

  setLogin(bool loginEntry) {
    return getData.write(login, loginEntry);
  }

  getLogin() {
    return getData.read(login);
  }

  setName(String name) {
    getData.write(userName, name);
  }

  getName() {
    return getData.read(userName);
  }

  setId(String id) {
    getData.write(userId, id);
  }

  getId() {
    return getData.read(userId);
  }

  setNumber(String number) {
    getData.write(userNumber, number);
  }

  getNumber() {
    return getData.read(userNumber);
  }

  setToken(String token) {
    getData.write(userToken, token);
  }

  getToken() {
    return getData.read(userToken);
  }

  setFCMNotificationToken(String fcmToken) {
    getData.write(fcmNotificationToken, fcmToken);
  }

  getFCMNotificationToken() {
    return getData.read(fcmNotificationToken);
  }

  setUserDetails(String details) {
    getData.write(userDetails, details);
  }

  getUserDetails() {
    return getData.read(userDetails);
  }

  setRole(String role) {
    getData.write(roles, role);
  }

  getRole() {
    return getData.read(roles);
  }

  /// CLEAR ALL DATA
  setClearALlPref() {
    return getData.erase();
  }
}
