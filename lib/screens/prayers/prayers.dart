import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/database/dbManager.dart';
import 'package:najia/notifications/notification_service.dart';
import 'package:najia/screens/prayers/bottom.dart';
import 'package:najia/screens/prayers/box.dart';
import 'package:najia/screens/prayers/card.dart';
import 'package:najia/screens/prayers/header.dart';
import 'package:najia/screens/prayers/parallax.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prayers extends StatefulWidget {
  const Prayers({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrayersState createState() => _PrayersState();
}

class _PrayersState extends State<Prayers> {
  // Accelerometer
  late AccelerometerEvent acceleration = AccelerometerEvent(0, 0, 0);
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  int planetMotionSensitivity = 4;
  int textMotionSensitivity = 4;
  int bgMotionSensitivity = 2;

  // Carousel
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imageSliders = [
    "assets/images/syria.png",
    "assets/images/syria2.png",
    "assets/images/umrah.jpg",
  ];

  // Prayer times
  final prayerNames = [
    'Imsak',
    'Subuh',
    'Syuruk',
    'Zohor',
    'Asar',
    'Maghrib',
    'Isyak',
  ];

  String imsak = '';
  String fajr = '';
  String syuruk = '';
  String dhuhr = '';
  String asr = '';
  String maghrib = '';
  String isha = '';
  String state = '';
  String zone = '';
  int nextPrayersIndex = -1;
  List<String> remainingTimes = List.filled(7, '');

  @override
  void initState() {
    super.initState();
    fetchTodayOrTomorrowPrayerss();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        acceleration = event;
      });
    });
    setNotifications(context);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<void> fetchTodayOrTomorrowPrayerss() async {
    final database = await openDatabaseAndCreateTable();
    final prefs = await SharedPreferences.getInstance();
    final currentDateTime = DateTime.now();
    final formattedDate = DateFormat('dd-MMM-yyyy').format(currentDateTime);
    String sharedZone = prefs.getString('zone_name') ?? '';
    String sharedState = prefs.getString('state') ?? '';

    try {
      final todayPrayerss = await database.query(
        'prayer_times',
        where: 'date = ?',
        whereArgs: [formattedDate],
      );

      if (todayPrayerss.isNotEmpty) {
        final todayData = todayPrayerss.first;
        if (currentDateTime.isAfter(
            parseTime(convertTimeFormat(todayData['isha'].toString())))) {
          final tomorrow = currentDateTime.add(const Duration(days: 1));
          final tomorrowDate = DateFormat('dd-MMM-yyyy').format(tomorrow);
          try {
            final tomorrowPrayerss = await database.query(
              'prayer_times',
              where: 'date = ?',
              whereArgs: [tomorrowDate],
            );
            if (tomorrowPrayerss.isNotEmpty) {
              final tomorrowData = tomorrowPrayerss.first;
              imsak = convertTimeFormat(tomorrowData['imsak'].toString());
              fajr = convertTimeFormat(tomorrowData['fajr'].toString());
              syuruk = convertTimeFormat(tomorrowData['syuruk'].toString());
              dhuhr = convertTimeFormat(tomorrowData['dhuhr'].toString());
              asr = convertTimeFormat(tomorrowData['asr'].toString());
              maghrib = convertTimeFormat(tomorrowData['maghrib'].toString());
              isha = convertTimeFormat(tomorrowData['isha'].toString());

              const Duration checkInterval = Duration(seconds: 1);
              Timer.periodic(checkInterval, (timer) {
                checkTomorrowPrayerss();
              });
            }
          } catch (e) {
            if (kDebugMode) {
              print('Error fetching tomorrow\'s data: $e');
            }
          }
        } else {
          imsak = convertTimeFormat(todayData['imsak'].toString());
          fajr = convertTimeFormat(todayData['fajr'].toString());
          syuruk = convertTimeFormat(todayData['syuruk'].toString());
          dhuhr = convertTimeFormat(todayData['dhuhr'].toString());
          asr = convertTimeFormat(todayData['asr'].toString());
          maghrib = convertTimeFormat(todayData['maghrib'].toString());
          isha = convertTimeFormat(todayData['isha'].toString());

          const Duration checkInterval = Duration(seconds: 1);
          Timer.periodic(checkInterval, (timer) {
            checkTodayPrayerss();
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching today\'s data: $e');
      }
    } finally {
      await database.close();
      setState(() {
        state = sharedState;
        zone = sharedZone;
      });
    }
  }

  void checkTodayPrayerss() {
    final imsakTime = parseTime(imsak);
    final fajrTime = parseTime(fajr);
    final syurukTime = parseTime(syuruk);
    final dhuhrTime = parseTime(dhuhr);
    final asrTime = parseTime(asr);
    final maghribTime = parseTime(maghrib);
    final ishaTime = parseTime(isha);

    bool foundNextPrayers = false;

    for (int i = 0; i < prayerNames.length; i++) {
      final prayersName = prayerNames[i];
      final prayers = [
        imsakTime,
        fajrTime,
        syurukTime,
        dhuhrTime,
        asrTime,
        maghribTime,
        ishaTime,
      ][i];

      if (!foundNextPrayers &&
          checkTodaySpecificPrayers(prayersName, prayers, i)) {
        foundNextPrayers = true;
      }
    }
  }

  bool checkTodaySpecificPrayers(
    String name,
    DateTime prayers,
    int index,
  ) {
    final currentDateTime = DateTime.now();

    final timeDifference = currentDateTime.difference(prayers);
    final hours = timeDifference.inHours.abs();
    final minutes = (timeDifference.inMinutes.abs() % 60);
    final seconds = (timeDifference.inSeconds.abs() % 60);
    final message = currentDateTime.isAfter(prayers)
        ? 'was $hours hour $minutes min $seconds sec ago'
        : 'in $hours hour $minutes min $seconds sec';

    setState(() {
      remainingTimes[index] = message;
    });

    if (nextPrayersIndex == -1 && timeDifference.isNegative) {
      nextPrayersIndex = index;
      return true;
    }

    return false;
  }

  DateTime parseTime(String timeString) {
    final currentDateTime = DateTime.now();
    final dateFormat = DateFormat('h:mm a');
    final parsedTime = dateFormat.parse(timeString);
    return DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  void checkTomorrowPrayerss() {
    final imsakTime = parseTime(imsak);
    final fajrTime = parseTime(fajr);
    final syurukTime = parseTime(syuruk);
    final dhuhrTime = parseTime(dhuhr);
    final asrTime = parseTime(asr);
    final maghribTime = parseTime(maghrib);
    final ishaTime = parseTime(isha);

    bool foundNextPrayers = false;

    for (int i = 0; i < prayerNames.length; i++) {
      final prayersName = prayerNames[i];
      final prayers = [
        imsakTime,
        fajrTime,
        syurukTime,
        dhuhrTime,
        asrTime,
        maghribTime,
        ishaTime,
      ][i];

      if (!foundNextPrayers &&
          checkTomorrowSpecificPrayers(prayersName, prayers, i)) {
        foundNextPrayers = true;
      }
    }
  }

  bool checkTomorrowSpecificPrayers(String name, DateTime prayers, int index) {
    final currentDateTime = DateTime.now();
    final timeDifference =
        currentDateTime.difference(prayers.add(const Duration(days: 1)));
    final hours = timeDifference.inHours.abs();
    final minutes = (timeDifference.inMinutes.abs() % 60);
    final seconds = (timeDifference.inSeconds.abs() % 60);
    final message = currentDateTime.isBefore(prayers)
        ? 'in $hours hours $minutes minutes $seconds seconds'
        : 'in $hours hours $minutes minutes $seconds seconds';

    setState(() {
      remainingTimes[index] = message;
    });

    if (nextPrayersIndex == -1 && timeDifference.isNegative) {
      nextPrayersIndex = index;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  renderHeader(context),
                  const SizedBox(
                    height: 30,
                  ),
                  renderParallax(
                      context,
                      acceleration,
                      nextPrayersIndex,
                      remainingTimes,
                      planetMotionSensitivity,
                      textMotionSensitivity,
                      bgMotionSensitivity,
                      zone,
                      imsak,
                      fajr,
                      syuruk,
                      dhuhr,
                      asr,
                      maghrib,
                      isha),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      renderBox(),
                      const SizedBox(
                        height: 30,
                      ),
                      renderPrayerCards(0, "Imsak", imsak),
                      renderPrayerCards(1, "Subuh", fajr),
                      renderPrayerCards(2, "Syuruk", syuruk),
                      renderPrayerCards(3, "Zohor", dhuhr),
                      renderPrayerCards(4, "Asar", asr),
                      renderPrayerCards(5, "Maghrib", maghrib),
                      renderPrayerCards(6, "Isha", isha),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      shareDialog(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 204, 169, 144),
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the border radius as needed
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Yearly 2024 calendar",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "View all prayer times in your selected\nzone along the year.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/images/yearly.png",
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // renderCarousel(context),
                  const SizedBox(height: 80),
                  renderBottom()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderPrayerCards(
    int index,
    String prayerName,
    String prayers,
  ) {
    return FadeAnimation(
      delay: 200,
      child: waktuCard(
        index,
        prayerName,
        prayers,
        remainingTimes[index],
        nextPrayersIndex == index ? true : false,
      ),
    );
  }

  renderCarousel(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: SizedBox(
        height: 200,
        child: Column(children: [
          Expanded(
            child: CarouselSlider(
              items: imageSliders.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                );
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 3.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}

// NOTIFICATIONS

int convertToDateInteger(String dateString, int additionalNumber) {
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<String> dateParts = dateString.split('-');
  int day = int.parse(dateParts[0]);
  int month = months.indexOf(dateParts[1]) + 1;
  int year = int.parse(dateParts[2]);

  return int.parse('${day.toString().padLeft(2, '0')}'
      '${month.toString().padLeft(2, '0')}'
      '$year$additionalNumber');
}

DateTime convertToDate(String dateString) {
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<String> dateParts = dateString.split('-');
  int day = int.parse(dateParts[0]);
  int month = months.indexOf(dateParts[1]) + 1;
  int year = int.parse(dateParts[2]);

  return DateTime(year, month, day);
}

DateTime convertToDateTime(DateTime date, String timeString) {
  List<String> timeParts = timeString.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);
  int second = int.parse(timeParts[2]);

  return DateTime(date.year, date.month, date.day, hour, minute, second);
}

Future<void> setNotifications(context) async {
  NotificationService notificationService = NotificationService();
  notificationService.cancelAllNotifications();
  await notificationService.init();
  if (Platform.isIOS) {
    await notificationService.requestIOSPermissions();
  } else {
    await notificationService.requestAndroidPermission();
  }
  // PRAYER TIMES
  List<Map<String, dynamic>> prayerTimes = await fetchNext12DayPrayers();

  if (prayerTimes.isNotEmpty) {
    // Print each row of the retrieved data
    for (var prayerTime in prayerTimes) {
      DateTime date = convertToDate(prayerTime['date']);
      DateTime fajr = convertToDateTime(date, prayerTime['fajr']);
      DateTime dhuhr = convertToDateTime(date, prayerTime['dhuhr']);
      DateTime asr = convertToDateTime(date, prayerTime['asr']);
      DateTime maghrib = convertToDateTime(date, prayerTime['maghrib']);
      DateTime isha = convertToDateTime(date, prayerTime['isha']);

      DateTime currentDate = DateTime.now();
      DateTime futureDate = currentDate.add(Duration(days: 11));

      // Extract components from the future date
      int futureYear = futureDate.year;
      int futureMonth = futureDate.month;
      int futureDay = futureDate.day;

      if (date.isAfter(DateTime(futureYear, futureMonth, futureDay))) {
        DateFormat inputFormat = DateFormat('dd-MMM-yyyy', 'en_US');
        DateTime dateTime = inputFormat.parse(prayerTime['date']);

        DateTime reminder1 =
            DateTime(dateTime.year, dateTime.month, dateTime.day, 11, 30, 0);

        DateTime reminder2 =
            DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 30, 0)
                .add(const Duration(days: 1));

        DateTime reminder3 =
            DateTime(dateTime.year, dateTime.month, dateTime.day, 19, 50, 0)
                .add(const Duration(days: 2));

        DateTime reminder4 =
            DateTime(dateTime.year, dateTime.month, dateTime.day, 10, 30, 0)
                .add(const Duration(days: 3));

        await Future.wait([
          scheduleFutureNotification(
            notificationService,
            1,
            'No more azan for tomorrow 🥺',
            'Tap here to continue receiving azan notifications 😆',
            reminder1,
            'azan_alert_1',
          ),
          scheduleFutureNotification(
            notificationService,
            2,
            'No more azan for tomorrow 🥺',
            'Tap here to continue receiving azan notifications 😆',
            reminder2,
            'azan_alert_2',
          ),
          scheduleFutureNotification(
            notificationService,
            3,
            'No more azan for tomorrow 🥺',
            'Tap here to continue receiving azan notifications 😆',
            reminder3,
            'azan_alert_3',
          ),
          scheduleFutureNotification(
            notificationService,
            4,
            'No more azan for tomorrow 🥺',
            'Tap here to continue receiving azan notifications 😆',
            reminder4.add(const Duration(days: 1)),
            'azan_alert_4',
          ),
        ]);
        if (kDebugMode) {
          notificationService.getNotifications();
        }
        break;
      }
      if (kDebugMode) {
        print('------------------------');
        print('SETTING NOTIFICATION FOR ${date.toLocal()}');
        print('Fajr: $fajr');
        print('Zohor: $dhuhr');
        print('Asar: $asr');
        print('Maghrib: $maghrib');
        print('Isha: $isha');
        print('\n\n');
      }

      // Schedule notifications in parallel
      await Future.wait([
        scheduleFutureNotification(
          notificationService,
          convertToDateInteger(prayerTime['date'], 1),
          'Subuh Prayer Reminder',
          '(${DateFormat("hh:mm aaa").format(fajr)}) - It\'s time for Fajr prayer. Begin your day with prayer.',
          fajr,
          '${fajr.toIso8601String()}_fajr_notification_payload',
        ),
        scheduleFutureNotification(
          notificationService,
          convertToDateInteger(prayerTime['date'], 2),
          'Zohor Prayer Reminder',
          '(${DateFormat("hh:mm aaa").format(dhuhr)}) - Don\'t forget Zohor prayer. Take a break and find tranquility.',
          dhuhr,
          '${dhuhr.toIso8601String()}_fajr_notification_payload',
        ),
        scheduleFutureNotification(
          notificationService,
          convertToDateInteger(prayerTime['date'], 3),
          'Asar Prayer Reminder',
          '(${DateFormat("hh:mm aaa").format(asr)}) - It\'s Asar time. Pause and seek Allah\'s guidance.',
          asr,
          '${asr.toIso8601String()}_fajr_notification_payload',
        ),
        scheduleFutureNotification(
          notificationService,
          convertToDateInteger(prayerTime['date'], 4),
          'Maghrib Prayer Reminder',
          '(${DateFormat("hh:mm aaa").format(maghrib)}) - Maghrib prayer is here. Reflect and be grateful for the day.',
          maghrib,
          '${maghrib.toIso8601String()}_fajr_notification_payload',
        ),
        scheduleFutureNotification(
          notificationService,
          convertToDateInteger(prayerTime['date'], 5),
          'Isha Prayer Reminder',
          '(${DateFormat("hh:mm aaa").format(isha)}) - It\'s time for Isha prayer. End your day with reflection and prayer.',
          isha,
          '${isha.toIso8601String()}_fajr_notification_payload',
        ),
      ]);
    }
  } else {
    print('Failed to fetch today\'s prayer times.');
  }
}

Future<void> scheduleFutureNotification(
  NotificationService notificationService,
  int id,
  String title,
  String body,
  DateTime scheduledDate,
  String payload,
) async {
  if (scheduledDate.isAfter(DateTime.now())) {
    await notificationService.scheduleNotification(
        id, title, body, scheduledDate, payload);
  } else {
    if (kDebugMode) {
      print('Scheduled date is in the past, skipping notification scheduling.');
    }
  }
}

Future<List<Map<String, dynamic>>> fetchNext12DayPrayers() async {
  final database = await openDatabaseAndCreateTable();

  try {
    final data = await database.rawQuery('SELECT * FROM prayer_times');

    return data;
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching prayer data: $e');
    }
    return []; // Return an empty list or handle the error according to your needs
  } finally {
    await database.close();
  }
}

TimeOfDay parseTimeOfDay(String timeString) {
  DateTime dateTime = DateFormat('HH:mm').parse(timeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}
