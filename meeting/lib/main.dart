import 'package:flutter/material.dart';
import 'package:meeting/Home/HomeScreen.dart';
import 'Seat_Diagram/Seat.dart';

void main(){
  SyncfusionLicense.registerLicense('NT8mJyc2IWhiZH1nfWN9Z2poYmF8YGJ8ampqanNiYmlmamlmanMDHmg3ITcyJ2JnYmYTND4yOj99MDw+');

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SeatScreen(),
    );
  }
}

