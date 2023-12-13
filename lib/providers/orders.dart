import 'package:flutter/material.dart';
import 'package:plateron_app/models/food_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/shared_pref_helper.dart';

class Orders extends ChangeNotifier {
  List<FoodItem> orderData = [];

  Orders () {
    load();
  }

  /// Load the old data
  Future<void> load() async {
    orderData = await SharedPrefHelper.getFoodItems();
    notifyListeners();
  }

  // Save the current status
  Future<void> save() async {
    await SharedPrefHelper.saveFoodItems(orderData);
  }
  
  // Add a food item to the order list
  void addDataInOrderMap(FoodItem newFoodItem) {
    var existing = orderData.firstWhere(
      (element) => element.pid1 == newFoodItem.pid1,
      orElse: () => FoodItem(pid1: ""), // Default empty item if not found
    );

    if (existing.pid1!.isNotEmpty) {
      // Item already exists, increment the count
      existing.count = existing.count! + 1;
    } else {
      // Item doesn't exist, add a new item
      newFoodItem.count = 1;
      debugPrint("Orders added -> $newFoodItem");
      orderData.add(newFoodItem);
    }
    notifyListeners();
    save();
  }

  // Get the count of a specific food item in the order
  int getItemCount(FoodItem foodItem) {
    var existing = orderData.firstWhere(
      (element) => element.pid1 == foodItem.pid1,
      orElse: () => FoodItem(pid1: "", count: 0), // Default item with count 0 if not found
    );
    return existing.count!;
  }

  // Delete a food item from the order list
  void deleteDataFromOrderMap(FoodItem foodItemToDelete) {
    var existingIndex = orderData.indexWhere(
      (element) => element.pid1 == foodItemToDelete.pid1,
    );

    if (existingIndex != -1) {
      // Item found, decrement the count or remove if count is 1
      if (orderData[existingIndex].count! > 1) {
        orderData[existingIndex].count = orderData[existingIndex].count! - 1;
      } else {
        orderData.removeAt(existingIndex);
      }
      notifyListeners();
    }
    save();
  }

  // Get the list of all food items in the order
  List<FoodItem> getAllFoodItem() {
    return orderData;
  }

  // Calculate the total price of all items in the order
  double getTotalPrice() {
    double price = 0;
    orderData.forEach((element) {
      price += element.price! * element.count!;
    });
    return price;
  }

  // Get the total number of items in the cart
  int getTotalItemsInCart() {
    return orderData.length;
  }
}
