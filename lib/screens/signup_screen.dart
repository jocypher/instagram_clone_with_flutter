import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/webScreenLayout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/widgets/text_field.dart';
import '../utils/colors.dart';
import "package:instagram_clone/utils/utils.dart";

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
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  selectImage() async{
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().SignUpUser(
        email: _emailTextEditingController.text,
        password: _passwordTextEditingController.text,
        bio: _bioController.text,
        username: _userNameController.text,
        file: _image!
    );
    setState(() {
      _isLoading = false;
    });
    if(res != 'success'){
      showSnackBar(res, context);
    }else{
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
            const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout() ,
          webScreenLayout: WebScreenLayout()
      )
      )
      );
    }

  }
  void navigateToLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
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
                  _image != null?
                CircleAvatar(
                  radius : 64,
                  backgroundImage: MemoryImage(_image!)) :
                const CircleAvatar(
                    radius : 64,
                    backgroundImage: NetworkImage(
                        networkImage
                    )
                  ),
                  Positioned(
                    bottom: -12,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
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
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))
                  ),
                  child: _isLoading ? const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ) : const Text("Sign Up"),
                ),
              ),

              Flexible(flex: 2, child: Container()),
              //whether the user has an account or not
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:const  EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account? "),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Log in", style: TextStyle(
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
