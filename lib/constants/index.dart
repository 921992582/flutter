// 全局的常量
class GlobalConstants {
  static const String baseUrl = "https://meikou-api.itheima.net";
  static const int tileOut = 10;
  static const String successCode = '1';
  static const String tokenKey = 'token';
}

// 存放请求地址接口的常量

class HttpConstants {
  static const String bannerList = '/home/banner';
  static const String categoryList = '/home/category/head'; // 分裂列表
  static const String hotPreference = '/hot/preference'; // 热门推荐
  static const String inVogueList = '/hot/inVogue'; // 热榜推荐地址
  static const String oneStopList = '/hot/oneStop'; // 一站式推荐地址

  static const String recommendList = "/home/recommend"; // 推荐列表
  static const String guessList = "/home/goods/guessLike"; // 猜你喜欢
  static const String login = "/login"; // 登录

  static const String userProfile = "/member/profile"; // 用户信息
}
