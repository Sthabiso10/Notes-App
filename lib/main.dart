import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/home_page/home_page.dart';

void main() async {
  //initialise the hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
    );
  }
}
