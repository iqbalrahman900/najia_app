import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najia/carplay/carplay.dart';
import 'package:najia/screens/splashscreen/splashscreen.dart';
import 'package:najia/utils/constant.dart';
import 'package:flutter_carplay/flutter_carplay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NajiaApp());
}

class NajiaApp extends StatefulWidget {
  const NajiaApp({Key? key}) : super(key: key);

  @override
  State<NajiaApp> createState() => NajiaAppState();
}

class NajiaAppState extends State<NajiaApp> {
  CPConnectionStatusTypes connectionStatus = CPConnectionStatusTypes.unknown;
  final CarPlayManager _carPlayManager = CarPlayManager();

  @override
  void initState() {
    super.initState();
    _carPlayManager.initializeCarplayTemplates();
    _carPlayManager.setupCarplayConnectionListener(onCarplayConnectionChange);
  }

  @override
  void dispose() {
    _carPlayManager.removeListenerOnConnectionChange();
    super.dispose();
  }

  void onCarplayConnectionChange(CPConnectionStatusTypes status) {
    setState(() {
      connectionStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.black)),
        colorScheme: const ColorScheme.light(
          primary: NajiaColors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
