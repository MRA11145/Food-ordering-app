class FoodItem {
  String? pid1;
  String? name;
  String? desc;
  bool? veg;
  double? price;
  String? img;
  int? count;

  FoodItem({
    this.pid1,
    this.name,
    this.desc,
    this.veg,
    this.price,
    this.img,
    this.count,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        pid1: json['pid1'] as String?,
        name: json['name'] as String?,
        desc: json['desc'] as String?,
        veg: json['veg'] as bool?,
        price: (json['price'] as num?)?.toDouble(),
        img: json['img'] as String?,
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'pid1': pid1,
        'name': name,
        'desc': desc,
        'veg': veg,
        'price': price,
        'img': img,
        'count': count,
      };

  @override
  String toString() {
    return 'FoodItem { pid1: $pid1, name: $name, desc: $desc, veg: $veg, price: $price, img: $img, count: $count }';
  }
}
