import 'package:e_branch_customer/providers/home_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oktoast/oktoast.dart';

import '../screens/authscreens/login_screen.dart';
import 'navigations.dart';

toast(msg,context){
showToast(msg,
  textPadding: const EdgeInsets.all(15),
  context: context,
  textDirection: TextDirection.rtl,
  duration: const Duration(seconds: 2),
  position: ToastPosition.center,
  backgroundColor: Colors.black.withOpacity(0.8),
  radius: 13.0,
  textStyle: const TextStyle(fontSize: 16.0),);
}


// Retrieve string data stored
Future<String> getSavedString(String value,String defaultVal) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String savedValue = _prefs.getString(value) ?? defaultVal;
  return savedValue;
}

// Store String data
Future<bool> setSavedString(String key,String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool savedValue =await _prefs.setString(key,value);
  return savedValue;
}

logOut(context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.clear();
  Navigation.ReplacementNavigator(context, LoginScreen());
}

// get current location

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


Future<String?> getToken() async{
  String? fcm = await FirebaseMessaging.instance.getToken();
  return fcm;
}