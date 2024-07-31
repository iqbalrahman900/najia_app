import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_widget/home_widget.dart';
import 'package:najia/database/esolatDatabase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/constant.dart';
import 'dart:ui' as ui;

class Zone extends StatefulWidget {
  const Zone({super.key});

  @override
  State<StatefulWidget> createState() => ZoneState();
}

class ZoneState extends State<Zone> {
  int styleIndex = 1;

  String selectedState = 'Johor';
  String selectedDistrict = 'JHR01';
  String selectedDistrictName = '';

  String appGroupId = 'group.najia_app_group';
  String iOSWidgetName = 'najia_home_widget';

  @override
  void initState() {
    HomeWidget.setAppGroupId(appGroupId);
    super.initState();
  }

  Future<void> getPrayerTimesAPI(
      String state, String zone, String zoneName, context) async {
    try {
      // Make an API request to fetch prayer times
      final apiUrl =
          'https://www.e-solat.gov.my/index.php?r=esolatApi/takwimsolat&period=year&zone=$zone';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> apiData = json.decode(response.body);

        // Extract and save prayer times to SQLite
        final List<dynamic> prayerTimes = apiData['prayerTime'];
        await savePrayerTimesToSQLite(
            prayerTimes, state, zone, zoneName, context);

        updateWidgetFun(zone, prayerTimes.toString());
      } else {
        // Handle API request error
        if (kDebugMode) {
          print('API request failed with status code: ${response.statusCode}');
        }
        // You can handle errors here, e.g., show an error message to the user.
      }
    } catch (e) {
      // Handle other errors, such as network errors or JSON parsing errors
      if (kDebugMode) {
        print('Error during API request: $e');
      }
      // You can handle errors here, e.g., show an error message to the user.
    }
  }

  updateWidgetFun(zone, prayerTimes) {
    HomeWidget.saveWidgetData<String>('zone', zone);
    HomeWidget.saveWidgetData<String>('prayerDB', prayerTimes);
    HomeWidget.updateWidget(iOSName: iOSWidgetName);
    // if (kDebugMode) {
    //   print('Widget data updated for prayer times: $prayerTimes');
    // }
  }

  // Map of states and districts
  Map<String, List<Map<String, String>>> districtsMap = MalaysiaData().states;

  String? findDistrictName(String code) {
    for (var state in districtsMap.keys) {
      final districts = districtsMap[state];
      for (var district in districts!) {
        if (district['code'] == code) {
          return district['name'];
        }
      }
    }
    return "District not found";
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final imageWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          "SELECT ZONE",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0), // Round corners
                child: Image.asset(
                  'assets/images/select.png',
                  fit: BoxFit.cover, // Full width
                  width: imageWidth,
                  height: imageWidth,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              textDirection: ui.TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                fontFamily: 'naskh',
                fontSize: 28,
              ),
              "ٱللَّهُ لَآ إِلَٰهَ إِلَّا هُوَ ٱلۡحَيُّ ٱلۡقَيُّومُ ﰁ",
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 250, 237, 227),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, right: 16.0, left: 16.0, bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        const url = 'https://www.e-solat.gov.my/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          // Handle if the URL cannot be launched, e.g., show an error message.
                          // You can display a snackbar or an AlertDialog with an error message.
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Prayer times precisely sourced from ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: NajiaColors.black,
                            ),
                          ),
                          const Text(
                            "e-Solat JAKIM ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: NajiaColors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.5),
                            child: Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/verified.svg',
                                height: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedState,
                        items: districtsMap.keys.map((state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(
                              state,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedState = newValue!;
                            selectedDistrict = districtsMap[selectedState]![0]
                                ['code']!; // Set the first district as default
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedDistrict,
                        items: districtsMap[selectedState]?.map((districtMap) {
                          return DropdownMenuItem<String>(
                            value: districtMap['code']!,
                            child: Text(
                              districtMap['name']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDistrict = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              NajiaColors.black),
                        ),
                        onPressed: () {
                          getPrayerTimesAPI(selectedState, selectedDistrict,
                              findDistrictName(selectedDistrict)!, context);
                        },
                        child: const Text("SELECT ZONE"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
