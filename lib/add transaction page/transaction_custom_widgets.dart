import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/Category%20page/screen_catogories.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomAddCatogoryIncome extends StatefulWidget {
  final Widget addFunction;
  final int index;
  final String listHint;
  final bool type;
  const CustomAddCatogoryIncome({
    Key? key,
    required this.addFunction,
    required this.index,
    required this.listHint,
    required this.type,
  }) : super(key: key);

  @override
  State<CustomAddCatogoryIncome> createState() =>
      _CustomAddCatogoryIncomeState();
}

class _CustomAddCatogoryIncomeState extends State<CustomAddCatogoryIncome> {
  final formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  Categories? dropdownvalue;
  double? amount;
  String notes = 'No notes found';

  @override
  Widget build(BuildContext context) {
    String getText() {
      return '${date.day}-${date.month}-${date.year}';
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select category',
                style: customTextStyleOne(
                    fontSize: 18.sp,
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? firstWhite
                        : firstBlack),
              ),
              SizedBox(
                height: 10.w,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? firstGrey
                        : firstWhite,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Categories>('categories').listenable(),
                    builder: (context, Box<Categories> box, _) {
                      return DropdownButton<dynamic>(
                        style: customTextStyleOne(),
                        underline: const SizedBox(),
                        hint: Text(
                          widget.listHint,
                          style: customTextStyleOne(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? firstWhite
                                      : firstGrey),
                        ),
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: type(box.values.toList())[widget.index].map(
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
              Row(
                children: [
                  Text(
                    'or ',
                    style: customTextStyleOne(
                        fontSize: 20.sp,
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? firstWhite
                            : firstBlack),
                  ),
                  TextButton.icon(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 160.w,
                      child: CustomTextFieldFour(
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
              Text(
                'Add Notes',
                style: customTextStyleOne(
                    fontSize: 18.sp,
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? firstWhite
                        : firstBlack),
              ),
              SizedBox(
                height: 10.w,
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                style: customTextStyleOne(),
                onChanged: ((value) {
                  setState(() {
                    notes = value;
                  });
                }),
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? firstGrey
                      : firstWhite,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(onPressed: () {
                    final isValidForm = formKey.currentState!.validate();
                    if (isValidForm && dropdownvalue != null) {
                      Hive.box<Transactions>('transactions').add(Transactions(
                          categoryCat: dropdownvalue!,
                          categoryName: dropdownvalue!.category,
                          amount: widget.type == true ? amount! : -amount!,
                          dateofTransaction: date,
                          notes: notes,
                          type: widget.type));

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const ScreenHome()),
                          (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(snackBarOne);
                    }
                  }),
                ],
              ),
              SizedBox(
                height: 70.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickdate(BuildContext context) async {
    final initialDate = DateTime.now();
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

final snackBarOne = SnackBar(
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
        'Transaction added successfully',
        textAlign: TextAlign.center,
        style: customTextStyleOne(color: firstBlack),
      ),
    ),
  ),
  backgroundColor: Colors.transparent,
  elevation: 10000,
  behavior: SnackBarBehavior.floating,
);
