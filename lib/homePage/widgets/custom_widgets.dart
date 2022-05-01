import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/Category%20page/screen_catogories.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomContainerForImage extends StatelessWidget {
  final String? imagePath;

  const CustomContainerForImage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 60.w,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: imagePath != null
            ? FileImage(File(imagePath!))
            : Image.asset(
                'images/userAlt.png',
              ).image,
      ),
    );
  }
}

class CustomContainerForCatogories extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String title;

  const CustomContainerForCatogories(
      {Key? key,
      required this.backgroundColor,
      required this.imagePath,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(imagePath)),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 8),
            child: DelayedWidget(
              delayDuration: const Duration(milliseconds: 300),
              animationDuration: const Duration(microseconds: 200),
              animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
              child: Text(
                title,
                style: customTextStyleOne(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomEditTransaction extends StatefulWidget {
  final bool? slide;
  final double amount;
  final String notes;
  final DateTime dateOfTransaction;
  final Categories dropdownValue;
  final int index;
  final int dropInt;
  final String listHint;
  final bool type;
  final Widget addFunction;
  const CustomEditTransaction({
    Key? key,
    this.slide,
    required this.amount,
    required this.notes,
    required this.dateOfTransaction,
    required this.dropdownValue,
    required this.index,
    required this.dropInt,
    required this.listHint,
    required this.type,
    required this.addFunction,
  }) : super(key: key);

  @override
  State<CustomEditTransaction> createState() => _CustomEditTransactionState();
}

class _CustomEditTransactionState extends State<CustomEditTransaction> {
  final Color bgColor = Colors.white;
  final formKey = GlobalKey<FormState>();
  Categories? dropdownvalue;
  DateTime date = DateTime.now();
  double? amount;
  String? notes;

  String getText() {
    return '${date.day}-${date.month}-${date.year}';
  }

  @override
  void initState() {
    notes = widget.notes == 'No notes found' ? '' : widget.notes;
    amount = widget.amount;
    date = widget.dateOfTransaction;
    dropdownvalue = widget.dropdownValue;
    notes = widget.notes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: firstBlack,
              size: 15,
            )),
        foregroundColor: firstBlack,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Transaction',
          style: customTextStyleOne(fontSize: 20.w),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 30.w,
              ),
              Row(
                children: [
                  Text(
                    'Select category',
                    style: customTextStyleOne(fontSize: 18.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<Categories>('categories').listenable(),
                        builder: (context, Box<Categories> box, _) {
                          return DropdownButton<dynamic>(
                            style: customTextStyleOne(),
                            underline: const SizedBox(),
                            hint: Text(
                              widget.listHint,
                              style: customTextStyleOne(color: firstGrey),
                            ),
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                                type(box.values.toList())[widget.dropInt].map(
                              (Categories e) {
                                return DropdownMenuItem(
                                  child: Text(e.category),
                                  value: e,
                                  onTap: () {
                                    dropdownvalue = e;
                                  },
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownvalue = value;
                              });
                            },
                          );
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'or ',
                    style: customTextStyleOne(fontSize: 20.sp),
                  ),
                  TextButton.icon(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0))),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => widget.addFunction),
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.red,
                      ),
                      label: Text(
                        'add new category',
                        style: customTextStyleOne(
                            color: Colors.red, fontSize: 17.sp),
                      )),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 160.w,
                      child: CustomTextFieldFour(
                        initialValue: amount!,
                        onChanged: ((value) {
                          setState(() {
                            amount = double.parse(value);
                          });
                        }),
                        prefixIcon: const Icon(Icons.currency_rupee),
                        labelText: 'Amount',
                      )),
                  SizedBox(
                    width: 160.w,
                    child: CustomTextFieldForDate(
                      onTap: () {
                        pickdate(context);
                      },
                      prefixIcon: const Icon(Icons.calendar_month),
                      hint: getText(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                children: [
                  Text(
                    'Add Notes',
                    style: customTextStyleOne(fontSize: 18.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              TextFormField(
                style: customTextStyleOne(),
                initialValue: notes,
                onChanged: ((value) {
                  setState(() {
                    notes = value;
                  });
                }),
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              CustomOutlinedButton(onPressed: () {
                final isValidForm = formKey.currentState!.validate();
                if (isValidForm && dropdownvalue != null) {
                  Hive.box<Transactions>('transactions').put(
                      widget.index,
                      Transactions(
                          categoryName: dropdownvalue!.category,
                          amount: widget.type == true ? amount! : -amount!,
                          dateofTransaction: date,
                          notes: notes ?? 'No notes found',
                          categoryCat: dropdownvalue!,
                          type: widget.type));
                  if (widget.slide == null) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                }
              }),
            ],
          )),
        ),
      ),
    );
  }

  Future pickdate(BuildContext context) async {
    final initialDate = date;
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (newDate == null) {
      return;
    } else {
      setState(() {
        date = newDate;
      });
    }
  }
}
