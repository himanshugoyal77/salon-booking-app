import 'dart:convert';

import 'package:salon_app/db/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDb {
  static Future<void> setUserInfo(UserModel? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'userKey',
        jsonEncode(
          user!.toJson(),
        ));
    print('User Info Saved');
  }

  static Future<UserModel?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel? user;
    if (prefs.containsKey('userKey')) {
      user = UserModel.fromJson(jsonDecode(prefs.getString('userKey')!));
    }
    return user!;
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userKey');
    print('User Info Removed');
  }
}
