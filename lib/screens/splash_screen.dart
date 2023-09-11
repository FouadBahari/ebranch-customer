
import 'package:e_branch_customer/screens/authscreens/signup_screen.dart';
import 'package:e_branch_customer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helpers/helperfunctions.dart';
import '../helpers/navigations.dart';
import 'authscreens/login_screen.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),() async {
      String jwt  = await getSavedString("jwt", "");
      // Navigation.removeUntilNavigator(context, FirebaseAuth.instance.currentUser==null?const LoginScreen():HomeScreen());
      Navigation.removeUntilNavigator(context, jwt==""?const LoginScreen():HomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("images/logo.png",height: 200,width: 200,fit: BoxFit.fill,),
      ),
    );
  }


}