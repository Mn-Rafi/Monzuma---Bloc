import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

var items = [
  'All',
  'Monthly',
  'Yearly',
  'Period',
];

Icon arrowNext = Icon(
  Icons.arrow_forward_ios_rounded,
  size: 18.w,
  color: firstBlack,
);
Icon arrowPrev =
    Icon(Icons.arrow_back_ios_new_rounded, size: 18.w, color: firstBlack);

class CustomTotalExpenseContainer extends StatelessWidget {
  final String headText;
  final double totalExpenseAmount;
  final double lastExpenseAmount;

  const CustomTotalExpenseContainer({
    Key? key,
    required this.headText,
    required this.totalExpenseAmount,
    required this.lastExpenseAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'expenseHero',
      child: Container(
        decoration: BoxDecoration(
          color: expenseBlue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              DelayedWidget(
                delayDuration: const Duration(milliseconds: 300),
                animationDuration: const Duration(milliseconds: 200),
                animation: DelayedAnimations.SLIDE_FROM_TOP,
                child: Text(
                  headText,
                  style: customTextStyleOne(color: Colors.white, fontSize: 15),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  DelayedWidget(
                    delayDuration: const Duration(milliseconds: 300),
                    animationDuration: const Duration(milliseconds: 200),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Text(
                      '₹$totalExpenseAmount',
                      style:
                          customTextStyleOne(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  DelayedWidget(
                    delayDuration: const Duration(milliseconds: 300),
                    animationDuration: const Duration(milliseconds: 200),
                    animation: DelayedAnimations.SLIDE_FROM_RIGHT,
                    child: Text(
                      '+₹$lastExpenseAmount',
                      style:
                          customTextStyleOne(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomExpenseContainer extends StatelessWidget {
  final String headText;
  final double totalExpenseAmount;
  final DateTime expenseDate;

  const CustomExpenseContainer({
    Key? key,
    required this.headText,
    required this.totalExpenseAmount,
    required this.expenseDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: expenseBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headText,
              style: customTextStyleOne(color: Colors.white, fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${-totalExpenseAmount}',
                  style: customTextStyleOne(fontSize: 25, color: Colors.white),
                ),
                Text(
                  getText(),
                  style: customTextStyleOne(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getText() {
    return '${expenseDate.day}-${expenseDate.month}-${expenseDate.year}';
  }
}

