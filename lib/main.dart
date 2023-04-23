import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/webScreenLayout.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      home:const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout() ,
          webScreenLayout: WebScreenLayout())
    );
  }
}
