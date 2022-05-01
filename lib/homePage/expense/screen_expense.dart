import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/customs/custom_widgets.dart';
import 'package:money_manager_app/homePage/expense/expense_details.dart';
import 'package:money_manager_app/homePage/expense/expense_widgets.dart';
import 'package:money_manager_app/homePage/widgets/custom_widgets.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ScreenExpense extends StatefulWidget {
  const ScreenExpense({Key? key}) : super(key: key);

  @override
  State<ScreenExpense> createState() => _ScreenExpenseState();
}

class _ScreenExpenseState extends State<ScreenExpense> {
  String dropdownvalue = 'All';
  DateTime _selected = DateTime.now();
  DateTime _selectedYear = DateTime.now();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(hours: 24 * 3)),
      end: DateTime.now());

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15,
              )),
          elevation: 0,
          title: const Text(
            'Expense',
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
            valueListenable:
                Hive.box<Transactions>('transactions').listenable(),
            builder: (context, Box<Transactions> box, _) {
              List<Transactions> transactionList = dropdownvalue == items[0]
                  ? incomeorExpense(box.values.toList())[1]
                  : dropdownvalue == items[1]
                      ? monthWise(
                          incomeorExpense(box.values.toList())[1], _selected)
                      : dropdownvalue == items[2]
                          ? yearWise(incomeorExpense(box.values.toList())[1],
                              _selectedYear)
                          : periodWise(incomeorExpense(box.values.toList())[1],
                              dateRange);

              double getTotalExpense() {
                double totalAmount = 0;
                for (int i = 0; i < transactionList.length; i++) {
                  totalAmount += transactionList[i].amount;
                }
                return totalAmount;
              }

              transactionList.sort((first, second) =>
                  second.dateofTransaction.compareTo(first.dateofTransaction));

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton(
                            value: dropdownvalue,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? firstWhite
                                      : firstBlack,
                            ),
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
                                                          DateTime.now()
                                                              .month)) {
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
                                                    color: MediaQuery.of(
                                                                    context)
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "Select Year",
                                                        style:
                                                            customTextStyleOne(),
                                                      ),
                                                      content: SizedBox(
                                                        width: 300.w,
                                                        height: 300.h,
                                                        child: YearPicker(
                                                          firstDate: DateTime(
                                                              DateTime.now()
                                                                      .year -
                                                                  10,
                                                              1),
                                                          lastDate:
                                                              DateTime.now(),
                                                          initialDate:
                                                              DateTime.now(),
                                                          selectedDate:
                                                              _selectedYear,
                                                          onChanged: (DateTime
                                                              dateTime) {
                                                            setState(() {
                                                              _selectedYear =
                                                                  dateTime;
                                                            });
                                                            Navigator.pop(
                                                                context);
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
                                                              DateTime.now()
                                                                  .year &&
                                                          _selectedYear.month <
                                                              DateTime.now()
                                                                  .month)) {
                                                    setState(() {
                                                      _selectedYear = DateTime(
                                                          _selectedYear.year +
                                                              1,
                                                          _selectedYear.month,
                                                          _selectedYear.day);
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 18.w,
                                                    color: MediaQuery.of(
                                                                    context)
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
                      SizedBox(
                        height: 20.h,
                      ),
                      transactionList.isEmpty
                          ? const CustomTotalExpenseContainer(
                              headText: 'Your total Expense',
                              lastExpenseAmount: 0,
                              totalExpenseAmount: 0,
                            )
                          : CustomTotalExpenseContainer(
                              headText: 'Your total Expense',
                              lastExpenseAmount: -(transactionList.last.amount),
                              totalExpenseAmount: -getTotalExpense(),
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Transactions',
                          style: customTextStyleOneWithUnderLine(
                              fontSize: 17,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? firstWhite
                                      : firstBlack)),
                      SizedBox(
                        height: 20.h,
                      ),
                      transactionList.isEmpty
                          ? Center(
                              child: Text(
                                'No Expense Transactions Found',
                                style: customTextStyleOne(
                                    fontSize: 18,
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack),
                              ),
                            )
                          : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  key: const ValueKey(0),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.transparent,
                                        onPressed: (ctx) {
                                          Future.delayed(
                                              const Duration(seconds: 0),
                                              () => showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                        title: Text(
                                                          'Your transaction details will be deleted permenently. Do you really want to continue?',
                                                          style:
                                                              customTextStyleOne(
                                                                  fontSize: 15),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Hive.box<Transactions>(
                                                                      'transactions')
                                                                  .delete(transactionList[
                                                                          index]
                                                                      .key);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Yes',
                                                              style:
                                                                  customTextStyleOne(),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'No',
                                                              style:
                                                                  customTextStyleOne(),
                                                            ),
                                                          )
                                                        ],
                                                      )));
                                        },
                                        foregroundColor: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                      SlidableAction(
                                        backgroundColor: Colors.transparent,
                                        onPressed: (ctx) {
                                          Future.delayed(
                                              const Duration(seconds: 0),
                                              () => showDialog(
                                                  context: context,
                                                  builder: (ctx) =>
                                                      CustomEditTransaction(
                                                        slide: true,
                                                        amount:
                                                            -transactionList[
                                                                    index]
                                                                .amount,
                                                        notes: transactionList[
                                                                index]
                                                            .notes,
                                                        dropdownValue:
                                                            transactionList[
                                                                    index]
                                                                .categoryCat,
                                                        dateOfTransaction:
                                                            transactionList[
                                                                    index]
                                                                .dateofTransaction,
                                                        dropInt: 1,
                                                        type: false,
                                                        addFunction:
                                                            const AddExpenseCategory(),
                                                        index: transactionList[
                                                                index]
                                                            .key,
                                                        listHint:
                                                            transactionList[
                                                                    index]
                                                                .categoryCat
                                                                .category,
                                                      )));
                                        },
                                        foregroundColor: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack,
                                        icon: Icons.edit,
                                        label: 'Edit',
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () => showDialog(
                                        context: context,
                                        builder: (ctx) => ExpenseDisplay(
                                              category: transactionList[index]
                                                  .categoryName,
                                              index: transactionList[index].key,
                                              dateofExpense:
                                                  transactionList[index]
                                                      .dateofTransaction,
                                              expenseAmount:
                                                  transactionList[index].amount,
                                              nameofCatagory:
                                                  transactionList[index]
                                                      .categoryCat,
                                              notesaboutExpense:
                                                  transactionList[index].notes,
                                            )),
                                    child: CustomExpenseContainer(
                                        expenseDate: transactionList[index]
                                            .dateofTransaction,
                                        totalExpenseAmount:
                                            transactionList[index].amount,
                                        headText: transactionList[index]
                                            .categoryName),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10.h,
                                  ),
                              itemCount: transactionList.length)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
