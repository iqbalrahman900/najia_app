import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:najia/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the package

class Developer extends StatelessWidget {
  Developer({Key? key}) : super(key: key);

  final TextEditingController feedbackController =
      TextEditingController(); // Add this

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
          "CONTACT DEVELOPER",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: NajiaColors.bgColor,
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Report Bug or Give Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: feedbackController,
                        decoration: const InputDecoration(
                          hintText: 'Your Feedback',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final feedbackText = feedbackController.text;
                          final whatsappNumber = '+60165585600';
                          final whatsappUrl =
                              'https://wa.me/$whatsappNumber?text=$feedbackText';
                          if (await canLaunch(whatsappUrl)) {
                            await launch(whatsappUrl);
                          } else {
                            // Handle if the URL cannot be launched, e.g., show an error message.
                            // You can display a snackbar or an AlertDialog with an error message.
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Submit Feedback'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              LineIcons.arrowRight,
                              color: NajiaColors.bgColor,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     print("Buy PRO for RM28.00");
                      //   },
                      //   child: const Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text('Get PRO for RM28.00 for 1 month'),
                      //       SizedBox(
                      //         width: 5,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     print("Buy PRO for RM79.00");
                      //   },
                      //   child: const Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text('Get PRO for RM79.00 per year'),
                      //       SizedBox(
                      //         width: 5,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 10.0, bottom: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: NajiaColors.bgColor,
                ),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () async {
                    const url = 'https://najia.app';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      // Handle if the URL cannot be launched, e.g., show an error message.
                      // You can display a snackbar or an AlertDialog with an error message.
                    }
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Image(
                        image: AssetImage('assets/images/najia_logo.png'),
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Website: najia.app',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 71, 71, 71),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'HQ: Persiaran APEC, Cyber 8, 63000 Cyberjaya, Selangor',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 71, 71, 71)),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Email: najiaappstudio@gmail.com',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 71, 71, 71)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        '© 2024 Najia App Studio. All rights reserved.',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 129, 78, 2)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
