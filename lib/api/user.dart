// 登录接口地址
import 'package:flutter_test_project/constants/index.dart';
import 'package:flutter_test_project/utils/dioRequest.dart';
import 'package:flutter_test_project/viewmodels/user.dart';

Future<UserInfo> loginApi(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.login, data: data),
  );
}

Future<UserInfo> userProfileApi() async {
  return UserInfo.fromJSON(await dioRequest.get(HttpConstants.userProfile));
}
