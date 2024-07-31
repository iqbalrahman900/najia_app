// import 'package:flutter/material.dart';
// import 'package:najia/constant.dart';
// import 'package:najia/Screens/kiblat/compass_utils/compass_renderer.dart';
// import 'compass_utils/kiblat_channel.dart';
// import 'compass_utils/loading_indicator.dart';

// class KiblatFinder extends StatelessWidget {
//   KiblatFinder({Key? key}) : super(key: key);

//   final _deviceSupport = KiblatChannel.androidDeviceSensorSupport();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: NajiaColors.bgColor,
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           title: const Text(
//             "KIBLAT FINDER",
//             style:
//                 TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
//           ),
//         ),
//         body: FutureBuilder(
//           future: _deviceSupport,
//           builder: (_, AsyncSnapshot<bool?> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const LoadingIndicator();
//             }
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text("Error: ${snapshot.error.toString()}"),
//               );
//             }
//             if (snapshot.data!) {
//               return const CompassRenderer();
//             } else {
//               return const Text("Error");
//             }
//           },
//         ));
//   }
// }
