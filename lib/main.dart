import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uneed/db.dart';
import 'package:uneed/screen/home.dart';
import 'package:uneed/routes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }

  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uneed - GF999',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DatabaseInitializer(),
    );
  }
}

class DatabaseInitializer extends StatelessWidget {
  const DatabaseInitializer({super.key});

  Widget routesBuilder(BuildContext context, AsyncSnapshot<Database> snapshot) {
    if (snapshot.hasData) {
      return HomePage(
        routes: routes
      );
    } else if (snapshot.hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(snapshot.error.toString()),
              ElevatedButton(onPressed: () {}, child: const Icon(Icons.refresh))
            ],
          )
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: DatabaseHelper.connect(), builder: routesBuilder);
  }
}