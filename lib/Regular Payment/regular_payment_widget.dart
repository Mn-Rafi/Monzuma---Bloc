import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Notification/notifications.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class RegularPaymentAdd extends StatefulWidget {
  final String intialName;
  const RegularPaymentAdd({
    Key? key,
    this.intialName = '',
  }) : super(key: key);

  @override
  State<RegularPaymentAdd> createState() => _RegularPaymentAddState();
}

class _RegularPaymentAddState extends State<RegularPaymentAdd> {
  String? name;
  DateTime date = DateTime.now();
  final formKey = GlobalKey<FormState>();

  late Box<RegularPayments> regHive;
  @override
  void initState() {
    regHive = Hive.box<RegularPayments>('regularPayments');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                style: customTextStyleOne(),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value!.trim() == '' || value.length < 3) {
                    return 'Enter a valid title';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                maxLength: 50,
                keyboardType: TextInputType.name,
                cursorWidth: 1,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? firstGrey
                      : firstWhite,
                  prefixIcon: const Icon(Icons.title),
                  labelText: 'Enter title',
                  labelStyle: customTextStyleOne(
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? firstWhite
                          : firstBlack),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFieldForDate(
                onTap: () {
                  pickdate(context);
                },
                prefixIcon: const Icon(Icons.calendar_month),
                hint: getText(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        regHive.add(
                          RegularPayments(
                            title: name!,
                            upcomingDate: date,
                          ),
                        );
                        scheduledNotification(date.day, name,
                            date.microsecond + date.hour + date.minute);
                        scheduledNotificationRepeat(date.day, name,
                            date.microsecond + date.hour + date.minute + 1);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickdate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 31)),
    );

    if (newDate == null) {
      return;
    } else {
      setState(() {
        date = newDate;
      });
    }
  }

  String getText() {
    return '${date.day}-${date.month}-${date.year}';
  }
}

class RegularPaymentEdit extends StatefulWidget {
  final String intialName;
  final DateTime initialdate;
  final int index;
  const RegularPaymentEdit({
    Key? key,
    required this.intialName,
    required this.initialdate,
    required this.index,
  }) : super(key: key);

  @override
  State<RegularPaymentEdit> createState() => _RegularPaymentEditState();
}

class _RegularPaymentEditState extends State<RegularPaymentEdit> {
  String? name;
  DateTime date = DateTime.now();
  final formKey = GlobalKey<FormState>();

  late Box<RegularPayments> regHive;
  @override
  void initState() {
    name = widget.intialName;
    date = widget.initialdate;
    regHive = Hive.box<RegularPayments>('regularPayments');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: widget.intialName,
                validator: (value) {
                  if (value!.trim() == '' || value.length < 3) {
                    return 'Enter a valid title';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                style: customTextStyleOne(),
                maxLength: 30,
                keyboardType: TextInputType.name,
                cursorWidth: 1,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.title),
                  labelText: 'Enter title',
                  labelStyle: customTextStyleOne(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              CustomTextFieldForDate(
                onTap: () {
                  pickdate(context);
                },
                prefixIcon: const Icon(Icons.calendar_month),
                hint: getText(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        regHive.putAt(
                          widget.index,
                          RegularPayments(
                            title: name!,
                            upcomingDate: date,
                          ),
                        );
                        cancelScheduledNotificationsOne(
                            widget.initialdate.microsecond +
                                widget.initialdate.hour +
                                widget.initialdate.minute);
                        cancelScheduledNotificationsOne(
                            widget.initialdate.microsecond +
                                widget.initialdate.hour +
                                widget.initialdate.minute +
                                1);
                        scheduledNotification(date.day, name,
                            date.microsecond + date.hour + date.minute);
                        Navigator.pop(context);
                        scheduledNotificationRepeat(date.day, name,
                            date.microsecond + date.hour + date.minute + 1);
                      }
                    },
                  ),
                ],
              )
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
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 31)),
    );

    if (newDate == null) {
      return;
    } else {
      setState(() {
        date = newDate;
      });
    }
  }

  String getText() {
    return '${date.day}-${date.month}-${date.year}';
  }
}
