import 'package:flutter_test_project/viewmodels/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs;
  //  想要取值的话 需要user.value
  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
