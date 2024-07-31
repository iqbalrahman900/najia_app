import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/marketplace/nego.dart';

class Product extends StatelessWidget {
  const Product({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: NajiaColors.bgColor,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          title: const Text(
            "PRODUCT",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              image,
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            const Text(
              "Tasbih", // Replace with product name
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'RM20.00',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Nego(),
                      ),
                    ),
                  },
                  child: TextButton(
                    onPressed: () => {},
                    style: TextButton.styleFrom(
                      backgroundColor: NajiaColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      "Kawtim",
                      style: const TextStyle(
                          color: NajiaColors.bgColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: GestureDetector(
                  child: TextButton(
                    onPressed: () => {},
                    style: TextButton.styleFrom(
                      backgroundColor: NajiaColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      "Checkout",
                      style: const TextStyle(
                          color: NajiaColors.bgColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}

// renderButton(text, context) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 10.0, right: 10),
//     child: SizedBox(
//       height: 40,
//       width: double.infinity,
//       child: GestureDetector(
//         onTap: () => {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (BuildContext context) => Nego(),
//             ),
//           ),
//         },
//         child: TextButton(
//           onPressed: () => {},
//           style: TextButton.styleFrom(
//             backgroundColor: NajiaColors.black,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//           ),
//           child: Text(
//             text,
//             style: const TextStyle(
//                 color: NajiaColors.bgColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     ),
//   );
// }
