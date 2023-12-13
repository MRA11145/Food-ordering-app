import 'package:flutter/material.dart';
import 'package:plateron_app/models/food_item.dart';
import 'package:plateron_app/providers/orders.dart';
import 'package:plateron_app/utils/media_query.dart';
import 'package:provider/provider.dart';

import '../constants/strings_constants.dart';
import '../helperWidgets/single_food_item.dart';
import '../utils/common_widgets.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const routeName = "/checkout";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Consumer<Orders>(builder: (context, ordersProvider, _) {
        List<FoodItem> orderData = ordersProvider.getAllFoodItem();
        return orderData.isEmpty
            ? const EmptyCart()
            : Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQueryUtil.getDefaultHeightDim(250)),
                    child: ListView.builder(
                      itemCount: ordersProvider.getTotalItemsInCart(),
                      itemBuilder: (context, index) {
                        var foodItem = orderData[index];
                        return SingleFoodItem(
                          foodItem: foodItem,
                          forCheckout: true,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQueryUtil.getDefaultHeightDim(200)),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQueryUtil.getDefaultWidthDim(60),
                          ),
                          CommonWidgets.FontWidget("Total", Colors.black, FontWeight.w700, "Inter", FontStyle.normal, 60, TextAlign.left),
                          Expanded(child: Container()),
                          CommonWidgets.FontWidget("\$${ordersProvider.getTotalPrice()}", Colors.black, FontWeight.w700, "Inter", FontStyle.normal, 60, TextAlign.left),
                          SizedBox(
                            width: MediaQueryUtil.getDefaultWidthDim(60),
                          ),
                          
                        ],
                      ),
                    ),
                  )
                ],
              );
      }),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CommonWidgets.FontWidget(StringConstants.cartEmpty, Colors.black, FontWeight.w700, "Inter", FontStyle.normal, 80, TextAlign.center),
      ),
    );
  }
}
