import 'package:flutter/material.dart';
import 'package:plateron_app/constants/strings_constants.dart';
import 'package:plateron_app/helperWidgets/cart_bar.dart';
import 'package:plateron_app/models/food_item.dart';
import 'package:plateron_app/utils/common_widgets.dart';
import 'package:plateron_app/utils/media_query.dart';

import '../apiServices/api_service.dart';
import '../helperWidgets/single_food_item.dart';
import '../utils/screen_trans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void handlePlaceOrderRedirection() {
    Navigator.push(context, ScreenTrans.checkOutScreen());
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CommonWidgets.FontWidget(StringConstants.homeTile, Colors.black, FontWeight.w500, "inter", FontStyle.italic, 40, TextAlign.center),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MediaQueryUtil.getDefaultHeightDim(250)),
            child: FutureBuilder<List<FoodItem>>(
              future: ApiService.fetchFoodItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(StringConstants.genericError),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var foodItem = snapshot.data![index];
                      return SingleFoodItem(
                        foodItem: foodItem,
                      );
                    },
                  );
                }
              },
            ),
          ),
          CartBar(handlePlaceOrder: handlePlaceOrderRedirection)
        ],
      ),
    );
  }
}
