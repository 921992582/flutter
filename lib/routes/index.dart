// 管理路由

import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/login/index.dart';
import 'package:flutter_test_project/pages/main/index.dart';

// 返回app根级组件
Widget getRouteWeight() {
  return MaterialApp(routes: getRootRoutes(), initialRoute: '/');
}

// 返回app的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {'/': (content) => MainPage(), '/login': (content) => LoginPage()};
}
