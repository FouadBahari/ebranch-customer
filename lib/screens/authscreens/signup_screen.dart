import 'dart:convert';

import 'package:e_branch_customer/screens/authscreens/login_screen.dart';
import 'package:e_branch_customer/screens/home_screen.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();
  late var countriesModel;

  GlobalKey _formKey = GlobalKey<FormState>();

  var addressController = TextEditingController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      countriesModel = await Provider.of<AuthProvider>(context,listen: false).getCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    // submitForm() async {
    //   if (passwordController.text.isEmpty) {
    //     toast("الرقم السرى لابد ان يكون اكثر من ستة عناصر", context);
    //   } else {
    //     await FirebaseAuthMethods().completeProfile(
    //       //  licencePic: _licenceimageURL!,
    //       //  istemaraPic: _istemaraimageURL!,
    //       // identityPic: _identityimageURL!,
    //       fullname: nameController.text,
    //       phoneNumber: phoneNumberController.text,
    //       address: addressController.text,
    //       context: context,
    //     );
    //   }
    // }

    return Scaffold(
      appBar:
          CustomAppBar(text: "تسجيل الدخول", leading: SizedBox.shrink(), actions: [
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
      body:
      Consumer<AuthProvider>(
         builder: (context, AuthProvider authProvider, child) {
        return SingleChildScrollView(
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
                    controller: nameController,
                    hint: "الاسم بالكامل",
                    textInputType: TextInputType.text,
                    suffixIcon: Icon(
                      Icons.person,
                      color: Config.mainColor,
                    ),
                    onTap: () {},
                    prefixIcon: Icon(
                      Icons.person,
                      color: Config.mainColor,
                    ),
                    onChange: (String) {},
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    onTap: () {},
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Config.mainColor,
                    ),
                    onChange: (String) {},
                    maxLines: 1,
                    controller: passwordController,
                    hint: "كلمة المرور",
                    textInputType: TextInputType.text,
                    obscureText: true,
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    onTap: () {},
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Config.mainColor,
                    ),
                    onChange: (String) {},
                    maxLines: 1,
                    controller: passwordConfirmationController,
                    hint: "تأكيد كلمة المرور",
                    textInputType: TextInputType.text,
                    obscureText: true,
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    onTap: () {},
                    onChange: (String) {},
                    prefixIcon: Icon( Icons.email,
                      color: Config.mainColor,),
                    maxLines: 1,
                    controller: emailController,
                    hint: "البريد الإلكتروني",
                    textInputType: TextInputType.emailAddress,
                    suffixIcon: Icon(
                      Icons.email,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    onTap: () {},
                    prefixIcon: Icon(Icons.phone,color: Config.mainColor,),
                    onChange: (String) {},
                    maxLines: 1,
                    controller: phoneNumberController,
                    hint: "رقم الهاتف",
                    textInputType: TextInputType.phone,
                    suffixIcon: Icon(
                      Icons.phone,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    onTap: () {},
                    prefixIcon: Icon(
                      Icons.home,
                      color: Config.mainColor,
                    ),
                    onChange: (String) {},
                    maxLines: 1,
                    controller: addressController,
                    hint: "العنوان",
                    textInputType: TextInputType.text,
                    suffixIcon: Icon(
                      Icons.home,
                      color: Config.mainColor,
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 55,
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(13),
                  //     border: Border.all(color: Config.mainColor)
                  //   ),
                  //   alignment: Alignment.centerRight,
                  //   child: Directionality(
                  //     textDirection: TextDirection.rtl,
                  //     child: DropdownButton<countries.Data>(
                  //       value: countriesValue,
                  //       underline: SizedBox(),
                  //       hint: CustomText(text: "اختر الدولة", fontSize: 14),
                  //       onChanged: (countries.Data newValue) async {
                  //         setState(()  {
                  //           countriesValue = newValue;
                  //         });
                  //         citiesValue = null;
                  //         citiesModel = await authProvider.getCities(newValue.id);
                  //       },
                  //       items: countriesModel.data
                  //           .map((countries.Data value) {
                  //         return DropdownMenuItem<countries.Data>(
                  //           value: value,
                  //           child: Container(
                  //             width: Config.responsiveWidth(context)*0.79,
                  //             child: Text(value.name),
                  //           ),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15,),
                  // Consumer<AuthProvider>(
                  //   builder: (context, citiesProvider,child) {
                  //     if(States.citiesState == CitiesState.LOADING){
                  //       return Center(child: CircularProgressIndicator());
                  //     }
                  //
                  //     if(States.citiesState == CitiesState.ERROR){
                  //       return Center(child: CustomText(text: "حدث خطأ", fontSize: 16,fontWeight: FontWeight.w600,));
                  //     }
                  //
                  //     return Container(
                  //       width: double.infinity,
                  //       height: 55,
                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(13),
                  //           border: Border.all(color: Config.mainColor)
                  //       ),
                  //       alignment: Alignment.centerRight,
                  //       child: Directionality(
                  //         textDirection: TextDirection.rtl,
                  //         child: DropdownButton<cities.Data>(
                  //           value: citiesValue,
                  //           icon: citiesModel==null?SizedBox():Icon(Icons.arrow_drop_down),
                  //           underline: SizedBox(),
                  //           hint: CustomText(text: "اختر المدينة", fontSize: 14),
                  //           onChanged: (cities.Data newValue) {
                  //             setState(() {
                  //               citiesValue = newValue;
                  //             });
                  //             print(citiesValue);
                  //           },
                  //           items: citiesModel==null?[]:citiesModel.data
                  //               .map((cities.Data value) {
                  //             return DropdownMenuItem<cities.Data>(
                  //               value: value,
                  //               child: Container(
                  //                 width: Config.responsiveWidth(context)*0.79,
                  //                 child: Text(value.name,textAlign: TextAlign.right,),
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     );
                  //   }
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigation.mainNavigator(context, LoginScreen());

                        },
                        child: CustomText(
                          text: "دخول",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textDecoration: TextDecoration.none,
                        ),
                      ),
                      Spacer(),
                      CustomText(
                        text: "نسيت كلمة المرور ؟",
                        fontSize: 14,
                        textDecoration: TextDecoration.none,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  States.registerState == RegisterState.LOADING
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: "تسجيل",
                          onPressed: () async {
                            if (passwordController.text !=
                                passwordConfirmationController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("كلمة المرور غير متطابقة"))));

                              // toast("كلمة المرور غير متطابقة", context);
                              return;
                            }
                            String? fcm = await getToken();

                            Map<String, dynamic> formData = {
                              'email': emailController.text,
                              "phone": phoneNumberController.text,
                              "password": passwordController.text,
                              'name': nameController.text,
                              'address': addressController.text,
                              "token": fcm,
                              "type": "user"
                            };
                            UserModel userModel = await authProvider.register(
                                formData);
                            if (userModel.status) {
                              setSavedString("jwt", userModel.data?.apiToken ?? "");
                              setSavedString(
                                  "userData", jsonEncode(userModel.data));
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم التسجيل بنجاح"))));

                              // toast("تم التسجيل بنجاح", context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم التسجيل بنجاح"))));

                              //  toast("تم التسجيل بنجاح", context);
                              Navigation.removeUntilNavigator(
                                  context, HomeScreen());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text('رقم الهاتف او البريد مسجل من قبل'))));
                            }
                            //
                            // String res = await FirebaseAuthMethods().createUser(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            //
                            //   context: context,
                            // );
                            // if (res == 'success') {
                            //   submitForm();
                            //   toast("تم التسجيل بنجاح", context);
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //         builder: (context) => HomeScreen()),
                            //   );
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم التسجيل بنجاح"))));
                            //
                            // //  toast("تم التسجيل بنجاح", context);
                            //   Navigation.removeUntilNavigator(
                            //       context, HomeScreen());
                            // } else {
                            //   toast("", context);
                            // }
                          },
                          color: Colors.transparent,
                        )
                ],
              ),
            ),
          ),
        );
     }),
    );
  }
}
