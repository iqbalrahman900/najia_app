import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:najia/screens/navigation/navigation_bar.dart';
import 'package:najia/screens/zone/zone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../animations/splash_animation.dart';
import '../../utils/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

Future<void> checkCurrentYearData(BuildContext context) async {
  // Get the current year
  int currentYear = DateTime.now().year;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if data for the current year exists in shared preferences
  if (prefs.containsKey("prayer_time_$currentYear")) {
    if (kDebugMode) {
      print("Shared preferences data for the year $currentYear exists.");
    }
    // Do something if data exists
  } else {
    if (kDebugMode) {
      print(
          "Shared preferences data for the year $currentYear does not exist.");
    }
    // Do something else if data does not exist
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Zone()),
      // MaterialPageRoute(builder: (context) => Login()),
    );
  }
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Size size = Size.zero;
  late AnimationController _controller;
  late SplashAnimation _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animations = SplashAnimation(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    checkCurrentYearData(context);

    checkZone();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      size = MediaQuery.of(context).size;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String?> getZone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('zone');
  }

  Future<void> checkZone() async {
    String? zone = await getZone();

    if (zone != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationBottomBar(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Zone()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: NajiaColors.black,
      child: Stack(children: [
        SizedBox(
            width: size.width,
            height: size.height,
            child: CustomPaint(
                painter: DHomeHolePainter(
                    color: NajiaColors.bgColor,
                    holeSize: _animations.holeSize.value * size.width))),
        const Center(
          child: Image(
              height: 60, image: AssetImage('assets/images/najia_logo.png')),
        ),
      ]),
    ));
  }
}
