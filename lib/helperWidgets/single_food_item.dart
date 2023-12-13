import 'package:flutter/material.dart';
import 'package:plateron_app/constants/strings_constants.dart';
import 'package:plateron_app/helperWidgets/plus_minus_button.dart';
import 'package:plateron_app/models/food_item.dart';
import 'package:plateron_app/providers/orders.dart';
import 'package:plateron_app/utils/common_widgets.dart';
import 'package:plateron_app/utils/media_query.dart';
import 'package:plateron_app/utils/path_utils.dart';
import 'package:provider/provider.dart';

class SingleFoodItem extends StatelessWidget {
  FoodItem foodItem;
  bool forCheckout = false;

  SingleFoodItem({super.key, required this.foodItem, this.forCheckout = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<Orders>(builder: (context, ordersProvider, _) {
      return Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQueryUtil.getValueInPixel(400),
            width: MediaQueryUtil.getValueInPixel(400),
            child: Image(
              image: AssetImage(
                PathUtil.getBaseImagePath(foodItem.img!),
              ),
            ),
          ),
          SizedBox(
            width: MediaQueryUtil.getValueInPixel(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidgets.FontWidget(foodItem.name!, Colors.black, FontWeight.w700, "Inter", FontStyle.normal, 50, TextAlign.left),
              SizedBox(
                height: MediaQueryUtil.getValueInPixel(20),
              ),
              CommonWidgets.FontWidget(foodItem.desc!, Colors.black, FontWeight.w400, "Inter", FontStyle.normal, 40, TextAlign.left),
              SizedBox(
                height: MediaQueryUtil.getValueInPixel(40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to the left and right
                children: [
                  Container(
                    height: MediaQueryUtil.getValueInPixel(30),
                    width: MediaQueryUtil.getValueInPixel(30),
                    color: foodItem.veg! ? Colors.green : Colors.red,
                  ),
                  SizedBox(
                    width: MediaQueryUtil.getValueInPixel(30),
                  ),
                  getFoodPrices(foodItem),
                  SizedBox(
                    width: MediaQueryUtil.getValueInPixel(30),
                  ),
                  ordersProvider.getItemCount(foodItem) > 0
                      ? PlusMinusButtons(
                          addQuantity: () {
                            ordersProvider.addDataInOrderMap(foodItem);
                          },
                          deleteQuantity: () {
                            ordersProvider.deleteDataFromOrderMap(foodItem);
                          },
                          text: "${ordersProvider.getItemCount(foodItem)}")
                      : ElevatedButton(
                          onPressed: () {
                            ordersProvider.addDataInOrderMap(foodItem);
                          },
                          child: CommonWidgets.FontWidget(StringConstants.add, Colors.black, FontWeight.w700, "Inter", FontStyle.normal, 40, TextAlign.center),
                        ),
                ],
              ),
            ],
          ),
        ],
      ));
    });
  }

  Widget getFoodPrices(FoodItem foodItem) {
    double price = foodItem.price!;
    int count = foodItem.count!;
    double finalPrice = forCheckout ? price * count : price;
    return CommonWidgets.FontWidget('\$${finalPrice.toStringAsFixed(2)}', Colors.black, FontWeight.w700, "Inter", FontStyle.normal, 40, TextAlign.left);
  }
}

/**
 * return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(desc),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${price.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                // Add your logic here to handle button press
                // e.g., increment count or add to the cart
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
 */
