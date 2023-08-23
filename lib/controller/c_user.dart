import 'package:get/get.dart';
import 'package:hotelio_app/models/user_model.dart';

class CUSer extends GetxController {
  final _data = UserModel().obs;
  UserModel get data => _data.value;
  setData(n) => _data.value = n;
}
