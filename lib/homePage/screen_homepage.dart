import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Logic/cubit/showimage_cubit.dart';
import 'package:money_manager_app/customs/utilities.dart';
import 'package:money_manager_app/homePage/expense/expense_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:money_manager_app/MainScreen/widgets/grid_container.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/Income/income_detailed_page.dart';
import 'package:money_manager_app/homePage/Income/screen_income.dart';
import 'package:money_manager_app/homePage/expense/screen_expense.dart';
import 'package:money_manager_app/homePage/widgets/custom_widgets.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenHomePage> createState() => _ScreenHomePageState();
}

String welcome = 'Welcome!';
int? isFirstTime;

class _ScreenHomePageState extends State<ScreenHomePage> {
  Icon? myIcon;
  Widget? myField;
  String searchInput = '';

  _storeFirstApperInfo() async {
    int isFirstTime = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isFirstTime', isFirstTime);
  }

  bool isDarkMode =
      SchedulerBinding.instance!.window.platformBrightness == Brightness.dark;

  @override
  void initState() {
    myField = Text(
      'Latest Transactions',
      style: customTextStyleOne(
          fontSize: 20.sp, color: isDarkMode ? firstWhite : firstBlack),
    );
    myIcon = const Icon(Icons.search);
    _storeFirstApperInfo();
    super.initState();
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    Box<Transactions> box = Hive.box<Transactions>('transactions');
    List<Transactions> transactionList = box.values
        .where((element) => element.categoryName
            .toLowerCase()
            .contains(searchInput.toLowerCase()))
        .toList();
    transactionList.sort((first, second) =>
        second.dateofTransaction.compareTo(first.dateofTransaction));
    List<ProfileDetails> profileDetails =
        Hive.box<ProfileDetails>('profiledetails').values.toList();
    systemUi(context);
    return SafeArea(
      child: WillPopScope(
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
          appBar: AppBar(
            foregroundColor: firstBlack,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Home',
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0.w, top: 30.w, right: 25.0.w, bottom: 100.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi ${profileDetails[0].nameofUser.toString()} 👋',
                            style: customTextStyleOne(
                                fontSize: 22.sp,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack),
                          ),
                          Text(
                            welcome,
                            style: customTextStyleOne(
                                fontSize: 18.sp,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack),
                          ),
                        ],
                      ),
                      CustomContainerForImage(
                          imagePath: profileDetails[0].imageUrl?.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text('Categories',
                      style: customTextStyleOne(
                          fontSize: 20.sp,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? firstWhite
                              : firstBlack)),
                  SizedBox(
                    height: 17.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ScreenIncome())),
                        child: const Hero(
                          tag: 'incomeHero',
                          child: CustomContainerForCatogories(
                              backgroundColor: incomeGreen,
                              imagePath: 'images/income.png',
                              title: 'Income'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ScreenExpense())),
                        child: const Hero(
                          tag: 'expenseHero',
                          child: CustomContainerForCatogories(
                              backgroundColor: expenseBlue,
                              imagePath: 'images/expense.png',
                              title: 'Expense'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocBuilder<ShowimageCubit, ShowimageState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: context
                                  .read<ShowimageCubit>()
                                  .changeMyField(
                                      myIcon!.icon!, myField!, searchInput),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (myIcon!.icon == Icons.search) {
                                myIcon = Icon(context
                                    .read<ShowimageCubit>()
                                    .changeIcon(
                                        Icons.clear, myField!, searchInput));
                              } else {
                                searchInput = '';
                                myIcon = Icon(context
                                    .read<ShowimageCubit>()
                                    .changeIcon(
                                        Icons.search, myField!, searchInput));
                              }
                            },
                            child: myIcon,
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  transactionList.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 60.0),
                            child: Text(
                              'No Transactions Found 🙂',
                              style: customTextStyleOne(
                                  fontSize: 18, color: firstGrey),
                            ),
                          ),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2.8.h,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.w,
                            crossAxisSpacing: 10.w,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (ctx) => transactionList[index].amount > 0
                                      ? IncomeDisplay(
                                          category: transactionList[index]
                                              .categoryName,
                                          index: transactionList[index].key,
                                          incomeAmount:
                                              transactionList[index].amount,
                                          nameofCatagory: transactionList[index]
                                              .categoryCat,
                                          dateofIncome: transactionList[index]
                                              .dateofTransaction,
                                          notesaboutIncome:
                                              transactionList[index].notes)
                                      : ExpenseDisplay(
                                          category: transactionList[index]
                                              .categoryName,
                                          index: transactionList[index].key,
                                          dateofExpense: transactionList[index]
                                              .dateofTransaction,
                                          expenseAmount:
                                              transactionList[index].amount,
                                          nameofCatagory: transactionList[index]
                                              .categoryCat,
                                          notesaboutExpense:
                                              transactionList[index].notes)),
                              child: CustomGridContainer(
                                  imagePath: transactionList[index].amount >= 0
                                      ? 'images/incomeGreen.jpg'
                                      : 'images/expenseBlue.jpg',
                                  amount: transactionList[index].amount >= 0
                                      ? transactionList[index].amount
                                      : -transactionList[index].amount,
                                  categoryName: transactionList[index].amount >=
                                          0
                                      ? transactionList[index].categoryName
                                      : transactionList[index].categoryName),
                            );
                          },
                          itemCount: transactionList.length,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
