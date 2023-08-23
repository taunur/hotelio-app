import 'dart:convert';

import 'package:hotelio_app/controller/c_user.dart';
import 'package:hotelio_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Session {
  static Future<bool> saveUser(UserModel user) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    bool success = await pref.setString('user', stringUser);
    if (success) {
      final cUser = Get.put(CUSer());
      cUser.setData(user);
    }
    return success;
  }

  static Future<UserModel> getUser() async {
    UserModel user = UserModel(); // default value
    final pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null && stringUser.isNotEmpty) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = UserModel.fromJson(mapUser);
    }
    final cUser = Get.put(CUSer());
    cUser.setData(user);
    return user;
  }

  static Future<bool> clearUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');
    final cUser = Get.put(CUSer());
    cUser.setData(UserModel());
    return success;
  }
}
