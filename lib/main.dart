import 'package:covid_result_app/views/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Result',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Regular',
      ),
      home: const RegisterView(),
    );
  }
}
