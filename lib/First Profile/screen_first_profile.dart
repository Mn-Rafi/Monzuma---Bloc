import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Logic/cubit/showimage_cubit.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/Notification/notifications.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/customs/custom_widgets.dart';
import 'package:money_manager_app/customs/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final formKey = GlobalKey<FormState>();
  String? imagePath;

  String initialBalance = '0';
  String userName = '';

  chooseImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'crop',
          toolbarColor: Colors.grey,
          toolbarWidgetColor: Colors.white,
        ),
        iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0, aspectRatioLockEnabled: true),
      );
      if (croppedFile != null) {
        imagePath = context.read<ShowimageCubit>().imageAdd(croppedFile.path);
      }
    }
  }

  _storeOnboardingInfo() async {
    int isViewedFirstProfile = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onFirstProfile', isViewedFirstProfile);
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    systemUi(context);
    return SafeArea(
      child: WillPopScope(
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
              'Create Profile',
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TextButton.icon(
                                                    onPressed: () {
                                                      chooseImage(
                                                          ImageSource.camera);
                                                      Navigator.pop(ctx);
                                                    },
                                                    icon: const Icon(
                                                        Icons.camera),
                                                    label: Text(
                                                      'Take Photo',
                                                      style:
                                                          customTextStyleOne(),
                                                    )),
                                                TextButton.icon(
                                                    onPressed: () {
                                                      chooseImage(
                                                          ImageSource.gallery);
                                                      Navigator.pop(ctx);
                                                    },
                                                    icon: const Icon(
                                                        Icons.filter_sharp),
                                                    label: Text(
                                                      'Choose from device',
                                                      style:
                                                          customTextStyleOne(),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )),
                                child: BlocBuilder<ShowimageCubit, ShowimageState>(
                                  builder: (context, state) {
                                    return AddImageContainerOne(
                                      imagePath: state.imageUrl,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          customSpaceOne,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add a profile photo',
                                style: customTextStyleOne(
                                    fontSize: 18,
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack),
                              ),
                            ],
                          ),
                          customSpaceTwo,
                          CustomTextFieldTwo(
                              onChanged: (value) {
                                userName = value;
                              },
                              keyboardType: TextInputType.name,
                              labelText: 'Enter your name',
                              prefixIcon:
                                  const Icon(Icons.person_pin_outlined)),
                          customSpaceTwo,
                          CustomTextFieldFour(
                              onChanged: (value) {
                                initialBalance = value;
                              },
                              labelText: 'Current Wallet Balance',
                              prefixIcon: const Icon(Icons.currency_rupee)),
                          customSpaceTwo,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final isValidForm = formKey.currentState!.validate();
                        if (isValidForm) {
                          _storeOnboardingInfo();
                          Hive.box<ProfileDetails>('profiledetails').add(
                              ProfileDetails(
                                  nameofUser: userName,
                                  initialWalletBalance: initialBalance,
                                  imageUrl: imagePath));
                          scheduledNotificationEveryday(userName);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const ScreenHome(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 48.h,
                        decoration: customBoxDecoration,
                        child: arrowForwardIcon,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
