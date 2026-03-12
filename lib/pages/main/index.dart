import 'package:flutter/material.dart';
import 'package:flutter_test_project/api/user.dart';
import 'package:flutter_test_project/pages/device/index.dart';
import 'package:flutter_test_project/pages/digitalMall/index.dart';
import 'package:flutter_test_project/pages/home/index.dart';
import 'package:flutter_test_project/pages/my/index.dart';
import 'package:flutter_test_project/stores/TokenManager.dart';
import 'package:flutter_test_project/stores/UserController.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行渲染4个导航
  // 一般应用程序的导航是固定的
  final List<Map<String, String>> _tabList = [
    {
      "icon": 'lib/assets/mall.png',
      'active_icon': 'lib/assets/select-mall.png',
      "text": '首页',
    },
    {
      "icon": 'lib/assets/digital-mall.png',
      'active_icon': 'lib/assets/select-digital-mall.png',
      "text": '社区',
    },
    {
      "icon": 'lib/assets/device.png',
      'active_icon': 'lib/assets/select-device.png',
      "text": '设备',
    },
    {
      "icon": 'lib/assets/my.png',
      'active_icon': 'lib/assets/select-my.png',
      "text": '我的',
    },
  ];

  int _currentIndex = 0;

  // 返回底部渲染的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]['icon']!, width: 20, height: 20),
        activeIcon: Image.asset(
          _tabList[index]['active_icon']!,
          width: 20,
          height: 20,
        ),
        label: _tabList[index]['text'],

        backgroundColor: Colors.black,
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), DigitalMallView(), DeviceView(), MyView()];
  }

  @override
  void initState() {
    super.initState();
    // 初始化token
    _initUser();
  }

  final UserController _userController = Get.put(UserController());

  _initUser() async {
    await tokenManager.init(); // 初始化token
    if (tokenManager.getToken().isNotEmpty) {
      // 有token 直接请求用户信息
      _userController.updateUserInfo(await userProfileApi());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 避开安全区
      body: SafeArea(
        child: IndexedStack(children: _getChildren(), index: _currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        onTap: (int index) {
          // index 当前打印的索引
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
