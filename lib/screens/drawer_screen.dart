import 'dart:convert';
import 'package:e_branch_customer/screens/terms_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/helperfunctions.dart';
import '../helpers/navigations.dart';
import '../models/authmodels/user_model.dart';
import '../providers/home_provider.dart';
import 'authscreens/login_screen.dart';
import 'authscreens/profile_screen.dart';
import 'chatlist.dart';
import 'contactus_screen.dart';
import 'home_screen.dart';
import 'notifications_screen.dart';
import 'orders/orders_screen.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  String newMsg = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchProfileData();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                color: Colors.white,
              ),
              Container(
                height: 250,
                color: Config.mainColor,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Image.asset("images/logo.png",fit: BoxFit.fill,height: 60,width: 60,),
                    ),
                    const SizedBox(height: 7,),
                    CustomText(text: "${nameController.text}", fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white, textDecoration: TextDecoration.none,),
                    CustomText(text: "${emailController.text}", fontSize: 11,color: Colors.white,textDecoration: TextDecoration.none,),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: Config.responsiveHeight(context)-250,
            width: double.infinity,
            color: Config.mainColor,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.removeUntilNavigator(context, HomeScreen());
                        },
                        title: CustomText(text:"الرئيسية", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          Navigation.mainNavigator(context, ProfileScreen());
                        },
                        title: CustomText(text:"الشخصية", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Icon(Icons.person,color: Colors.white),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                         Navigation.mainNavigator(context, OrdersScreen());
                        },
                        title: CustomText(text:"الطلبات", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Image.asset("images/orders.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                         Navigation.mainNavigator(context, NotificationScreen());
                        },
                        title: CustomText(text:"الاشعارات", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Icon(Icons.notifications_sharp,color: Colors.white,),
                      ),
                    ),

                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: ListTile(
                    //     onTap: () async {
                    //       await setSavedString("newMsg", "");
                    //       newMsg = "";
                    //       Navigator.pop(context);
                    //      Navigation.mainNavigator(context, ChatsListScreen());
                    //     },
                    //     title: CustomText(text:"المحادثات", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                    //     leading: Stack(
                    //       alignment: Alignment.topRight,
                    //       children: [
                    //         Icon(Icons.chat,color: Colors.white,),
                    //         if(newMsg=="true")
                    //           CircleAvatar(
                    //             radius: 6,
                    //             backgroundColor: Colors.red,
                    //           )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //
                    // Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, ContactUsScreen());
                        },
                        title: CustomText(text:"اتصل بنا", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Icon(Icons.people,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "terms"));
                        },
                        title: CustomText(text:"الشروط والأحكام", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Image.asset("images/terms.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "privcy"));
                        },
                        title: CustomText(text:"سياسة الخصوصية", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Image.asset("images/terms.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "about"));
                        },
                        title: CustomText(text:"معلومات عنا", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Image.asset("images/terms.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),


                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: () async {
                         SharedPreferences pre = await SharedPreferences.getInstance();
                         pre.clear();
                         // await FirebaseAuth.instance.signOut();
                          Navigation.removeUntilNavigator(context, LoginScreen());
                        },
                        title: CustomText(text:"خروج", fontSize: 14,color: Colors.white,textDecoration: TextDecoration.none,),
                        leading: Icon(Icons.logout,color: Colors.white,),
                      ),
                    ),

                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /*fetchProfileData() async {
    Map<String,dynamic> mapResponse = jsonDecode(await getSavedString("userData", ""));
    Data model = Data.fromJson(mapResponse);
    print(model);
    nameController.text = "الاسم بالكامل : ${model.name.toString()}";
    emailController.text = "البريد الالكتروني : ${model.email.toString()}";

    await Provider.of<HomeProvider>(context,listen: false).getChatsList();
    for( var element in Provider.of<HomeProvider>(context,listen: false).allCatsModel.data!){
      print(element.seenUser);
      if(element.seenUser == 0){
        await setSavedString("newMsg", "true");
        newMsg = "true";
        break ;
      }
    }

    setState(() {});
  }*/
}