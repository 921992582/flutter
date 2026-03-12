import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/viewmodels/home.dart';

class HomeSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const HomeSlider({super.key, required this.bannerList});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
  Widget _getSlider() {
    // 获取图片宽度
    final double screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
      carouselController: _controller, //绑定carouselController
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          width: screenWidth,
          fit: BoxFit.cover,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlayInterval: Duration(seconds: 2),
        height: 300,
        onPageChanged: (index, reason) {
          _currentIndex = index;
          setState(() {});
        },
        autoPlay: true,
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            '搜索...',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 返回指示灯

  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.animateToPage(index);
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 6,
                width: _currentIndex == index ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
