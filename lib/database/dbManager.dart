import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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