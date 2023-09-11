import 'dart:convert';

import 'package:e_branch_customer/helpers/config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../components/components.dart';
import '../../helpers/helperfunctions.dart';
import '../../models/authmodels/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: "الملف الشخصي", leading: SizedBox.shrink(), actions: [
             InkWell(
               onTap: (){
                 Navigator.pop(context);
               },
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Icon(Icons.arrow_forward_ios,color: Config.buttonColor,),
               ),
             )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Image.asset(
              "images/logo.png", width: 180, height: 180,),
            const SizedBox(height: 15,),
            CustomInput(onTap: () {},
              prefixIcon:Icon(Icons.qr_code,color: Config.mainColor,),
              onChange: (String) {},
              maxLines: 1,
              controller: idController,
              hint: "الكود الخاص بك : ${123456852}",
              textInputType: TextInputType.text,
              readOnly: true,
              suffixIcon: SizedBox.shrink(),),
            const SizedBox(height: 15,),
            CustomInput(onTap: () {},
              prefixIcon: Icon(Icons.person, color: Config
                  .mainColor,),
              onChange: (String) {},
              maxLines: 1,
              controller: nameController,
              hint: "  : الاسم بالكامل",
              textInputType: TextInputType.text,
              readOnly: true,
              suffixIcon: SizedBox.shrink(),),
            const SizedBox(height: 15,),
            CustomInput(onTap: () {},
              prefixIcon: Icon(Icons.email, color: Config
                  .mainColor,),
              onChange: (String) {},
              maxLines: 1,
              controller: emailController,
              hint: "  : البريد الالكتروني",
              textInputType: TextInputType.emailAddress,
              readOnly: true,
              suffixIcon: SizedBox.shrink(),),
            const SizedBox(height: 15,),
            CustomInput(onTap: () {},
              prefixIcon:Icon(Icons.phone,color: Config.mainColor,),
              onChange: (String) {},
              maxLines: 1,
              controller: phoneController,
              hint: "  :  رقم الهاتف",
              textInputType: TextInputType.phone,
              readOnly: true,
              suffixIcon:SizedBox.shrink(),),
            const SizedBox(height: 15,),
          ],
        )
      ),
    );
  }

  fetchProfileData() async {
    Map<String, dynamic> mapResponse = jsonDecode(
        await getSavedString("userData", ""));
    Data model = Data.fromJson(mapResponse);
    print(model);
    idController.text = "الكود الخاص بك : ${model.id.toString()}";
    nameController.text = "${model.name.toString()}  : الاسم بالكامل";
    emailController.text = "${model.email.toString()}  : البريد الالكتروني";
    phoneController.text = "${model.phone.toString()}  :  رقم الهاتف";
  }
}