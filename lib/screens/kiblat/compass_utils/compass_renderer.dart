// import 'dart:async';
// import 'dart:math' show pi;

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:najia/constant.dart';
// import 'package:najia/Animations/fade_animation.dart';
// import 'package:najia/Screens/kiblat/compass_utils/kiblat_channel.dart';
// import 'package:najia/Screens/kiblat/compass_utils/loading_indicator.dart';

// import 'location_error_widget.dart';

// class CompassRenderer extends StatefulWidget {
//   const CompassRenderer({super.key});

//   @override
//   _CompassRendererState createState() => _CompassRendererState();
// }

// class _CompassRendererState extends State<CompassRenderer> {
//   final _locationStreamController =
//       StreamController<LocationStatus>.broadcast();

//   get stream => _locationStreamController.stream;

//   @override
//   void initState() {
//     _checkLocationStatus();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(8.0),
//       child: StreamBuilder(
//         stream: stream,
//         builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return LoadingIndicator();
//           }
//           if (snapshot.data!.enabled == true) {
//             switch (snapshot.data!.status) {
//               case LocationPermission.always:
//               case LocationPermission.whileInUse:
//                 return CompassRendererWidget();
//               case LocationPermission.denied:
//                 return LocationErrorWidget(
//                   error: "Location service permission denied",
//                   callback: _checkLocationStatus,
//                 );
//               case LocationPermission.deniedForever:
//                 return LocationErrorWidget(
//                   error: "Location service Denied Forever !",
//                   callback: _checkLocationStatus,
//                 );
//               default:
//                 return const SizedBox();
//             }
//           } else {
//             return LocationErrorWidget(
//               error: "Please enable Location service",
//               callback: _checkLocationStatus,
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<void> _checkLocationStatus() async {
//     final locationStatus = await KiblatChannel.checkLocationStatus();
//     if (locationStatus.enabled &&
//         locationStatus.status == LocationPermission.denied) {
//       await KiblatChannel.requestPermissions();
//       final s = await KiblatChannel.checkLocationStatus();
//       _locationStreamController.sink.add(s);
//     } else {
//       _locationStreamController.sink.add(locationStatus);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _locationStreamController.close();
//     KiblatChannel().dispose();
//   }
// }

// class CompassRendererWidget extends StatelessWidget {
//   final _compassSvg = SvgPicture.asset('assets/images/compass1.svg');
//   final _needleSvg = SvgPicture.asset(
//     'assets/images/needle.svg',
//     fit: BoxFit.contain,
//     height: 300,
//     alignment: Alignment.center,
//   );

//   CompassRendererWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: KiblatChannel.qiblahStream,
//       builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return LoadingIndicator();
//         }
//         final qiblahDirection = snapshot.data!;
//         return Padding(
//           padding: const EdgeInsets.only(
//               top: 15.0, left: 15.0, right: 15.0, bottom: 100),
//           child: Container(
//               height: double.infinity,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: NajiaColors.bgColor,
//                 borderRadius: BorderRadius.circular(50), // rounded corners
//               ),
//               child: FadeAnimation(
//                 delay: 200,
//                 child: Padding(
//                   padding: const EdgeInsets.all(30.0),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       Transform.rotate(
//                         angle: (qiblahDirection.direction * (pi / 180) * -1),
//                         child: _compassSvg,
//                       ),
//                       Transform.rotate(
//                         angle: (qiblahDirection.qiblah * (pi / 180) * -1),
//                         alignment: Alignment.center,
//                         child: _needleSvg,
//                       ),
//                       Positioned(
//                         bottom: 8,
//                         child: Text(
//                             "Kiblat angle ${qiblahDirection.offset.toStringAsFixed(3)}°"),
//                       )
//                     ],
//                   ),
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }
