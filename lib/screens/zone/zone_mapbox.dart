// import 'package:flutter/material.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
// import 'package:najia/constant.dart';
// import 'package:najia/screens/splashscreen/splashscreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Zone extends ExamplePage {
//   Zone() : super(const Icon(Icons.map), 'Polygon Annotations');

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
//   PolygonAnnotation? polygonAnnotation;
//   PolygonAnnotationManager? polygonAnnotationManager;
//   int styleIndex = 1;
//   Set<String> renderedStates = {}; // Keep track of rendered states
//   PolygonAnnotationPageBodyState();

//   final ScrollController _scrollController = ScrollController();

//   List<StateCoordinate> malaysiaStateCoordinates = [
//     StateCoordinate(2.002860615591771, 103.4646710204857, 8, 50, 'JOHOR'),
//     StateCoordinate(5.92689347153252, 100.51924296592466, 7, 20, 'KEDAH'),
//     StateCoordinate(6.1011678526507565, 102.27227067964363, 7, 10, 'KELANTAN'),
//     StateCoordinate(2.2851833491551425, 102.32079338607151, 8, 50, 'MELAKA'),
//     StateCoordinate(
//         2.812027336183091, 102.27126108211849, 8, 50, 'NEGERI SEMBILAN'),
//     StateCoordinate(3.647948108138217, 102.68495875805738, 6, 10, 'PAHANG'),
//     StateCoordinate(6.492368076708255, 100.24446942388748, 8, 50, 'PERLIS'),
//     StateCoordinate(
//         5.343551053918363, 100.2488865879807, 8, 50, 'PULAU PINANG'),
//     StateCoordinate(4.469098953433944, 101.10285256201672, 7, 10, 'PERAK'),
//     StateCoordinate(5.767418023387823, 116.959038563929, 4, 00, 'SABAH'),
//     StateCoordinate(3.034302994527381, 101.49112172847904, 7, 0, 'SELANGOR'),
//     StateCoordinate(2.716980757195149, 112.82974618957734, 5, 20, 'SARAWAK'),
//     StateCoordinate(
//         4.8850142299461625, 103.16105924934261, 7, 20, 'TERENGGANU'),
//     StateCoordinate(
//         3.1757995884491126, 101.68222189313977, 8, 0, 'KUALA LUMPUR'),
//     // StateCoordinate(5.367923820008349, 115.22974131064973, 8, 0, 'LABUAN'),
//     // StateCoordinate(2.9194747991342758, 101.68947221559338, 8, 0, 'PUTRAJAYA'),
//   ];

//   String selectedState = 'Johor';
//   String selectedDistrict = 'JHR01';
//   String selectedDistrictName = '';

