import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class NajiaWear extends StatefulWidget {
  NajiaWear({Key? key}) : super(key: key);

  @override
  _NajiaWearState createState() => _NajiaWearState();
}

class _NajiaWearState extends State<NajiaWear> {
  final Uri _url = Uri.parse(
      "https://play.google.com/store/apps/details?id=my.com.najia.wearable.najiawear");

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

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
          "NAJIA WEAR APP",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage('assets/images/nwa.png'),
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: NajiaColors.bgColor, // Set the background color to red
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, right: 16.0, left: 16.0, bottom: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "NOW AVAILABLE!",
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 8,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                        child: GestureDetector(
                          onTap: () {
                            _launchUrl();
                          },
                          child: const Image(
                            image:
                                AssetImage('assets/images/button_download.png'),
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
