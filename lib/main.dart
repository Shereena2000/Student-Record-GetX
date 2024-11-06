

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record/db/functions/add_to_hive.dart';
import 'package:student_record/db/model/data.dart';
import 'package:student_record/screens/home_screen.dart';

Future<void> main() async {
 await Hive.initFlutter();
 if (!Hive.isAdapterRegistered(StudentDataAdapter().typeId)) {
   Hive.registerAdapter(StudentDataAdapter());
 }
 await Hive.openBox<StudentData>('studentBox');
 AddStudentData.getAllStudent();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home:const HomeScreen());
  }
}