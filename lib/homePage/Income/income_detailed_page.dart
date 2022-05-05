import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Logic/Expense_bloc/expense_bloc.dart';
import 'package:money_manager_app/Logic/income_bloc/income_bloc.dart';
import 'package:money_manager_app/Logic/search/search_bloc.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/widgets/custom_widgets.dart';

class IncomeDisplay extends StatelessWidget {
  final Categories nameofCatagory;
  final String category;
  final double incomeAmount;
  final DateTime dateofIncome;
  final String notesaboutIncome;
  final int index;
  final String? searchInput;

  const IncomeDisplay({
    Key? key,
    required this.nameofCatagory,
    required this.category,
    required this.incomeAmount,
    required this.dateofIncome,
    required this.notesaboutIncome,
    required this.index,
    this.searchInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CloseButton(
                  color: firstBlack,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                PopupMenuButton(
                    icon:
                        const Icon(Icons.more_vert_rounded, color: firstBlack),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(
                                  const Duration(seconds: 0),
                                  () => showDialog(
                                      context: context,
                                      builder: (ctx) => CustomEditTransaction(
                                            searchInput: searchInput,
                                            listHint: nameofCatagory.category,
                                            notes: notesaboutIncome,
                                            amount: incomeAmount,
                                            dropdownValue: nameofCatagory,
                                            dateOfTransaction: dateofIncome,
                                            dropInt: 0,
                                            type: true,
                                            addFunction: const AddCategory(),
                                            index: index,
                                          )));
                            },
                            child: Text(
                              'Edit',
                              style: customTextStyleOne(),
                            ),
                          ),
                          PopupMenuItem(
                              onTap: () {
                                Future.delayed(
                                    const Duration(seconds: 0),
                                    () => showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: Text(
                                                'Your transaction details will be deleted permenently. Do you really want to continue?',
                                                style: customTextStyleOne(
                                                    fontSize: 15),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Hive.box<Transactions>(
                                                            'transactions')
                                                        .delete(index);
                                                    context
                                                        .read<SearchBloc>()
                                                        .add(EnterInput(
                                                            searchInput:
                                                                searchInput ??
                                                                    ''));

                                                    context
                                                        .read<IncomeBloc>()
                                                        .add(AllIncomeEvent());
                                                        context
                                                        .read<ExpenseBloc>()
                                                        .add(AllExpenseEvent());
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: customTextStyleOne(),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: customTextStyleOne(),
                                                  ),
                                                )
                                              ],
                                            )));
                              },
                              child: Text(
                                'Delete',
                                style: customTextStyleOne(),
                              )),
                        ]),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Income/$category',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              '₹$incomeAmount',
              style: customTextStyleOne(fontSize: 30.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Date',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              getText(),
              style: customTextStyleOne(fontSize: 23.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Notes',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              notesaboutIncome,
              style: customTextStyleOne(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }

  String getText() {
    return '${dateofIncome.day}-${dateofIncome.month}-${dateofIncome.year}';
  }
}
