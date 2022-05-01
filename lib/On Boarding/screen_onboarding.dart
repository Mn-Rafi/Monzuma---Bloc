import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/First%20Profile/screen_first_profile.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/customs/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenOnboarding extends StatefulWidget {
  const ScreenOnboarding({Key? key}) : super(key: key);

  @override
  State<ScreenOnboarding> createState() => _ScreenOnboardingState();
}

class _ScreenOnboardingState extends State<ScreenOnboarding> {
  _storeOnboardingInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  late Box<Categories> categories;
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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Manage ',
                            style: customTextStyleOne(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? firstBlue
                                        : Colors.white,
                                fontSize: 32)),
                        TextSpan(
                          text: 'your income and expence ',
                          style: customTextStyleOne(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? firstBlack
                                      : Colors.white,
                              fontSize: 32),
                        ),
                        TextSpan(
                            text: 'quickly ',
                            style: customTextStyleOne(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? firstOrange
                                        : Colors.white,
                                fontSize: 32)),
                      ])),
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Image.asset(
                              'images/financial-management-statistics-vector-22868355.png',
                            )
                          : Image.asset(
                              'images/moneyManagerdark.png',
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 48.h,
                decoration: customBoxDecoration,
                child: GestureDetector(
                  onTap: () async {
                    await _storeOnboardingInfo();
                    categories = Hive.box<Categories>('categories');
                    for (int i = 0; i < listIncomeCategories.length; i++) {
                      categories.add(Categories(
                          category: listIncomeCategories[i], type: true));
                    }
                    for (int i = 0; i < listExpenseCategories.length; i++) {
                      categories.add(Categories(
                          category: listExpenseCategories[i], type: false));
                    }

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => const ScreenProfile(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Let\'s Get Started',
                        style: customTextStyleOne(fontSize: 20),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 30.w,
                        color: firstBlack,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
