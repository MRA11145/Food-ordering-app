import 'package:flutter/material.dart';
import 'package:plateron_app/constants/strings_constants.dart';
import 'package:plateron_app/providers/orders.dart';
import 'package:plateron_app/utils/media_query.dart';
import 'package:provider/provider.dart';

import '../utils/common_widgets.dart';

class CartBar extends StatelessWidget {
  final VoidCallback handlePlaceOrder;
  const CartBar({super.key, required this.handlePlaceOrder});

  @override
  Widget build(BuildContext context) {
    return Consumer<Orders>(
      builder: (context, orderProvider, _) {
        int totalItems = orderProvider.getTotalItemsInCart();
        return totalItems <= 0
            ? Container()
            : Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: MediaQueryUtil.getValueInPixel(20),
                      ),
                      CommonWidgets.FontWidget("$totalItems" + " " + (totalItems > 1 ? StringConstants.items : StringConstants.item), Colors.black, FontWeight.w700, "Inter", FontStyle.normal, 40, TextAlign.left),
                      Expanded(
                        child: Container(),
                      ),
                      GestureDetector(
                        onTap: () {
                          handlePlaceOrder();
                        },
                        child: Container(
                          height: MediaQueryUtil.getValueInPixel(130),
                          width: MediaQueryUtil.getValueInPixel(400),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: CommonWidgets.FontWidget(StringConstants.placeOrder, Colors.white, FontWeight.w700, "Inter", FontStyle.normal, 50, TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
