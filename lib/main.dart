import 'package:e_branch_customer/providers/auth_provider.dart';
import 'package:e_branch_customer/providers/home_provider.dart';
import 'package:e_branch_customer/screens/splash_screen.dart';
import 'package:e_branch_customer/services/fcm_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'helpers/config.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMService().setupFlutterNotifications();
  FCMService().showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FCMApi().initNotifications();
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   var token = await FirebaseMessaging.instance.getToken();
   print(token);
  if (!kIsWeb) {
    await FCMService().setupFlutterNotifications();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider())
      ],
      child: MaterialApp(
        title: 'E-Branch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Config.mainColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white,iconTheme: IconThemeData(color: Colors.white),
         // textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme).copyWith(
           // bodyText1: GoogleFonts.cairo(textStyle: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        home: Splashscreen(),
      ),
    );
  }
}