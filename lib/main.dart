import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/webScreenLayout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyADgHV1pSlrWa5xvMdJduh2wSvd4Y4ekjE",
          appId: "1:559136732708:web:736768797f256bd0984ab1",
          messagingSenderId: "559136732708",
          projectId: "instagram-clone-aecda",
          storageBucket: "instagram-clone-aecda.appspot.com"

      )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        title: 'Instagram Clone',
        debugShowCheckedModeBanner: false,
        // home:const ResponsiveLayout(
        //     mobileScreenLayout: MobileScreenLayout() ,
        //     webScreenLayout: WebScreenLayout())
        // home: const LoginScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active ){
              if(snapshot.hasData){
                return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout() ,
                    webScreenLayout: WebScreenLayout()
                );
              }

            }
            else if(snapshot.hasError){
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }
        return const LoginScreen();
            }),
        // home: const SignUpScreen(),
      ),
    );
  }
}
