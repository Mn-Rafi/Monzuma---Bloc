import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';

// ignore: must_be_immutable
class CustomTextFieldOne extends StatelessWidget {
  String? labelText;
  Icon prefixIcon;

  CustomTextFieldOne({
    Key? key,
    this.labelText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: customTextStyleOne(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddImageContainer extends StatelessWidget {
  Function onTapFunction;
  AddImageContainer({Key? key, required this.onTapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: customBoxDecoration,
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}

class AddImageContainerOne extends StatelessWidget {
  final String? imagePath;
  const AddImageContainerOne({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imagePath != null
        ? CircleAvatar(
            radius: 70.r,
            backgroundImage: FileImage(
              File(
                imagePath!,
              ),
            ),
          )
        : CircleAvatar(
          backgroundColor: walletPink,
            radius: 70.r,
            child: const Icon(
              Icons.add,
              size: 70,
            ),
          );
  }
}

List<Transactions> monthWise(List<Transactions> list, DateTime month) {
  List<Transactions> transac = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i].dateofTransaction.month == month.month &&
        list[i].dateofTransaction.year == month.year) {
      transac.add(list[i]);
    }
  }

  return transac;
}

List<Transactions> monthWiseCat(List<Transactions> list, DateTime month) {
  List<Transactions> transac = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i].dateofTransaction.month == month.month) {
      transac.add(list[i]);
    }
  }

  return transac;
}

List<Transactions> yearWise(List<Transactions> list, DateTime year) {
  List<Transactions> transac = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i].dateofTransaction.year == year.year) {
      transac.add(list[i]);
    }
  }

  return transac;
}

List<Transactions> periodWise(List<Transactions> list, DateTimeRange period) {
  List<Transactions> transac = [];

  for (int i = 0; i < list.length; i++) {
    if ((list[i].dateofTransaction == period.start ||
            list[i].dateofTransaction.isAfter(period.start)) &&
        (list[i].dateofTransaction == period.end ||
            list[i].dateofTransaction.isBefore(period.end))) {
      transac.add(list[i]);
    }
  }

  return transac;
}