//   // Map of states and districts
//   Map<String, List<Map<String, String>>> districtsMap = {
//     'Johor': [
//       {'code': 'JHR01', 'name': 'Pulau Aur dan Pulau Pemanggil'},
//       {'code': 'JHR02', 'name': 'Johor Bharu, Kota Tinggi, Mersing'},
//       {'code': 'JHR03', 'name': 'Kluang, Pontian'},
//       {'code': 'JHR04', 'name': 'Batu Pahat, Muar, Segamat, Gemas Johor'},
//     ],
//     'Kedah': [
//       {
//         'code': 'KDH01',
//         'name': 'Kota Setar, Kubang Pasu, Pokok Sena (Daerah Kecil)'
//       },
//       {'code': 'KDH02', 'name': 'Kuala Muda, Yan, Pendang'},
//       {'code': 'KDH03', 'name': 'Padang Terap, Sik'},
//       {'code': 'KDH04', 'name': 'Baling'},
//       {'code': 'KDH05', 'name': 'Bandar Baharu, Kulim'},
//       {'code': 'KDH06', 'name': 'Langkawi'},
//       {'code': 'KDH07', 'name': 'Gunung Jerai'}
//     ],
//     'Kelantan': [
//       {
//         'code': 'KTN01',
//         'name':
//             'Bachok, Kota Bharu, Machang, Pasir Mas, Pasir Puteh, Tanah Merah, Tumpat, Kuala Krai, Mukim Chiku'
//       },
//       {'code': 'KTN03', 'name': 'Gua Musang (Daerah Galas Dan Bertam), Jeli'},
//     ],
//     'Melaka': [
//       {'code': 'MLK01', 'name': 'SELURUH NEGERI MELAKA'},
//     ],
//     'Negeri Sembilan': [
//       {'code': 'NGS01', 'name': 'Tampin, Jempol'},
//       {
//         'code': 'NGS02',
//         'name': 'Jelebu, Kuala Pilah, Port Dickson, Rembau, Seremban'
//       },
//     ],
//     'Pahang': [
//       {'code': 'PHG01', 'name': 'Pulau Tioman'},
//       {'code': 'PHG02', 'name': 'Kuantan, Pekan, Rompin, Muadzam Shah'},
//       {
//         'code': 'PHG03',
//         'name': 'Jerantut, Temerloh, Maran, Bera, Chenor, Jengka'
//       },
//       {'code': 'PHG04', 'name': 'Bentong, Lipis, Raub'},
//       {'code': 'PHG05', 'name': 'Genting Sempah, Janda Baik, Bukit Tinggi'},
//       {
//         'code': 'PHG06',
//         'name': 'Cameron Highlands, Genting Highlands, Bukit Fraser'
//       },
//     ],
//     'Perlis': [
//       {'code': 'PLS01', 'name': 'Kangar, Padang Besar, Arau'},
//     ],
//     'Pulau Pinang': [
//       {'code': 'PNG01', 'name': 'Seluruh Negeri Pulau Pinang'},
//     ],
//     'Perak': [
//       {'code': 'PRK01', 'name': 'Tapah, Slim River, Tanjung Malim'},
//       {
//         'code': 'PRK02',
//         'name':
//             'Kuala Kangsar, Sg. Siput (Daerah Kecil), Ipoh, Batu Gajah, Kampar'
//       },
//       {'code': 'PRK03', 'name': 'Lenggong, Pengkalan Hulu, Grik'},
//       {'code': 'PRK04', 'name': 'Temengor, Belum'},
//       {
//         'code': 'PRK05',
//         'name':
//             'Kg Gajah, Teluk Intan, Bagan Datuk, Seri Iskandar, Beruas, Parit, Lumut, Sitiawan, Pulau Pangkor'
//       },
//       {'code': 'PRK06', 'name': 'Selama, Taiping, Bagan Serai, Parit Buntar'},
//       {'code': 'PRK07', 'name': 'Bukit Larut'},
//     ],
//     'Sabah': [
//       {
//         'code': 'SBH01',
//         'name':
//             'Bahagian Sandakan (Timur), Bukit Garam, Semawang, Temanggong, Tambisan, Bandar Sandakan'
//       },
//       {
//         'code': 'SBH02',
//         'name':
//             'Beluran, Telupid, Pinangah, Terusan, Kuamut, Bahagian Sandakan (Barat)'
//       },
//       {
//         'code': 'SBH03',
//         'name':
//             'Lahad Datu, Silabukan, Kunak, Sahabat, Semporna, Tungku, Bahagian Tawau (Timur)'
//       },
//       {
//         'code': 'SBH04',
//         'name':
//             'Bandar Tawau, Balong, Merotai, Kalabakan, Bahagian Tawau (Barat)'
//       },
//       {
//         'code': 'SBH05',
//         'name': 'Kudat, Kota Marudu, Pitas, Pulau Banggi, Bahagian Kudat'
//       },
//       {'code': 'SBH06', 'name': 'Gunung Kinabalu'},
//       {
//         'code': 'SBH07',
//         'name':
//             'Kota Kinabalu, Ranau, Kota Belud, Tuaran, Penampang, Papar, Putatan, Bahagian Pantai Barat'
//       },
//       {
//         'code': 'SBH08',
//         'name':
//             'Pensiangan, Keningau, Tambunan, Nabawan, Bahagian Pendalaman (Atas)'
//       },
//       {
//         'code': 'SBH09',
//         'name':
//             'Beaufort, Kuala Penyu, Sipitang, Tenom, Long Pa Sia, Membakut, Weston, Bahagian Pendalaman (Bawah)'
//       },
//     ],
//     'Selangor': [
//       {
//         'code': 'SGR01',
//         'name':
//             'Gombak, Petaling, Sepang, Hulu Langat, Hulu Selangor, Rawang, Shah Alam'
//       },
//       {'code': 'SGR02', 'name': 'Kuala Selangor, Sabak Bernam'},
//       {'code': 'SGR03', 'name': 'Klang, Kuala Langat'},
//     ],
//     'Sarawak': [
//       {'code': 'SWK01', 'name': 'Limbang, Lawas, Sundar, Trusan'},
//       {'code': 'SWK02', 'name': 'Miri, Niah, Bekenu, Sibuti, Marudi'},
//       {'code': 'SWK03', 'name': 'Pandan, Belaga, Suai, Tatau, Sebauh, Bintulu'},
//       {
//         'code': 'SWK04',
//         'name': 'Sibu, Mukah, Dalat, Song, Igan, Oya, Balingian, Kanowit, Kapit'
//       },
//       {
//         'code': 'SWK05',
//         'name': 'Sarikei, Matu, Julau, Rajang, Daro, Bintangor, Belawai'
//       },
//       {
//         'code': 'SWK06',
//         'name':
//             'Lubok Antu, Sri Aman, Roban, Debak, Kabong, Lingga, Engkelili, Betong, Spaoh, Pusa, Saratok'
//       },
//       {
//         'code': 'SWK07',
//         'name': 'Serian, Simunjan, Samarahan, Sebuyau, Meludam'
//       },
//       {'code': 'SWK08', 'name': 'Kuching, Bau, Lundu, Sematan'},
//       {'code': 'SWK09', 'name': 'Zon Khas (Kampung Patarikan)'},
//     ],
//     'Terengganu': [
//       {'code': 'TRG01', 'name': 'Kuala Terengganu, Marang, Kuala Nerus'},
//       {'code': 'TRG02', 'name': 'Besut, Setiu'},
//       {'code': 'TRG03', 'name': 'Hulu Terengganu'},
//       {'code': 'TRG04', 'name': 'Dungun, Kemaman'},
//     ],
//     'Wilayah Persekutuan': [
//       {'code': 'WLY01', 'name': 'Kuala Lumpur, Putrajaya'},
//       {'code': 'WLY02', 'name': 'Labuan'},
//     ],
//   };

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

