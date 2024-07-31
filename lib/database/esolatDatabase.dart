import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/splashscreen/splashscreen.dart';

Future<Database> openDatabaseAndCreateTable() async {
  final databasePath = await getDatabasesPath();
  final database = await openDatabase(
    join(databasePath, 'prayer_times.db'),
    onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE IF NOT EXISTS prayer_times(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          hijri TEXT,
          date TEXT,
          day TEXT,
          imsak TEXT,
          fajr TEXT,
          syuruk TEXT,
          dhuhr TEXT,
          asr TEXT,
          maghrib TEXT,
          isha TEXT
        )
      ''');
    },
    version: 1,
  );
  return database;
}

// Function to save prayer times to SQLite with insert or update logic.
Future<void> savePrayerTimesToSQLite(List<dynamic> prayerTimes, String state,
    String zone, String zoneName, context) async {
  final database = await openDatabaseAndCreateTable();

  await database.delete('prayer_times');

  for (final prayerTime in prayerTimes) {
    final String hijri = prayerTime['hijri'];
    final String date = prayerTime['date'];
    final String day = prayerTime['day'];
    final String imsak = prayerTime['imsak'];
    final String fajr = prayerTime['fajr'];
    final String syuruk = prayerTime['syuruk'];
    final String dhuhr = prayerTime['dhuhr'];
    final String asr = prayerTime['asr'];
    final String maghrib = prayerTime['maghrib'];
    final String isha = prayerTime['isha'];

    try {
      // Delete first
      // Insert or update the prayer time data into the SQLite table.
      await database.insert(
        'prayer_times',
        {
          'hijri': hijri,
          'date': date,
          'day': day,
          'imsak': imsak,
          'fajr': fajr,
          'syuruk': syuruk,
          'dhuhr': dhuhr,
          'asr': asr,
          'maghrib': maghrib,
          'isha': isha,
        },
        conflictAlgorithm:
            ConflictAlgorithm.replace, // Replace if data already exists
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  int currentYear = DateTime.now().year;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('zone', zone);
  prefs.setString('zone_name', zoneName);
  prefs.setString('state', state);
  prefs.setString('prayer_time_$currentYear', "$currentYear has been fetched");

  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    final databasePath = appDocDir.path;
    if (kDebugMode) {
      print(
          'Database path: open -a "DB Browser for SQLite" $databasePath/prayer_times.db');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error getting database path: $e');
    }
  }

  // Close the database when done.
  await database.close();

  // Navigate to the SplashScreen
  Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const SplashScreen(),
    ),
    (route) => false,
  );
}
