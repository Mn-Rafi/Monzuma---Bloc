import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Logic/cubit/showimage_cubit.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomContainerForImageProfile extends StatelessWidget {
  final String? imagePath;

  const CustomContainerForImageProfile({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.h,
      height: 100.h,
      child: imagePath != null
          ? CircleAvatar(
              backgroundImage: FileImage(File(imagePath!)),
            )
          : CircleAvatar(
              backgroundImage: Image.asset('images/userAlt.png').image,
            ),
    );
  }
}

class CustomRowofprofile extends StatelessWidget {
  final Icon leadingIcon;

  final String title;

  const CustomRowofprofile({
    Key? key,
    required this.leadingIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      dense: true,
      iconColor: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? firstWhite
          : firstBlack,
      title: Text(title,
          style: customTextStyleOne(
              fontSize: 17.sp,
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? firstWhite
                      : firstBlack)),
      leading: leadingIcon,
    );
  }
}

class EditProfile extends StatelessWidget {
  final String intialName;
  final String imagePath;
  const EditProfile({
    Key? key,
    required this.intialName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFieldThree(
              initialValue: intialName,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.person_pin_outlined,
              ),
            ),
            Text(
              'Edit profile photo',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              child: CustomContainerForImageProfile(imagePath: imagePath),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomOutlinedButton(
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}

class EditProfileDetails extends StatefulWidget {
  final String initialName;
  final String? initialUrl;
  final String initialBalance;

  const EditProfileDetails({
    Key? key,
    required this.initialName,
    required this.initialUrl,
    required this.initialBalance,
  }) : super(key: key);

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  final formKey = GlobalKey<FormState>();
  String? userName;
  String? imagePath;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: firstBlack,
              size: 15,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: customTextStyleOne(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                  icon:
                                                      const Icon(Icons.camera),
                                                  label:
                                                      const Text('Take Photo')),
                                              TextButton.icon(
                                                  onPressed: () {
                                                    chooseImage(
                                                        ImageSource.gallery);
                                                    Navigator.pop(ctx);
                                                  },
                                                  icon: const Icon(
                                                      Icons.filter_sharp),
                                                  label: const Text(
                                                      'Choose from device')),
                                            ],
                                          ),
                                        ],
                                      )),
                              child:
                                  BlocBuilder<ShowimageCubit, ShowimageState>(
                                builder: (context, state) {
                                  return state.imageUrl != null
                                      ? CircleAvatar(
                                          radius: 100.r,
                                          backgroundImage: FileImage(
                                            File(
                                              state.imageUrl!,
                                            ),
                                          ),
                                        )
                                      : widget.initialUrl != null
                                          ? CircleAvatar(
                                              radius: 100.r,
                                              backgroundImage: FileImage(
                                                File(
                                                  widget.initialUrl!,
                                                ),
                                              ))
                                          : CircleAvatar(
                                              radius: 100.r,
                                              backgroundImage: Image.asset(
                                                      'images/userAlt.png')
                                                  .image,
                                            );
                                },
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tap to change photo',
                            style: customTextStyleOne(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      customSpaceTwo,
                      customSpaceOne,
                      CustomTextFieldTwo(
                          initialValue: widget.initialName.toString(),
                          onChanged: (value) {
                            userName = value;
                          },
                          keyboardType: TextInputType.name,
                          labelText: 'Enter your name',
                          prefixIcon: const Icon(Icons.person_pin_outlined)),
                      customSpaceTwo,
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    final isValidForm = formKey.currentState!.validate();
                    if (isValidForm) {
                      Hive.box<ProfileDetails>('profiledetails').putAt(
                        0,
                        ProfileDetails(
                            nameofUser: userName == null
                                ? widget.initialName
                                : userName!,
                            initialWalletBalance: widget.initialBalance,
                            imageUrl: imagePath ?? widget.initialUrl),
                      );
                      Navigator.pop(context);
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
            )
          ],
        ),
      ),
    );
  }
}
