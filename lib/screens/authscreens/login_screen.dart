import 'dart:convert';
import 'package:e_branch_customer/screens/authscreens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/config.dart';
import '../../helpers/helperfunctions.dart';
import '../../helpers/navigations.dart';
import '../../models/authmodels/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../services/firebase_auth_methods.dart';
import '../../states/auth_states.dart';
import '../home_screen.dart';
import 'forgotpass_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: "تسجيل الدخول", leading: Container(), actions: []),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Image.asset("images/logo.png", width: 180, height: 180,),
                const SizedBox(height: 50,),
                CustomInput(controller: phoneNumberController,
                  hint: "رقم الهاتف",
                  textInputType: TextInputType.emailAddress,
                  suffixIcon: Icon(Icons.phone, color: Config.mainColor,),
                  onTap: () {},
                  prefixIcon: SizedBox.shrink(),
                  onChange: (String) {},
                  maxLines: 1,),
                const SizedBox(height: 15,),
                CustomInput(controller: passwordController,
                  hint: "كلمة المرور",
                  textInputType: TextInputType.text,
                  obscureText: true,
                  suffixIcon: Icon(Icons.lock, color: Config.mainColor,),
                  onTap: () {},
                  prefixIcon: SizedBox.shrink(),
                  onChange: (String) {},
                  maxLines: 1,),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigation.mainNavigator(context, SignUpScreen());
                        },
                        child: CustomText(text: "تسجيل",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textDecoration: TextDecoration.none,)),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          Navigation.mainNavigator(context, ForgotPassScreen());
                        },
                        child: CustomText(text: "نسيت كلمة المرور ؟",
                          fontSize: 14,
                          textDecoration: TextDecoration.none,)),
                  ],
                ),
                const SizedBox(height: 50,),
                // Consumer<AuthProvider>(
                //     builder: (context, authProvider, child) {
                //       return States.registerState == RegisterState.LOADING
                //           ? const Center(child: CircularProgressIndicator())
                //           :
                //       CustomButton(text: "دخول", onPressed: () async {
                //         String? fcm = await getToken();
                //         String res = await FirebaseAuthMethods().userLogin(
                //           email: phoneNumberController.text,
                //           password: passwordController.text,
                //           context: context,
                //         );
                //         if (res == "success") {
                //           //  toast("تم التسجيل بنجاح", context);
                //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //               content: Directionality(
                //                   textDirection: TextDirection.rtl,
                //                   child: Text("تم التسجيل بنجاح"))));
                //
                //           Navigator.of(context).pushReplacement(
                //             MaterialPageRoute(
                //               builder: (context) => HomeScreen(),
                //             ),
                //           );
                //         } else {}
                //       }, color: Colors.transparent,);
                //     }
                // ),
                Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return States.registerState == RegisterState.LOADING
                          ? Center(child: CircularProgressIndicator())
                          : CustomButton(text: "دخول", onPressed: () async {
                        String? fcm = await getToken();

                        Map<String, dynamic> formData = {
                          "phone": phoneNumberController.text,
                          "password": passwordController.text,
                          "token": fcm,
                          "type": "user"
                        };
                        UserModel userModel = await authProvider.login(
                            formData);
                        if (userModel.status) {
                          setSavedString("jwt", userModel.data?.apiToken ?? "");
                          setSavedString(
                              "userData", jsonEncode(userModel.data));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم التسجيل بنجاح"))));
                          Navigation.removeUntilNavigator(
                              context, HomeScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text(userModel.msg!))));
                        }
                      }, color: Colors.transparent,);
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}