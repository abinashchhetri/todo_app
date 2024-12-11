import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_app/pages/home_page.dart';

void main() async {
  //init the hive
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            primary: const Color.fromARGB(255, 235, 223, 115),
            seedColor: Color.fromARGB(255, 224, 202, 4),
            brightness: Brightness.light),

        // colorScheme: ColorScheme.light().copyWith(primary: Colors.yellow),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

