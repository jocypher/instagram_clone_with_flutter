import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/webScreenLayout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/utils.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();

  }

  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().LoginUser(
        email: _emailTextEditingController.text,
        password: _passwordTextEditingController.text);
    if(res == 'success') {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
      const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout() ,
          webScreenLayout: WebScreenLayout()
      ))
      );
    }else{
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
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
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4) ) )
                  ),
                  child: _isLoading ? const Center(child:
                        CircularProgressIndicator(color: primaryColor)
                  ) : const Text("Login"),
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
                    onTap: navigateToSignup,
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
