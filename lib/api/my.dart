// 猜你喜欢
import 'package:flutter_test_project/constants/index.dart';
import 'package:flutter_test_project/utils/dioRequest.dart';
import 'package:flutter_test_project/viewmodels/home.dart';

Future<SpecialDetailGoodsItems> guessLikeApi(Map<String, dynamic> params) async {
  return SpecialDetailGoodsItems.formJSON(
    await dioRequest.get(HttpConstants.guessList, params: params),
  );
}
