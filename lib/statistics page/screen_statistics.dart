import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/customs/custom_widgets.dart';
import 'package:money_manager_app/homePage/Income/widgets%20and%20lists/widgets_lists.dart';
import 'package:money_manager_app/statistics%20page/custom_wallet_container.dart';
import 'package:money_manager_app/statistics%20page/widgets_and_classes.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class ScreenStatistics extends StatefulWidget {
  const ScreenStatistics({Key? key}) : super(key: key);

  @override
  State<ScreenStatistics> createState() => _ScreenStatisticsState();
}

class _ScreenStatisticsState extends State<ScreenStatistics>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TooltipBehavior _tooltipBehavior;
  String dropdownvalue = 'All';
  double childSize = 0.3;
  DateTime _selected = DateTime.now();
  DateTime _selectedYear = DateTime.now();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(hours: 24 * 3)),
      end: DateTime.now());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  Future pickDate(
    BuildContext context,
  ) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }

  pickDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime.now());
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
    });
  }

  List<IncomeData>? getIncomeDate() {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();

    final List<IncomeData> chartIncomeData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == true) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if (transactions[j].categoryName == categories[i].category) {
            totalAmount += transactions[j].amount;
          }
        }
        chartIncomeData.add(IncomeData(categories[i].category, totalAmount));
      }
    }
    return chartIncomeData;
  }

  List<ExpenseData>? getExpenseDate() {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();

    final List<ExpenseData> chartExpenseData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == false) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if (transactions[j].categoryName == categories[i].category) {
            totalAmount += transactions[j].amount;
          }
        }
        chartExpenseData.add(ExpenseData(categories[i].category, -totalAmount));
      }
    }
    return chartExpenseData;
  }

  List<IncomeData>? getIncomeDateMonth(DateTime month) {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();

    final List<IncomeData> chartIncomeData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == true) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if (transactions[j].dateofTransaction.month == month.month &&
              transactions[j].dateofTransaction.year == month.year) {
            if (transactions[j].categoryName == categories[i].category) {
              totalAmount += transactions[j].amount;
            }
          }
        }
        chartIncomeData.add(IncomeData(categories[i].category, totalAmount));
      }
    }
    return chartIncomeData;
  }

  List<ExpenseData>? getExpenseDateMonth(DateTime month) {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();

    final List<ExpenseData> chartExpenseData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == false) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if (transactions[j].dateofTransaction.month == month.month &&
              transactions[j].dateofTransaction.year == month.year) {
            if (transactions[j].categoryName == categories[i].category) {
              totalAmount += transactions[j].amount;
            }
          }
        }
        chartExpenseData.add(ExpenseData(categories[i].category, -totalAmount));
      }
    }
    return chartExpenseData;
  }

  List<IncomeData>? getIncomeDateYear(DateTime year) {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();

    final List<IncomeData> chartIncomeData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == true) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if (transactions[j].dateofTransaction.year == year.year) {
            if (transactions[j].categoryName == categories[i].category) {
              totalAmount += transactions[j].amount;
            }
          }
        }
        chartIncomeData.add(IncomeData(categories[i].category, totalAmount));
      }
    }
    return chartIncomeData;
  }

  List<ExpenseData>? getExpenseDateYear(DateTime year) {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();

    final List<ExpenseData> chartExpenseData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == false) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if (transactions[j].dateofTransaction.year == year.year) {
            if (transactions[j].categoryName == categories[i].category) {
              totalAmount += transactions[j].amount;
            }
          }
        }
        chartExpenseData.add(ExpenseData(categories[i].category, -totalAmount));
      }
    }
    return chartExpenseData;
  }

  List<IncomeData> periodWiseList(DateTimeRange period) {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();
    final List<IncomeData> chartIncomeData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == true) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if ((transactions[j].dateofTransaction == period.start ||
                  transactions[j].dateofTransaction.isAfter(period.start)) &&
              (transactions[j].dateofTransaction == period.end ||
                  transactions[j].dateofTransaction.isBefore(period.end))) {
            if (transactions[j].categoryName == categories[i].category) {
              totalAmount += transactions[j].amount;
            }
          }
        }
        chartIncomeData.add(IncomeData(categories[i].category, totalAmount));
      }
    }
    return chartIncomeData;
  }

  List<ExpenseData> periodWiseListExpense(DateTimeRange period) {
    List<Transactions> transactions =
        Hive.box<Transactions>('transactions').values.toList();
    List<Categories> categories =
        Hive.box<Categories>('categories').values.toList();
    final List<ExpenseData> chartExpenseData = [];

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].type == false) {
        double totalAmount = 0;
        for (int j = 0; j < transactions.length; j++) {
          if ((transactions[j].dateofTransaction == period.start ||
                  transactions[j].dateofTransaction.isAfter(period.start)) &&
              (transactions[j].dateofTransaction == period.end ||
                  transactions[j].dateofTransaction.isBefore(period.end))) {
            if (transactions[j].categoryName == categories[i].category) {
              totalAmount += transactions[j].amount;
            }
          }
        }
        chartExpenseData.add(ExpenseData(categories[i].category, totalAmount));
      }
    }
    return chartExpenseData;
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    List<Transactions> transactionList =
        Hive.box<Transactions>('transactions').values.toList();
    bool isCategoryEmpty(bool val) {
      int count = 0;
      for (int i = 0; i < transactionList.length; i++) {
        if (transactionList[i].type == val) {
          count++;
        }
      }
      if (count > 0) {
        return true;
      } else {
        return false;
      }
    }

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
            'Statistics',
          ),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                TabBar(
                  labelStyle: customTextStyleOne(),
                  labelColor: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? firstWhite
                      : firstBlack,
                  unselectedLabelColor:
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: customTextStyleOne(
                                      color: MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                          ? secondGrey
                                          : firstBlack),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      dropdownvalue == items[0]
                          ? const SizedBox()
                          : dropdownvalue == items[1]
                              ? Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _selected = DateTime(
                                                _selected.year,
                                                _selected.month - 1,
                                                _selected.day);
                                          });
                                        },
                                        icon: Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 18.w,
                                            color: MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.dark
                                                ? firstWhite
                                                : firstBlack)),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pickDate(context);
                                      },
                                      child: Text(
                                        DateFormat.yMMM('en_US')
                                            .format(_selected),
                                        style: customTextStyleOne(
                                            color: const Color.fromARGB(
                                                255, 255, 0, 0),
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          if (_selected.year <
                                                  DateTime.now().year ||
                                              (_selected.year ==
                                                      DateTime.now().year &&
                                                  _selected.month <
                                                      DateTime.now().month)) {
                                            setState(() {
                                              _selected = DateTime(
                                                  _selected.year,
                                                  _selected.month + 1,
                                                  _selected.day);
                                            });
                                          }
                                        },
                                        icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 18.w,
                                            color: MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.dark
                                                ? firstWhite
                                                : firstBlack)),
                                  ],
                                )
                              : dropdownvalue == items[2]
                                  ? Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _selectedYear = DateTime(
                                                    _selectedYear.year - 1,
                                                    _selectedYear.month,
                                                    _selectedYear.day);
                                              });
                                            },
                                            icon: Icon(
                                                Icons
                                                    .arrow_back_ios_new_rounded,
                                                size: 18.w,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.dark
                                                    ? firstWhite
                                                    : firstBlack)),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Select Year",
                                                    style: customTextStyleOne(),
                                                  ),
                                                  content: SizedBox(
                                                    width: 300.w,
                                                    height: 300.h,
                                                    child: YearPicker(
                                                      firstDate: DateTime(
                                                          DateTime.now().year -
                                                              10,
                                                          1),
                                                      lastDate: DateTime.now(),
                                                      initialDate:
                                                          DateTime.now(),
                                                      selectedDate:
                                                          _selectedYear,
                                                      onChanged:
                                                          (DateTime dateTime) {
                                                        setState(() {
                                                          _selectedYear =
                                                              dateTime;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            DateFormat.y('en_US')
                                                .format(_selectedYear),
                                            style: customTextStyleOne(
                                                color: const Color.fromARGB(
                                                    255, 255, 0, 0),
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (_selectedYear.year <
                                                      DateTime.now().year ||
                                                  (_selectedYear.year ==
                                                          DateTime.now().year &&
                                                      _selectedYear.month <
                                                          DateTime.now()
                                                              .month)) {
                                                setState(() {
                                                  _selectedYear = DateTime(
                                                      _selectedYear.year + 1,
                                                      _selectedYear.month,
                                                      _selectedYear.day);
                                                });
                                              }
                                            },
                                            icon: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18.w,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.dark
                                                    ? firstWhite
                                                    : firstBlack)),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              pickDateRange(context),
                                          child: Text(
                                            DateFormat.yMMMd('en_US')
                                                .format(dateRange.start),
                                            style: customTextStyleOne(
                                                color: const Color.fromARGB(
                                                    255, 255, 0, 0),
                                                fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          ' to ',
                                          style: customTextStyleOne(
                                              color: MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.dark
                                                  ? firstWhite
                                                  : firstBlack,
                                              fontSize: 14),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              pickDateRange(context),
                                          child: Text(
                                            DateFormat.yMMMd('en_US')
                                                .format(dateRange.end),
                                            style: customTextStyleOne(
                                                color: const Color.fromARGB(
                                                    255, 255, 0, 0),
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    )
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    ValueListenableBuilder(
                        valueListenable:
                            Hive.box<Transactions>('transactions').listenable(),
                        builder: (context, Box<Transactions> box, _) {
                          List<Transactions> transactionList = dropdownvalue ==
                                  items[0]
                              ? incomeorExpense(box.values.toList())[0]
                              : dropdownvalue == items[1]
                                  ? monthWise(
                                      incomeorExpense(box.values.toList())[0],
                                      _selected)
                                  : dropdownvalue == items[2]
                                      ? yearWise(
                                          incomeorExpense(
                                              box.values.toList())[0],
                                          _selectedYear)
                                      : periodWise(
                                          incomeorExpense(
                                              box.values.toList())[0],
                                          dateRange);
                          return transactionList.isEmpty ||
                                  !isCategoryEmpty(true)
                              ? Center(
                                  child: Text(
                                    'No Income Transactions Found',
                                    style: customTextStyleOne(
                                        color: MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.dark
                                            ? firstWhite
                                            : firstBlack),
                                  ),
                                )
                              : SfCircularChart(
                                  legend: Legend(
                                      textStyle: customTextStyleOne(color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack,),
                                      isVisible: true,
                                      overflowMode:
                                          LegendItemOverflowMode.scroll),
                                  tooltipBehavior: _tooltipBehavior,
                                  series: <CircularSeries>[
                                      PieSeries<IncomeData, String>(
                                        explode: true,
                                        dataSource: dropdownvalue == items[0]
                                            ? getIncomeDate()
                                            : dropdownvalue == items[1]
                                                ? getIncomeDateMonth(_selected)
                                                : dropdownvalue == items[2]
                                                    ? getIncomeDateYear(
                                                        _selectedYear)
                                                    : periodWiseList(dateRange),
                                        xValueMapper: (IncomeData data, _) =>
                                            data.catogory,
                                        yValueMapper: (IncomeData data, _) =>
                                            data.amount,
                                        dataLabelSettings: DataLabelSettings(
                                            textStyle: customTextStyleOne(color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack,),
                                            showZeroValue: false,
                                            isVisible: true,
                                            labelPosition:
                                                ChartDataLabelPosition.outside),
                                        enableTooltip: true,
                                      )
                                    ]);
                        }),
                    ValueListenableBuilder(
                        valueListenable:
                            Hive.box<Transactions>('transactions').listenable(),
                        builder: (context, Box<Transactions> box, _) {
                          List<Transactions> transactionList = dropdownvalue ==
                                  items[0]
                              ? incomeorExpense(box.values.toList())[1]
                              : dropdownvalue == items[1]
                                  ? monthWise(
                                      incomeorExpense(box.values.toList())[1],
                                      _selected)
                                  : dropdownvalue == items[2]
                                      ? yearWise(
                                          incomeorExpense(
                                              box.values.toList())[1],
                                          _selectedYear)
                                      : periodWise(
                                          incomeorExpense(
                                              box.values.toList())[1],
                                          dateRange);
                          return transactionList.isEmpty ||
                                  !isCategoryEmpty(false)
                              ? Center(
                                  child: Text(
                                    'No Expense Transactions Found',
                                    style: customTextStyleOne(
                                        color: MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.dark
                                            ? firstWhite
                                            : firstBlack),
                                  ),
                                )
                              : SfCircularChart(
                                  legend: Legend(
                                      textStyle: customTextStyleOne(color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack,),
                                      isVisible: true,
                                      overflowMode:
                                          LegendItemOverflowMode.scroll),
                                  tooltipBehavior: _tooltipBehavior,
                                  series: <CircularSeries>[
                                      PieSeries<ExpenseData, String>(
                                        explode: true,
                                        dataSource: dropdownvalue == items[0]
                                            ? getExpenseDate()
                                            : dropdownvalue == items[1]
                                                ? getExpenseDateMonth(_selected)
                                                : dropdownvalue == items[2]
                                                    ? getExpenseDateYear(
                                                        _selectedYear)
                                                    : periodWiseListExpense(
                                                        dateRange),
                                        xValueMapper: (ExpenseData data, _) =>
                                            data.catogory,
                                        yValueMapper: (ExpenseData data, _) =>
                                            data.amount,
                                        dataLabelSettings: DataLabelSettings(
                                            textStyle: customTextStyleOne(color : MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack,),
                                            showZeroValue: false,
                                            isVisible: true,
                                            labelPosition:
                                                ChartDataLabelPosition.outside),
                                        enableTooltip: true,
                                      )
                                    ]);
                        }),
                  ]),
                ),
                SizedBox(
                  height: 230.h,
                )
              ],
            ),
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<ProfileDetails>('profiledetails').listenable(),
                builder: (context, Box<ProfileDetails> box, widget) {
                  List<ProfileDetails> profileDetails = box.values.toList();

                  return DraggableScrollableSheet(
                      initialChildSize: childSize,
                      maxChildSize: 0.8,
                      minChildSize: 0.2,
                      builder: (context, controller) => CustomWalletContainer(
                            initialWallletAmount: double.parse(
                                profileDetails[0].initialWalletBalance),
                            controller: controller,
                          ));
                })
          ],
        ),
      ),
    );
  }
}
