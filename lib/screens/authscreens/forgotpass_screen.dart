import 'package:e_branch_customer/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/config.dart';
import '../../helpers/helperfunctions.dart';
import '../../providers/auth_provider.dart';
import '../../states/auth_states.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: "استعادة كلمة المرور",
          leading: SizedBox.shrink(),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.arrow_forward_ios),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "images/logo.png",
                  width: 180,
                  height: 180,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomInput(
                  controller: phoneNumberController,
                  hint: "البريد الالكترونى",
                  textInputType: TextInputType.phone,
                  suffixIcon: Icon(
                    Icons.mail,
                    color: Config.mainColor,
                  ),
                  onTap: () {},
                  prefixIcon: SizedBox.shrink(),
                  onChange: (String) {},
                  maxLines: 1,
                ),
                const SizedBox(height: 15,),
                CustomInput(controller: passwordController, hint: "كلمة المرور الجديدة", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,), onTap: () {  }, prefixIcon:  Icon(Icons.ac_unit_rounded), onChange: (String ) {  }, maxLines: 1,),
                const SizedBox(
                  height: 50,
                ),
                Consumer<AuthProvider>(
                builder: (context, authProvider,child) {
                return States.registerState==RegisterState.LOADING?Center(child: CircularProgressIndicator()):
                CustomButton(
                  text: "ارسال",
                  onPressed: () async {
                    // await FirebaseAuthMethods().forgotPassword(
                    //     context: context,
                    //     email: phoneNumberController.text.trim().toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text("سيتم ارسال الرقم السرى الجديد"))));
                       if (phoneNumberController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text("من فضلك املأ جميع البيانات"))));
                       toast("من فضلك املأ جميع البيانات", context);
                     return;
                    } else {
                      // String response = await FirebaseAuthMethods()
                      //     .forgotPassword(
                      //         context: context,
                      //         email:
                      //             phoneNumberController.text.trim().toString());

                         Map<String,dynamic> formData ={
                           "phone": phoneNumberController.text,
                           "newpassword": passwordController.text,
                           "type": "user"
                         };
                         Map<String,dynamic> userModel = await authProvider.forgotPass(formData);
                         toast(userModel['msg'], context);
                         if(userModel['status']){
                           Navigator.pop(context);
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Directionality(
                                   textDirection: TextDirection.rtl,
                                   child: Text("سيتم ارسال الرقم السرى الجديد"))));
                         }else{
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Directionality(
                                   textDirection: TextDirection.rtl,
                                   child: Text("حد خطأ"))));
                         }
                    }
                  },
                  color: Colors.transparent,
                );
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
