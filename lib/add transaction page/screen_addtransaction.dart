import 'package:flutter/material.dart';
import 'package:money_manager_app/add%20transaction%20page/transaction_custom_widgets.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Add Transaction',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              labelStyle: customTextStyleOne(),
              labelColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? firstWhite
                      : firstBlack,
              unselectedLabelColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? firstGrey.withOpacity(0.4)
                      : firstGrey,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSE',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                CustomAddCatogoryIncome(
                    type: true,
                    addFunction: AddCategory(),
                    index: 0,
                    listHint: 'Income categories'),
                CustomAddCatogoryIncome(
                    type: false,
                    addFunction: AddExpenseCategory(),
                    index: 1,
                    listHint: 'Expense categories'),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
