// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
// import 'package:najia/constant.dart';
// import 'package:http/http.dart' as http;

// class NearestMosque extends ExamplePage {
//   NearestMosque() : super(const Icon(Icons.map), 'Polygon Annotations');

//   @override
//   Widget build(BuildContext context) {
//     return const PolygonAnnotationPageBody();
//   }
// }

// class PolygonAnnotationPageBody extends StatefulWidget {
//   const PolygonAnnotationPageBody();

//   @override
//   State<StatefulWidget> createState() => PolygonAnnotationPageBodyState();
// }

// class AnnotationClickListener extends OnPolygonAnnotationClickListener {
//   @override
//   void onPolygonAnnotationClick(PolygonAnnotation annotation) {
//     print("onAnnotationClick, id: ${annotation.id}");
//   }
// }

// class StateCoordinate {
//   final double latitude;
//   final double longitude;
//   final double zoom;
//   final double pitch;
//   final String name;

//   StateCoordinate(
//       this.latitude, this.longitude, this.zoom, this.pitch, this.name);
// }

// class PolygonAnnotationPageBodyState extends State<PolygonAnnotationPageBody> {
//   MapboxMap? mapboxMap;
//   PolygonAnnotationManager? polygonAnnotationManager;

//   _onMapCreated(MapboxMap mapboxMap) {
//     this.mapboxMap = mapboxMap;
//     mapboxMap.annotations.createPolygonAnnotationManager().then((value) {
//       polygonAnnotationManager = value;
//     });
//     mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
//     mapboxMap.logo.updateSettings(LogoSettings(marginLeft: -900));
//     mapboxMap.attribution.updateSettings(AttributionSettings(marginLeft: -900));
//     mapboxMap.style.setProjection('globe');
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentPosition();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future<void> _getCurrentPosition() async {
//     Location location = Location();
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;

//     // Check if location services are enabled
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         print('Location services are disabled');
//         return;
//       }
//     }

//     // Check location permission
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         print('Location permission denied');
//         return;
//       }
//     }

//     // Get the current location
//     try {
//       _locationData = await location.getLocation();
//       double latitude = _locationData.latitude!;
//       double longitude = _locationData.longitude!;
//       print('Latitude: $latitude, Longitude: $longitude');
//       mapboxMap?.easeTo(
//           CameraOptions(
//               center:
//                   Point(coordinates: Position(longitude, latitude)).toJson(),
//               zoom: 10,
//               bearing: 0,
//               pitch: 10),
//           MapAnimationOptions(duration: 4000, startDelay: 0));
//       await fetchNearbyMosques(latitude, longitude);
//     } catch (e) {
//       print('Error getting location: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const String ACCESS_TOKEN =
//         "pk.eyJ1IjoienZoaXI5OCIsImEiOiJjbG53dnk1cXIwZnlmMmtvYXowandhMGxkIn0.bPPj0B1QV2nYz4Ml3yR8tA";

//     final MapWidget mapWidget = MapWidget(
//         key: const ValueKey("mapWidget"),
//         resourceOptions: ResourceOptions(accessToken: ACCESS_TOKEN),
//         cameraOptions: CameraOptions(
//           center: Point(
//             coordinates: Position(3.028320512111406,
//                 101.33318622918793), // Coordinates for Kuala Lumpur
//           ).toJson(),
//           zoom: 22,
//         ),
//         styleUri: MapboxStyles.NAJIA_MAPBOX_STYLE,
//         onMapCreated: _onMapCreated);

//     return Scaffold(
//       body: Stack(
//         children: [
//           mapWidget,
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                   color: NajiaColors.bgColor
//                   ),
//               child: const Padding(
//                 padding: EdgeInsets.only(
//                     top: 16.0, right: 16.0, left: 16.0, bottom: 40),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "NEAREST MOSQUE (±10KM)",
//                       style: TextStyle(
//                           fontSize: 12, letterSpacing: 8, color: Colors.black),
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),

//                     Text("Masjid 1"),
//                     Text("Masjid 2"),
//                     Text("Masjid 3"),
//                     Text("Masjid 4"),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> fetchNearbyMosques(double latitude, double longitude) async {
//     final apiKey = 'AIzaSyBW_r0D8eMsaBPEi1JkqrSZZS9JOgrF0fk';
//     final radius = 1000;
//     final type = 'mosque';

//     print("sini");

//     final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
//         'location=$latitude,$longitude'
//         '&radius=$radius'
//         '&type=$type'
//         '&key=$apiKey';

//     final response = await http.get(Uri.parse(url));

//     print(response.body);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final results = data['results'];

//       for (var result in results) {
//         final name = result['name'];
//         final location = result['geometry']['location'];
//         final mosqueLatitude = location['lat'];
//         final mosqueLongitude = location['lng'];

//         print(name);
//         print(location);
//         print(mosqueLatitude);
//         print(mosqueLongitude);

//         // Add code to display markers for nearby mosques on the Mapbox map
//         // final mosqueMarker = Symbol(
//         //   geometry: Point.fromLngLat(mosqueLongitude, mosqueLatitude),
//         //   iconImage:
//         //       'mosque-icon', // Assuming you have a mosque icon loaded in your Mapbox style
//         //   iconSize: 1.0,
//         // );
//         // mapboxMap?.addSymbol(mosqueMarker);
//       }
//     } else {
//       print('Failed to retrieve nearby mosques');
//     }
//   }
// }

// abstract class ExamplePage extends StatelessWidget {
//   const ExamplePage(this.leading, this.title);

//   final Widget leading;
//   final String title;
// }
