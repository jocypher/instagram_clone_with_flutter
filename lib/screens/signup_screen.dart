import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/widgets/text_field.dart';
import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();

  }
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
              Flexible(flex: 2, child: Container()),
              //logo image
              SvgPicture.asset("assets/ic_instagram.svg",
                  color: primaryColor,
                  height: 64),

              const SizedBox(height: 64),

              // email text field input
              TextFieldInput(
                hintText: "Enter your Email Address",
                textEditingController:_emailTextEditingController ,
                textInputType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              // password text field input
              TextFieldInput(textEditingController: _passwordTextEditingController,
                textInputType: TextInputType.text,
                hintText: "Enter your password",
                isPassword : true,
              ),
              const SizedBox(height: 24),
              // login container
              InkWell(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4) ) )
                  ),
                  child: const Text("Login"),
                ),
              ),

              Flexible(flex: 2, child: Container()),
              //whether the user has an account or not
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:const  EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Sign Up", style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  )
                ],
              )

            ],),
        ),
      ),

    );
  }
}
