//  封装一个api 目的是返回业务侧要的数据结构
import 'package:flutter_test_project/constants/index.dart';
import 'package:flutter_test_project/utils/dioRequest.dart';
import 'package:flutter_test_project/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.bannerList)) as List).map((item) {
    return BannerItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

// 分类列表
Future<List<CategoryItem>> getCategoryListApi() async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.categoryList)) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

// 热门推荐
Future<SpecialRecommend> getHotPreferenceApi() async {
  // 返回请求
  return SpecialRecommend.formJSON(
    await dioRequest.get(HttpConstants.hotPreference),
  );
}

// 热榜推荐
Future<SpecialRecommend> getInVogueListApi() async {
  // 返回请求
  return SpecialRecommend.formJSON(
    await dioRequest.get(HttpConstants.inVogueList),
  );
}

// 一站式推荐
Future<SpecialRecommend> getOneStopListApi() async {
  // 返回请求
  return SpecialRecommend.formJSON(
    await dioRequest.get(HttpConstants.oneStopList),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.recommendList, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
