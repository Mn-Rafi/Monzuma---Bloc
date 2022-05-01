import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const headingFont = 'ReemKufi';
const subHeadingFont = 'RobotoCondensed';

SizedBox customSpaceOne = SizedBox(
  height: 5.w,
);

SizedBox customSpaceTwo = SizedBox(
  height: 20.w,
);

const incomeGreen = Colors.green;
const expenseBlue = Colors.redAccent;
const walletPink = Color.fromARGB(255, 246, 235, 209);
const walletDark = Color.fromARGB(255, 200, 193, 177);

const firstBlue = Color.fromARGB(255, 0, 8, 255);
const firstOrange = Color.fromARGB(255, 255, 77, 0);
const firstGrey = Color.fromARGB(255, 216, 216, 216);
const secondGrey = Color.fromARGB(255, 189, 189, 189);
const firstBlack = Color.fromARGB(255, 0, 0, 0);
const firstWhite = Color.fromARGB(255, 255, 255, 255);


TextStyle customTextStyleOne(
    {Color color = 
    const Color.fromARGB(255, 0, 0, 0), double? fontSize,}) {
  return TextStyle(
    fontFamily: headingFont,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle customTextStyleOneWithUnderLine(
    {Color color = const Color.fromARGB(255, 0, 0, 0), double? fontSize}) {
  return TextStyle(
    decoration: TextDecoration.underline,
    fontFamily: headingFont,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

Icon arrowForwardIcon = Icon(
  Icons.arrow_forward,
  size: 30.w,
  color: firstBlack,
);

BoxDecoration customBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: walletPink,
);

Text customHeading(String text) {
  return Text(
    text,
    style: customTextStyleOne(
      fontSize: 20.sp,
    ),
  );
}

List<String> listIncomeCategories = [
  'Salary',
  'Gift',
  'Voucher',
  'Interest',
  'Paycheck',
  'Bonus',
  'Other Income'
];

List<String> listExpenseCategories = [
  'Education',
  'Food',
  'Groceries',
  'Workout',
  'Transportation',
  'Other Expense'
];

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
