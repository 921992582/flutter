import 'package:flutter/material.dart';
import 'package:flutter_test_project/api/my.dart';
import 'package:flutter_test_project/components/home/home_more_list.dart';
import 'package:flutter_test_project/components/my/my_guess.dart';
import 'package:flutter_test_project/stores/TokenManager.dart';
import 'package:flutter_test_project/stores/UserController.dart';
import 'package:flutter_test_project/viewmodels/home.dart';
import 'package:flutter_test_project/viewmodels/user.dart';
import 'package:get/get.dart';

class MyView extends StatefulWidget {
  const MyView({super.key});

  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  final UserController _userController = Get.find();

  Widget _getLogout() {
    return _userController.user.value.id.isNotEmpty
        ? Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('确认退出登录吗？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // 点击注销
                          // 清楚本地token
                          await tokenManager.removeToken();
                          // 清空用户信息
                          _userController.updateUserInfo(UserInfo.fromJSON({}));
                          // 清空用户信息
                          Navigator.pop(context);
                        },
                        child: const Text('确认'),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                '退出',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.end,
              ),
            ),
          )
        : Text('');
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFF2E8), const Color(0xFFFDF6F1)],
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
          Obx(() {
            return CircleAvatar(
              radius: 26,
              backgroundImage: _userController.user.value.avatar.isNotEmpty
                  ? NetworkImage(_userController.user.value.avatar)
                  : const AssetImage('lib/assets/goods_avatar.png'),
              backgroundColor: Colors.white,
            );
          }),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  //  OBX中必须有可监测的响应式数据
                  return GestureDetector(
                    onTap: () {
                      // 跳转登录页
                      if (_userController.user.value.id.isEmpty) {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: Text(
                      _userController.user.value.id.isNotEmpty
                          ? '${_userController.user.value.nickname}'
                          : '立即登录',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() {
            return _getLogout();
          }),
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '升级美荟商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", '我的收藏'),
            item("lib/assets/ic_user_history.png", '我的足迹'),
            item("lib/assets/ic_user_unevaluated.png", '我的客服'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderModule() {
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的订单',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", '全部订单'),
                  orderItem("lib/assets/ic_user_obligation.png", '待付款'),
                  orderItem("lib/assets/ic_user_unreceived.png", '待发货'),
                  orderItem("lib/assets/ic_user_unshipped.png", '待收货'),
                  orderItem("lib/assets/ic_user_unevaluated.png", '待评价'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<GoodDetailItem> _list = [];
  // 分页的请求参数
  final Map<String, dynamic> _params = {"page": 1, "pageSize": 10};

  Future<void> _getGuessLike() async {
    if (_isLoading && !_hasMore) return;
    _isLoading = true;
    final res = await guessLikeApi(_params);
    _isLoading = false;
    _list.addAll(res.items);
    setState(() {});
    _hasMore = res.pages >= _params['page'];
    _params['page']++;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGuessLike();
    _registerEvent();
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels <=
          _controller.position.maxScrollExtent - 50) {
        print('加载更多');
        _getGuessLike();
        _isLoading = false;
      }
    });
  }

  // 阀门控制
  bool _isLoading = false; // 是否正在加载中
  bool _hasMore = true; // 是否还有更多数据
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildOrderModule()),
        // 猜你喜欢
        SliverPersistentHeader(delegate: MyGuess(), pinned: true),

        HomeMoreList(recommendList: _list),
      ],
    );
  }
}
