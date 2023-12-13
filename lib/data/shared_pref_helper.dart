import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/food_item.dart';

class SharedPrefHelper {
  static const String keyFoodItems = 'food_items';

  // Save the list of FoodItem objects to SharedPreferences
  static Future<void> saveFoodItems(List<FoodItem> foodItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> foodItemsMapList = foodItems.map((foodItem) => foodItem.toJson()).toList();

    String foodItemsJson = json.encode(foodItemsMapList);

    prefs.setString(keyFoodItems, foodItemsJson);
  }

  // Retrieve the list of FoodItem objects from SharedPreferences
  static Future<List<FoodItem>> getFoodItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? foodItemsJson = prefs.getString(keyFoodItems);

    if (foodItemsJson != null) {
      List<dynamic> foodItemsList = json.decode(foodItemsJson);

      List<FoodItem> foodItems = foodItemsList.map((item) => FoodItem.fromJson(item)).toList();

      return foodItems;
    } else {
      return [];
    }
  }
}
