class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例化对象
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    // 必须返回BannerItem对象
    return BannerItem(id: json['id'] ?? '', imgUrl: json['imgUrl'] ?? '');
  }
}
//

// 根据json编写class对象和工厂转换函数
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例化对象
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    // 必须返回CategoryItem对象
    return CategoryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: json['children'] != null
          ? (json['children'] as List)
                .map((e) => CategoryItem.formJSON(e))
                .toList()
          : null,
    );
  }
}

// 特惠推荐 - 单个商品
class SpecialItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int? orderNum;

  SpecialItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    this.orderNum,
  });

  factory SpecialItem.formJSON(Map<String, dynamic> json) {
    return SpecialItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price'] ?? '0.00',
      picture: json['picture'] ?? '',
      orderNum: json['orderNum'],
    );
  }
}

// 特惠推荐 - 商品列表包装
class SpecialGoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<SpecialItem> items;

  SpecialGoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory SpecialGoodsItems.formJSON(Map<String, dynamic> json) {
    return SpecialGoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 10,
      pages: json['pages'] ?? 1,
      page: json['page'] ?? 1,
      items: (json['items'] as List? ?? [])
          .map((e) => SpecialItem.formJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

// 特惠推荐 - 子分类
class SpecialSubType {
  String id;
  String title;
  SpecialGoodsItems goodsItems;

  SpecialSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory SpecialSubType.formJSON(Map<String, dynamic> json) {
    return SpecialSubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: SpecialGoodsItems.formJSON(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }
}

// 特惠推荐 - 根对象 (result)
class SpecialRecommend {
  String id;
  String title;
  List<SpecialSubType> subTypes;

  SpecialRecommend({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommend.formJSON(Map<String, dynamic> json) {
    return SpecialRecommend(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: (json['subTypes'] as List? ?? [])
          .map((e) => SpecialSubType.formJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodDetailItem extends SpecialItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

// 特惠推荐 - 商品列表包装

class SpecialDetailGoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;

  SpecialDetailGoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory SpecialDetailGoodsItems.formJSON(Map<String, dynamic> json) {
    return SpecialDetailGoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 10,
      pages: json['pages'] ?? 1,
      page: json['page'] ?? 1,
      items: (json['items'] as List? ?? [])
          .map((e) => GoodDetailItem.formJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
