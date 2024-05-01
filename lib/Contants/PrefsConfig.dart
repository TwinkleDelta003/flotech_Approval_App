import 'package:shared_preferences/shared_preferences.dart';

import 'PrefsContants.dart';

class PrefsConfig {
  static SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static String getUserId() {
    return _prefsInstance.getString(Constants.userId) ?? '';
  }

  static Future<bool> setUserId(String userId) {
    ArgumentError.checkNotNull(userId, Constants.userId);
    return _prefsInstance.setString(Constants.userId, userId);
  }

  static String getDivTextId() {
    return _prefsInstance.getString(Constants.divTextId) ?? '';
  }

  static Future<bool> setDivtextId(String divTextId) {
    ArgumentError.checkNotNull(divTextId, Constants.divTextId);
    return _prefsInstance.setString(Constants.divTextId, divTextId);
  }

  static String getAdmin() {
    return _prefsInstance.getString(Constants.isAdmin) ?? '';
  }

  static Future<bool> setAdmin(String isAdmin) {
    ArgumentError.checkNotNull(isAdmin, Constants.isAdmin);
    return _prefsInstance.setString(Constants.isAdmin, isAdmin);
  }

  static String getEmpId() {
    return _prefsInstance.getString(Constants.empId) ?? '';
  }

  static Future<bool> setEmpId(String empId) {
    ArgumentError.checkNotNull(empId, Constants.empId);
    return _prefsInstance.setString(Constants.empId, empId);
  }

  static String getUserName() {
    return _prefsInstance.getString(Constants.userName) ?? '';
  }

  static Future<bool> setUserName(String userName) {
    ArgumentError.checkNotNull(userName, Constants.userName);
    return _prefsInstance.setString(Constants.userName, userName);
  }

  static String getFirstName() {
    return _prefsInstance.getString(Constants.firstName) ?? '';
  }

  static Future<bool> setFirstName(String firstName) {
    ArgumentError.checkNotNull(firstName, Constants.firstName);
    return _prefsInstance.setString(Constants.firstName, firstName);
  }

  static String getLastName() {
    return _prefsInstance.getString(Constants.lastName) ?? '';
  }

  static Future<bool> setLastName(String lastName) {
    ArgumentError.checkNotNull(lastName, Constants.lastName);
    return _prefsInstance.setString(Constants.lastName, lastName);
  }

  static String getEmail() {
    return _prefsInstance.getString(Constants.email) ?? '';
  }

  static Future<bool> setEmail(String email) {
    ArgumentError.checkNotNull(email, Constants.email);
    return _prefsInstance.setString(Constants.email, email);
  }

  static String getPass() {
    return _prefsInstance.getString(Constants.email) ?? '';
  }

  static Future<bool> setPass(String pass) {
    ArgumentError.checkNotNull(pass, Constants.pass);
    return _prefsInstance.setString(Constants.pass, pass);
  }

  static String getIsLogin() {
    return _prefsInstance.getString(Constants.isLogin) ?? 'False';
  }

  static Future<bool> setIsLogin(String isLogin) {
    ArgumentError.checkNotNull(isLogin, Constants.isLogin);
    return _prefsInstance.setString(Constants.isLogin, isLogin);
  }

  static String getFCMId() {
    return _prefsInstance.getString(Constants.fcmId) ?? '';
  }

  static Future<bool> setFCMId(String fcmId) {
    ArgumentError.checkNotNull(fcmId, Constants.fcmId);
    return _prefsInstance.setString(Constants.fcmId, fcmId);
  }

  static String getMobileNo() {
    return _prefsInstance.getString(Constants.mobile) ?? '';
  }

  static Future<bool> setMobileNo(String mobile) {
    ArgumentError.checkNotNull(mobile, Constants.mobile);
    return _prefsInstance.setString(Constants.mobile, mobile);
  }

  static Future<bool> setWorkingEMP(bool empShow) {
    ArgumentError.checkNotNull(empShow, Constants.empShow);
    return _prefsInstance.setBool(Constants.empShow, empShow);
  }

  static bool getWorkingEMP() {
    return _prefsInstance.getBool(Constants.empShow) ?? true;
  }

  static String getProfilePic() {
    return _prefsInstance.getString(Constants.prfPic) ?? '';
  }

  static Future<bool> setProfilePic(String prfPic) {
    ArgumentError.checkNotNull(prfPic, Constants.prfPic);
    return _prefsInstance.setString(Constants.prfPic, prfPic);
  }
}
