import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/marketplace/product.dart';

class MarketPlace extends StatelessWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: NajiaColors.bgColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            "MARKETPLACE",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                mainAxisExtent: 250,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 16, // 2 rows with 4 items in total
              itemBuilder: (BuildContext context, int index) {
                return _buildMarketItem(context, index);
              },
            ),
          ),
        ));
  }

  Widget _buildMarketItem(context, int index) {
    return GestureDetector(
        onTap: () {
          // Navigate to the "Product" page when an item is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Product(image: 'assets/images/m${index + 1}.png')),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset('assets/images/m${index + 1}.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Product Name $index', // Replace with product name
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  'RM20.00',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
