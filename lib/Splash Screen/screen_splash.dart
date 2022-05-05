import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:money_manager_app/First%20Profile/screen_first_profile.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/On%20Boarding/screen_onboarding.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/customs/utilities.dart';
import 'package:money_manager_app/homePage/screen_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

int? isViewd;
int? isViewdFirstProfile;

class _ScreenSplashState extends State<ScreenSplash> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: ' ',
      );
      if (authenticated) {
        _navigate();
      } else {
        _authenticate();
      }
    } on PlatformException {
      return;
    }
    if (!mounted) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(
                    'Please allow permissions for Notifications',
                    style: customTextStyleOne(),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'dont allow',
                          style: customTextStyleOne(),
                        )),
                    TextButton(
                        onPressed: () => AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.pop(context)),
                        child: Text(
                          'allow',
                          style: customTextStyleOne(),
                        ))
                  ],
                ));
      }
    });
    if (Hive.box<LockAuthentication>('lockAuth').values.toList().isNotEmpty) {
      if (Hive.box<LockAuthentication>('lockAuth')
          .values
          .toList()[0]
          .enableAuth) {
        _authenticate();
      } else {
        _navigate();
      }
    } else {
      Hive.box<LockAuthentication>('lockAuth')
          .add(LockAuthentication(enableAuth: false, enableNoti: true));
      _navigate();
    }
  }

  _navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 2300));

    isViewd = prefs.getInt('onBoard');
    isViewdFirstProfile = prefs.getInt('onFirstProfile');
    isFirstTime = prefs.getInt('isFirstTime');

    if (isFirstTime == 0) {
      welcome = 'Welcome back!';
    }

    if (isViewd != 0 && isViewdFirstProfile != 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenOnboarding()));
    } else if (isViewd == 0 && isViewdFirstProfile != 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenProfile()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenHome()));
    }
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    systemUi(context);
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (timeBackButton == null ||
            now.difference(timeBackButton!) > const Duration(seconds: 2)) {
          timeBackButton = now;
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.2, color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'double tap to exit',
                  textAlign: TextAlign.center,
                  style: customTextStyleOne(color: firstBlack),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 10000,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return Future.value(false);
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(animatedTexts: [
                  ColorizeAnimatedText('Monzuma',
                      speed: const Duration(milliseconds: 400),
                      textStyle: customTextStyleOne(fontSize: 50.sp),
                      colors: [
                        firstBlue,
                        firstOrange,
                        walletPink,
                        incomeGreen,
                        firstBlue,
                        firstOrange,
                        walletPink,
                        incomeGreen
                      ]),
                ]),
                AnimatedTextKit(animatedTexts: [
                  ColorizeAnimatedText('Your smart ledger',
                      speed: const Duration(milliseconds: 400),
                      textStyle: customTextStyleOne(fontSize: 24.sp),
                      colors: [
                        firstBlue,
                        firstOrange,
                        walletPink,
                        incomeGreen,
                        firstBlue,
                        firstOrange,
                        walletPink,
                        incomeGreen
                      ])
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}