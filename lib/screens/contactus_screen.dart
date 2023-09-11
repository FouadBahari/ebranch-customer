import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/helperfunctions.dart';
import '../providers/home_provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var msgController = TextEditingController();

  var _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(text: "تواصل معنا", leading: SizedBox.shrink(), actions: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios),
              ),
            )
          ]),
      body: Form(
        key: _formState,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInput(
                  controller: nameController,
                  hint: "الاسم بالكامل",
                  textInputType: TextInputType.text,
                  suffixIcon:  SizedBox.shrink(),
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
                    controller: emailController,
                    hint: "البريد الإلكتروني",
                    textInputType: TextInputType.emailAddress,
                    suffixIcon:  SizedBox.shrink(),
                    onTap: () {},
                    prefixIcon: Icon(
                      Icons.email,
                      color: Config.mainColor,
                    ),
                    onChange: (String) {},
                    maxLines: 1),
                const SizedBox(
                  height: 15,
                ),
                CustomInput(
                    controller: phoneNumberController,
                    hint: "رقم الهاتف",
                    textInputType: TextInputType.phone,
                    suffixIcon: SizedBox.shrink(),
                    onTap: () {},
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Config.mainColor,
                    ),
                    onChange: (String) {},
                    maxLines: 1),
                const SizedBox(
                  height: 30,
                ),
                CustomInput(
                  controller: msgController,
                  hint: "الرسالة",
                  textInputType: TextInputType.text,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 85),
                    child: Icon(
                      Icons.chat,
                      color: Config.mainColor,
                    ),
                  ),
                  maxLines: 4,
                  onTap: () {},
                  prefixIcon:  SizedBox.shrink(),
                  onChange: (String) {},
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    print("object");
                    toast("تم الارسال بنجاح", context);
                    //  if (_formState.currentState!.validate()) {
                    /* String res = */ await FirebaseFirestore.instance
                        .collection("messages")
                        .doc()
                        .set({
                      "sentby": nameController.text,
                      "email": emailController.text,
                      "phoneNo": phoneNumberController.text,
                      "text": msgController.text
                    });
                  //  toast("تم الرسال بنجاح", context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم الرسال بنجاح"))));

                    setState(() {
                      emailController.clear();
                      msgController.clear();
                      phoneNumberController.clear();
                      nameController.clear();
                    });
                  },
                  //  padding: EdgeInsets.symmetric(vertical: verticalPadding,horizontal: horizontalPadding,),
                  /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(double.parse("$radius")),
      ),*/
                  // color: color??Config.buttonColor,
                  child: CustomText(
                    text: "ارسال",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    textDecoration: TextDecoration.none,
                  ),
                ),
                /*CustomButton(
                  text: "ارسال",
                  onPressed: () async {
                  //  if (_formState.currentState!.validate()) {
                      */ /* String res = */ /* await FirebaseFirestore.instance
                          .collection("messages")
                          .doc()
                          .set({
                        "sentby": nameController.text,
                        "email": emailController.text,
                        "phoneNo": phoneNumberController.text,
                        "text": msgController.text
                      });
                      toast("تم التسجيل بنجاح", context);
                      setState(() {
                        emailController.clear();
                        msgController.clear();
                        phoneNumberController.clear();
                        nameController.clear();
                      });
                      */ /*if (res == 'success') {
                    //  submitForm();
                      toast("تم التسجيل بنجاح", context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                      );*/ /*
                      */ /*  Map response= await context.read<HomeProvider>().contactUs({"name": nameController.text,"email": emailController.text,"phone": phoneNumberController.text,"messages":msgController.text});
                    toast(response['msg'], context);
                    if(response['status']){
                      nameController.text="";
                      emailController.text="";
                      phoneNumberController.text="";
                      msgController.text="";*/ /*
                      //  }
                    },
               //   },
                  color: Config.buttonColor,
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
