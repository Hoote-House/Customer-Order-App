import 'package:flutter/material.dart';
import 'pages/HomePage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movaka',
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(), 
      },
    );
  }
}