import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:najia/database/dbManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class MotivationalQuotes {
  static final List<List<String>> quotes = [
    ['You Can Do It!', 'Small progress is still progress.'],
    ['Embrace Challenges!', 'Challenges make you stronger and wiser.'],
    ['Stay Positive!', 'Believe in yourself, and you will succeed.'],
    ['Believe in Yourself!', 'Difficult roads lead to beautiful destinations.'],
    ['Never Give Up!', 'Every journey starts with a single step.'],
    ['Keep Going!', 'Success comes to those who never give up.'],
    ['Embrace Challenges!', 'Challenges make you stronger and wiser.'],
  ];

  static List<String> getDailyQuote() {
    final now = DateTime.now();
    final dayOfYear = now.year * 366 + now.day;
    final index = dayOfYear % quotes.length;
    return quotes[index];
  }
}

Future<List<Map<String, dynamic>>> fetchYearlyData(Database database) async {
  try {
    final List<Map<String, dynamic>> prayerData =
        await database.query('prayer_times');
    return prayerData;
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

Widget renderHeader(context) {
  final dailyQuotes = MotivationalQuotes.getDailyQuote();
  final mainQuote = dailyQuotes[0];
  final subQuote = dailyQuotes[1];

  return Row(
    children: <Widget>[
      const SizedBox(width: 5),
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              // GestureDetector(
              //   // onTap: () {
              //   //   // Show the custom dialog
              //   //   _showImageDialog(context);
              //   // },
              //   child: ClipOval(
              //     child: Container(
              //       decoration: const BoxDecoration(
              //         color: Color.fromRGBO(204, 169, 144, 1),
              //         shape: BoxShape.circle,
              //       ),
              //       width: 60,
              //       height: 60,
              //       child: Image.asset(
              //         'assets/images/dp2.png',
              //         width: 60,
              //         height: 60,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mainQuote,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    subQuote,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              shareDialog(context);
            },
            child: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
    ],
  );
}

void _showImageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
            width: double.infinity - 10,
            height: 320,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipOval(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(204, 169, 144, 1),
                        shape: BoxShape.circle,
                      ),
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        'assets/images/dp2.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text("Currently logged in as Guest"),
                const SizedBox(
                  height: 20,
                ),
                renderSocialButton(
                    "assets/icons/google.png", "Login with Google"),
                const SizedBox(
                  height: 10,
                ),
                renderSocialButton(
                    "assets/icons/twitter.png", "Login with Twitter"),
                const SizedBox(
                  height: 10,
                ),
                renderSocialButton(
                    "assets/icons/apple.png", "Login with Apple"),
              ],
            )),
      );
    },
  );
}

renderSocialButton(logo, text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10),
    child: SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () => {},
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFEDEEF0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              logo,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const Icon(
              Icons.abc,
              size: 50,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> shareDialog(context) async {
  final database = await openDatabaseAndCreateTable();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String sharedZone = prefs.getString('zone_name') ?? '';

  try {
    final List<Map<String, dynamic>> prayerData =
        await fetchYearlyData(database);
    if (prayerData.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: double.infinity,
              height: 500, // Adjust the height as needed
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Yearly Calendar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        sharedZone,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      child: Table(
                        columnWidths: const {
                          0: IntrinsicColumnWidth(),
                        },
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          const TableRow(children: [
                            Center(
                              child: Text('Date',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Center(
                              child: Text('Subuh',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Center(
                              child: Text('Zohor',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Center(
                              child: Text('Asar',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Center(
                              child: Text('Maghrib',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Center(
                              child: Text('Isha',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ]),
                          for (var data in prayerData)
                            TableRow(
                              decoration: BoxDecoration(
                                color: isToday(data['date'])
                                    ? Colors.yellow
                                    : null, // Change the color for today's row
                              ),
                              children: [
                                Center(
                                  child: Text(
                                    formatDateString(data['date']),
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                      data['fajr'].substring(
                                          0, data['fajr'].length - 3),
                                      style: TextStyle(fontSize: 10)),
                                ),
                                Center(
                                  child: Text(
                                      data['dhuhr'].substring(
                                          0, data['fajr'].length - 3),
                                      style: TextStyle(fontSize: 10)),
                                ),
                                Center(
                                  child: Text(
                                      data['asr'].substring(
                                          0, data['fajr'].length - 3),
                                      style: TextStyle(fontSize: 10)),
                                ),
                                Center(
                                  child: Text(
                                      data['maghrib'].substring(
                                          0, data['fajr'].length - 3),
                                      style: TextStyle(fontSize: 10)),
                                ),
                                Center(
                                  child: Text(
                                      data['isha'].substring(
                                          0, data['fajr'].length - 3),
                                      style: TextStyle(fontSize: 10)),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
  } finally {
    await database.close();
  }
}

bool isToday(String date) {
  final today = DateTime.now();
  final dateFormat = DateFormat('dd-MMM-yyyy', 'en_US');
  final dateToCheck = dateFormat.parse(date);
  return today.year == dateToCheck.year &&
      today.month == dateToCheck.month &&
      today.day == dateToCheck.day;
}

String formatDateString(String dateString) {
  // Parse the input date string
  DateTime dateTime = DateFormat('dd-MMM-yyyy').parse(dateString);

  // Format the date in the desired format (10-03-24)
  return DateFormat('dd-MM-yy').format(dateTime);
}
