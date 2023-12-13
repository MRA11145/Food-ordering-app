import '../models/food_item.dart';
import '../models/dummy_data.dart';

class ApiService {
  static Future<List<FoodItem>> fetchFoodItems() async {
    // Simulating an HTTP request delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulated response data
    return DummyData()
        .data
        .map((item) => FoodItem(
              pid1: item['pid1'],
              name: item['name'],
              desc: item['desc'],
              veg: item['veg'],
              price: item['price'].toDouble(),
              img: item['img'],
              count: item['count'],
            ))
        .toList();
  }
}
