import 'package:flutter/material.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/db/database_service.dart';
import 'package:simple_note/utils/app.routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/rendering.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(DatabaseService.boxName);

  // Menonaktifkan logo "Debug" dan overlay performance
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintBaselinesEnabled = false;
  debugPaintPointersEnabled = false;
  debugShowCheckedModeBanner: false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Note',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      routeInformationParser: AppRoutes.goRouter.routeInformationParser,
      routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
      routerDelegate: AppRoutes.goRouter.routerDelegate,
    );
  }
}
