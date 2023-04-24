import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/widgets/text_field.dart';
import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final double height = 20.0;
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _bioController.dispose();
    _userNameController.dispose();

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

               const SizedBox(height: 17),
                // circle avatar for profile image
              Stack(
                children: [
                  const CircleAvatar(
                    radius : 64,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1682193965136-c8650b543426?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"
                    )
                  ),
                  Positioned(
                    bottom: -12,
                    left: 80,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ]
              ),
              const SizedBox(height: 17),
                // username text field input
              TextFieldInput(
                hintText: "Enter your Username",
                textEditingController:_userNameController ,
                textInputType: TextInputType.text,
              ),

            SizedBox(height: height),

              // email text field input
              TextFieldInput(
                hintText: "Enter your Email Address",
                textEditingController:_emailTextEditingController ,
                textInputType: TextInputType.emailAddress,
              ),

              SizedBox(height: height),

              // password text field input
              TextFieldInput(textEditingController: _passwordTextEditingController,
                textInputType: TextInputType.text,
                hintText: "Enter your password",
                isPassword : true,
              ),
              SizedBox(height: height),

              // bio field
              TextFieldInput(textEditingController: _bioController,
                textInputType: TextInputType.text,
                hintText: "Enter your bio",
              ),

              SizedBox(height: height),

              // login container
              InkWell(
                onTap: () async {
                  String res = await AuthMethods().SignUpUser(
                      email: _emailTextEditingController.text,
                      password: _passwordTextEditingController.text,
                      bio: _bioController.text,
                      username: _userNameController.text);
                  print(res);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4) ) )
                  ),
                  child: const Text("Sign Up"),
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
