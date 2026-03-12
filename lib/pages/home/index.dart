import 'package:flutter/material.dart';
import 'package:flutter_test_project/api/home.dart';
import 'package:flutter_test_project/components/home/home_category.dart';
import 'package:flutter_test_project/components/home/home_hot.dart';
import 'package:flutter_test_project/components/home/home_more_list.dart';
import 'package:flutter_test_project/components/home/home_slider.dart';
import 'package:flutter_test_project/components/home/home_suggestion.dart';
import 'package:flutter_test_project/utils/toastUtils.dart';
import 'package:flutter_test_project/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播数据
  List<BannerItem> _bannerList = [];
  // 分类数据
  List<CategoryItem> _categoryList = [];

  // 热门推荐数据
  SpecialRecommend _hotPreference = SpecialRecommend(
    id: '',
    title: '',
    subTypes: [],
  );
  //

  // 热榜推荐数据
  SpecialRecommend _inVogueList = SpecialRecommend(
    id: '',
    title: '',
    subTypes: [],
  );
  // 一站式推荐数据
  SpecialRecommend _oneStopList = SpecialRecommend(
    id: '',
    title: '',
    subTypes: [],
  );

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 页码
  int _page = 1;
  //  记载状态
  bool _isLoading = false;
  // 是否还有更多数据
  bool _hasMore = true;

  // 获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HomeSlider(bannerList: _bannerList)), // 轮播图组件
      // 间隙
      SliverToBoxAdapter(child: SizedBox(width: double.infinity, height: 10)),
      // 放置分类组件
      SliverToBoxAdapter(
        child: HomeCategory(categoryList: _categoryList),
      ), // 分类
      // 间隙
      SliverToBoxAdapter(child: SizedBox(width: double.infinity, height: 10)),
      // 推荐组件
      SliverToBoxAdapter(
        child: HomeSuggestion(specialRecommend: _hotPreference),
      ), // 推荐
      // 间隙
      SliverToBoxAdapter(child: SizedBox(width: double.infinity, height: 10)),
      // 爆款
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HomeHot(result: _inVogueList, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HomeHot(result: _oneStopList, type: "step"),
              ),
            ],
          ),
        ),
      ),
      // 间隙
      SliverToBoxAdapter(child: SizedBox(width: double.infinity, height: 10)),
      // 无线滚动
      HomeMoreList(recommendList: _recommendList),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 注册监听事件
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  Future<void> _getBanerList() async {
    _bannerList = await getBannerListApi();
  }

  // 获取分类数据
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListApi();
  }

  // 获取热门推荐数据
  Future<void> _getHotPreference() async {
    _hotPreference = await getHotPreferenceApi();
  }

  // 获取热榜推荐数据
  Future<void> _getInVogueList() async {
    _inVogueList = await getInVogueListApi();
  }

  // 获取一站式推荐数据
  Future<void> _getOneStopList() async {
    _oneStopList = await getOneStopListApi();
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    int requestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({'limit': requestLimit});
    _isLoading = false;
    setState(() {});
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 监听滚动事件
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels <=
          _controller.position.maxScrollExtent - 50) {
        // 加载更多数据
        _getRecommendList();
      }
    });
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBanerList();
    await _getCategoryList();
    await _getHotPreference();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    _paddingTop = 0;
    setState(() {});

    // 数据获取成功，弹窗
    ToastUtils.showToast(context, "刷新成功");
  }

  final ScrollController _controller = ScrollController();
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();

  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
