import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';

class Merchandise extends StatelessWidget {
  const Merchandise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: const Text(
          "MERCHANDISE",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/shirt.png'),
                    width: 300,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    "Grab your free T-Shirt!!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    "We are giving out 100 free T-Shirts for all Najia App users. Feel free to grab yours now & dont forget to leave 5 start rating for our App review.",
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 22.0),
                //   child: Text(
                //     "Contact details",
                //     style: TextStyle(
                //         fontSize: 14, height: 1.5, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(right: 20.0, left: 20.0),
                //   child: TextField(
                //     cursorColor: NajiaColors.black,
                //     decoration: InputDecoration(
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         disabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide: BorderSide(
                //               width: 1,
                //             )),
                //         errorBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide:
                //                 BorderSide(width: 1, color: NajiaColors.black)),
                //         focusedErrorBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide:
                //                 BorderSide(width: 1, color: NajiaColors.black)),
                //         labelText: 'Fullname',
                //         labelStyle: TextStyle(
                //           color: NajiaColors.black,
                //         ),
                //         hintText: 'Enter your fullname'),
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
                //   child: TextField(
                //     cursorColor: NajiaColors.black,
                //     decoration: InputDecoration(
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         disabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide: BorderSide(
                //               width: 1,
                //             )),
                //         errorBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide:
                //                 BorderSide(width: 1, color: NajiaColors.black)),
                //         focusedErrorBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide:
                //                 BorderSide(width: 1, color: NajiaColors.black)),
                //         labelText: 'Phone number',
                //         labelStyle: TextStyle(
                //           color: NajiaColors.black,
                //         ),
                //         hintText: 'Enter your phone number'),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 22.0),
                //   child: Text(
                //     "Shipping details",
                //     style: TextStyle(
                //         fontSize: 14, height: 1.5, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
                //   child: TextField(
                //     cursorColor: NajiaColors.black,
                //     decoration: InputDecoration(
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         disabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(4)),
                //           borderSide:
                //               BorderSide(width: 1, color: NajiaColors.black),
                //         ),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide: BorderSide(
                //               width: 1,
                //             )),
                //         errorBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide:
                //                 BorderSide(width: 1, color: NajiaColors.black)),
                //         focusedErrorBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4)),
                //             borderSide:
                //                 BorderSide(width: 1, color: NajiaColors.black)),
                //         labelText: 'Full address',
                //         labelStyle: TextStyle(
                //           color: NajiaColors.black,
                //         ),
                //         hintText: 'Enter your full address'),
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    "Sorry, this promotion has ended",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NajiaColors.black,
                        ),
                        onPressed: null,
                        child: const Text("GRAB MY FREE T-SHIRT")),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
