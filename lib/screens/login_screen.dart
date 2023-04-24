import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              //logo image
              SvgPicture.asset("assets/ic_instagram.svg",
                color: primaryColor,
                height: 64, )
            ],),
        ),
      ),
      
    );
  }
}
