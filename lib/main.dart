import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vouchex/src/bindings/bindings.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/routes/routes.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Stripe.publishableKey = stripePublishKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        notificationClicked(message, closed: true);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showInAppNotification(
        title: message.notification!.title!,
        message: message.notification!.body!,
        onTap: (_) => notificationClicked(message),
        duration: const Duration(seconds: 30),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationClicked(message);
    });
    super.initState();
  }

  void notificationClicked(RemoteMessage message, {bool closed = false}) async {
    Get.toNamed("/Notification");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vouchex App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      getPages: routes,
      initialRoute: BottomBarController().isUserLoggedIn() ? '/BottomBar' : '/',
      initialBinding: MainBindings(),
    );
  }
}

