import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Logic/Expense_bloc/expense_bloc.dart';
import 'package:money_manager_app/Logic/Regular%20Payment/regularpayments_bloc.dart';
import 'package:money_manager_app/Logic/cubit/showimage_cubit.dart';
import 'package:money_manager_app/Logic/income_bloc/income_bloc.dart';
import 'package:money_manager_app/Logic/search/search_bloc.dart';
import 'package:money_manager_app/Splash Screen/screen_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_manager_app/themedata.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 255, 255, 255)));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<ProfileDetails>(ProfileDetailsAdapter());
  Hive.registerAdapter<Categories>(CategoriesAdapter());
  Hive.registerAdapter<Transactions>(TransactionsAdapter());
  Hive.registerAdapter<RegularPayments>(RegularPaymentsAdapter());
  Hive.registerAdapter<LockAuthentication>(LockAuthenticationAdapter());

  await Hive.openBox<ProfileDetails>('profiledetails');
  await Hive.openBox<Categories>('categories');
  await Hive.openBox<Transactions>('transactions');
  await Hive.openBox<RegularPayments>('regularPayments');
  await Hive.openBox<LockAuthentication>('lockAuth');

  AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icon',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic Notifications',
            channelDescription: 'Notification on presses',
            defaultColor: Colors.teal,
            importance: NotificationImportance.High,
            channelShowBadge: true),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          channelDescription: 'Monthly on presses',
          defaultColor: Colors.teal,
          locked: true,
          importance: NotificationImportance.High,
          soundSource: 'resource://raw/res_custom_notification',
        ),
      ],
      debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 793),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ShowimageCubit(),
            ),
            BlocProvider(
              create: (context) => RegularpaymentsBloc(),
            ),
            BlocProvider(
              create: (context) => SearchBloc(),
            ),
            BlocProvider(
              create: (context) => IncomeBloc(),
            ),
            BlocProvider(
              create: (context) => ExpenseBloc(),
            ),
          ],
          child: MaterialApp(
              themeMode: ThemeMode.system,
              localizationsDelegates: const [
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                MonthYearPickerLocalizations.delegate,
              ],
              darkTheme: MyTheme.darkTheme,
              theme: MyTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              home: const ScreenSplash()),
        );
      },
    );
  }
}
