import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Notification/notifications.dart';
import 'package:money_manager_app/Regular%20Payment/regular_payment_widget.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:marquee/marquee.dart';

class RegularPayment extends StatefulWidget {
  const RegularPayment({Key? key}) : super(key: key);

  @override
  State<RegularPayment> createState() => _RegularPaymentState();
}

class _RegularPaymentState extends State<RegularPayment> {
  String getText(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  late Box<RegularPayments> regHive;
  @override
  void initState() {
    regHive = Hive.box<RegularPayments>('regularPayments');
    super.initState();
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Regular Payments',
            ),
            centerTitle: true,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 20.h,
                child: Marquee(
                  fadingEdgeEndFraction: 0.1.w,
                  fadingEdgeStartFraction: 0.1.w,
                  startPadding: 20.w,
                  startAfter: const Duration(milliseconds: 3000),
                  pauseAfterRound: const Duration(milliseconds: 2000),
                  blankSpace: 50.w,
                  text:
                      'Add your regular payment details here. You will be notified on time 🤩‼️',
                  style: customTextStyleOne(
                      fontSize: 16,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? firstOrange
                          : firstBlue),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ValueListenableBuilder(
                  valueListenable: regHive.listenable(),
                  builder: (context, Box<RegularPayments> box, _) {
                    List<RegularPayments> regListOne = regHive.values.toList();
                    regListOne.sort((first, second) {
                      return second.upcomingDate.compareTo(first.upcomingDate);
                    });
                    List<RegularPayments> regList = regListOne;
                    return regHive.isEmpty
                        ? Center(
                            child: Text(
                            'No Regular Payments Found',
                            style: customTextStyleOne(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack),
                          ))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            reverse: true,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        width: 0.5, color: Colors.black),
                                  ),
                                  tileColor:
                                      const Color.fromARGB(255, 243, 242, 242),
                                  title: Text(
                                    getText(regList[index].upcomingDate),
                                    style: customTextStyleOne(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    regList[index].title,
                                    style: customTextStyleOne(),
                                  ),
                                  trailing: PopupMenuButton(
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              onTap: () {
                                                Future.delayed(
                                                    const Duration(seconds: 0),
                                                    () => showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            RegularPaymentEdit(
                                                              index: index,
                                                              initialdate: regList[
                                                                      index]
                                                                  .upcomingDate,
                                                              intialName:
                                                                  regList[index]
                                                                      .title,
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
                                                      const Duration(
                                                          seconds: 0),
                                                      () => showDialog(
                                                          context: context,
                                                          builder:
                                                              (ctx) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                      'Notification for this payment will not be available. Continue?',
                                                                      style: customTextStyleOne(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          regList[index]
                                                                              .delete();
                                                                          Navigator.pop(
                                                                              context);
                                                                          cancelScheduledNotificationsOne(regList[index].upcomingDate.minute +
                                                                              regList[index].upcomingDate.hour +
                                                                              regList[index].upcomingDate.microsecond);
                                                                          cancelScheduledNotificationsOne(regList[index].upcomingDate.minute +
                                                                              regList[index].upcomingDate.hour +
                                                                              regList[index].upcomingDate.microsecond +
                                                                              1);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Yes',
                                                                          style:
                                                                              customTextStyleOne(),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'No',
                                                                          style:
                                                                              customTextStyleOne(),
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
                                ),
                              );
                            }),
                            itemCount: regList.length,
                          );
                  }),
              SizedBox(
                height: 150.h,
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 70.w),
            child: FloatingActionButton.extended(
              backgroundColor: walletPink,
              foregroundColor: firstBlack,
              elevation: 2,
              label: Row(
                children: [
                  Text(
                    'Add New  ',
                    style: customTextStyleOne(),
                  ),
                  const Icon(
                    FontAwesomeIcons.calendarPlus,
                    size: 18,
                  ),
                ],
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (ctx) => const RegularPaymentAdd()),
            ),
          ),
        ));
  }
}