//   _flyToStateCenter(int stateIndex) {
//     if (mapboxMap != null &&
//         stateIndex >= 0 &&
//         stateIndex < malaysiaStateCoordinates.length) {
//       StateCoordinate stateCoordinate = malaysiaStateCoordinates[stateIndex];
//       mapboxMap?.easeTo(
//           CameraOptions(
//               center: Point(
//                   coordinates: Position(
//                 stateCoordinate.longitude,
//                 stateCoordinate.latitude,
//               )).toJson(),
//               zoom: stateCoordinate.zoom,
//               bearing: 0,
//               pitch: stateCoordinate.pitch),
//           MapAnimationOptions(duration: 4000, startDelay: 0));
//       if (!renderedStates.contains(stateCoordinate.name)) {
//         renderedStates.add(stateCoordinate.name);
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   _initCamera() {
//     mapboxMap?.easeTo(
//         CameraOptions(
//           center: Point(
//               coordinates: Position(
//             101.68222189313977,
//             3.1757995884491126,
//           )).toJson(),
//           zoom: 10,
//           bearing: 0,
//         ),
//         MapAnimationOptions(duration: 0));
//   }

//   saveZone(String state, String zone, String zoneName, context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('zone', zone);
//     prefs.setString('zone_name', zoneName);
//     prefs.setString('state', state);

//     print('sini');

//     // Add the navigation code here
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SplashScreen(),
//       ),
//     );
//   }

//   String? findDistrictName(String code) {
//     // Loop through the districtsMap to find the name
//     for (var state in districtsMap.keys) {
//       final districts = districtsMap[state];

//       print(districts);
//       print("---------------");
//       for (var district in districts!) {
//         if (district['code'] == code) {
//           return district['name'];
//         }
//       }
//     }
//     // Return a default value or handle not found case
//     return "District not found";
//   }

//   @override
//   Widget build(BuildContext context) {
//     const String ACCESS_TOKEN =
//         "pk.eyJ1IjoienZoaXI5OCIsImEiOiJjbG53dnk1cXIwZnlmMmtvYXowandhMGxkIn0.bPPj0B1QV2nYz4Ml3yR8tA";

//     final MapWidget mapWidget = MapWidget(
//         key: ValueKey("mapWidget"),
//         resourceOptions: ResourceOptions(accessToken: ACCESS_TOKEN),
//         cameraOptions: CameraOptions(
//           center: Point(
//             coordinates: Position(3.028320512111406,
//                 101.33318622918793), // Coordinates for Kuala Lumpur
//           ).toJson(),
//           zoom: 12.0,
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
//                   color: NajiaColors.bgColor // Set the background color to red
//                   ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     top: 16.0, right: 16.0, left: 16.0, bottom: 40),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "SELECT ZONE",
//                       style: TextStyle(
//                           fontSize: 12, letterSpacing: 8, color: Colors.black),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           isExpanded: true,
//                           value: selectedState,
//                           items: districtsMap.keys.map((state) {
//                             return DropdownMenuItem<String>(
//                               value: state,
//                               child: Text(
//                                 state,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _flyToStateCenter(districtsMap.keys
//                                   .toList()
//                                   .indexOf(newValue!));
//                               selectedState = newValue!;
//                               selectedDistrict = districtsMap[selectedState]![0]
//                                   [
//                                   'code']!; // Set the first district as default
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           isExpanded: true,
//                           value: selectedDistrict,
//                           items:
//                               districtsMap[selectedState]?.map((districtMap) {
//                             return DropdownMenuItem<String>(
//                               value: districtMap['code']!,
//                               child: Text(
//                                 districtMap['name']!,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               selectedDistrict = newValue!;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 NajiaColors.black),
//                           ),
//                           onPressed: () {
//                             print("object");
//                             saveZone(selectedState, selectedDistrict,
//                                 findDistrictName(selectedDistrict)!, context);
//                           },
//                           child: const Text("Select zone"),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// abstract class ExamplePage extends StatelessWidget {
//   const ExamplePage(this.leading, this.title);

//   final Widget leading;
//   final String title;
// }
