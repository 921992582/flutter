import 'package:flutter/material.dart';
import 'package:flutter_test_project/viewmodels/home.dart';

class HomeSuggestion extends StatefulWidget {
  final SpecialRecommend specialRecommend;
  const HomeSuggestion({super.key, required this.specialRecommend});

  @override
  State<HomeSuggestion> createState() => _HomeSuggestionState();
}

class _HomeSuggestionState extends State<HomeSuggestion> {
  List<SpecialItem> _getSpecialItems() {
    if (widget.specialRecommend.subTypes.isEmpty) return [];
    return widget.specialRecommend.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          '特惠推荐',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          '精选省攻略',
          style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 116, 54, 49),
          ),
        ),
      ],
    );
  }

  // 左侧结构
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('lib/assets/home_cmd_inner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 右侧结构
  List<Widget> _buildRight() {
    return _getSpecialItems().map((item) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'lib/assets/home_cmd_inner.png',
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 240, 96, 22),
            ),
            child: Text(
              item.price,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('lib/assets/home_cmd_sm.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildRight(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
