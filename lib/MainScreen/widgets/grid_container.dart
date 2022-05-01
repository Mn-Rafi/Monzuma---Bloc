import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomGridContainer extends StatefulWidget {
  final String categoryName;
  final double amount;
  final String imagePath;
  const CustomGridContainer({
    Key? key,
    required this.categoryName,
    required this.amount,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<CustomGridContainer> createState() => _CustomGridContainerState();
}

class _CustomGridContainerState extends State<CustomGridContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: firstGrey,
        ),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Container(
              width: 37.h,
              height: 37.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                image: DecorationImage(
                  image: AssetImage(
                    widget.imagePath,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    widget.categoryName,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyleOne(
                      color: secondGrey,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(
                    width: 100.w,
                    child: Text(
                      '₹'+widget.amount.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyleOne(fontSize: 18.sp, color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack,),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<String> listohCatoDemo = [
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
      'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
      'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
      'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
      'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
      'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
      'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
];
