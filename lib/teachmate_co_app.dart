import 'package:flutter/material.dart';
import 'package:teach_mate_co/widgets/bottom_bar.dart';

class TeachMateCOApp extends StatefulWidget {
  const TeachMateCOApp({super.key});

  @override
  State<TeachMateCOApp> createState() => _TeachMateCOAppState();
}

class _TeachMateCOAppState extends State<TeachMateCOApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teach Mate CO',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: Center(child: Text("Hello Teach Mate CO")),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
