import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future _createTables(Database db, int version) async {
  await db.execute('''
    CREATE TABLE unit_groups(
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT
    )
    '''
  );

  await db.execute('''
    CREATE TABLE units(
      id INTEGER PRIMARY KEY,
      driver TEXT,
      plate_number TEXT,
      model TEXT,
      bought_date TEXT,
      note TEXT,
      unit_group_id INTEGER,
      FOREIGN KEY (unit_group_id)
        REFERENCES unit_groups (id)
    )
    '''
  );

  await db.execute('''
    CREATE TABLE unit_equipments(
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT,
      unit_id INTEGER NOT NULL,
      FOREIGN KEY (unit_id)
        REFERENCES units (id)
    )
  ''');

  await db.execute('''
    CREATE TABLE unit_reminders(
      id INTEGER PRIMARY KEY,
      note TEXT NOT NULL,
      unit_id INTEGER NOT NULL,
      due_at TEXT,
      repeat_skip INT,
      repeat_date TEXT,
      FOREIGN KEY (unit_id)
        REFERENCES units (id)
    )
  ''');

  await db.execute('''
    CREATE TABLE work_cost(
      id INTEGER PRIMARY KEY,
      title TEXT,
      note TEXT,
      date TEXT NOT NULL,
      price_ton INT NOT NULL,
      capacity_ton REAL NOT NULL,
      fuel_price INT NOT NULL,
      fuel_liter INT NOT NULL,
      driver_percentage REAL NOT NULL
    )
  ''');
}

class DatabaseHelper {
  static Future<Database> connect() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'uneed.db'),
      onCreate: _createTables,
      version: 1,
    );

    return database;
  }
}
