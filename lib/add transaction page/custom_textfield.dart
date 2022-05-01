import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomTextFieldTwo extends StatelessWidget {
  final String? labelText;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String initialValue;

  const CustomTextFieldTwo({
    Key? key,
    this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.number,
    required this.onChanged,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      style: customTextStyleOne(),
      validator: (value) {
        if (value != null && value.length < 3) {
          return 'Enter atleast 3 characters';
        } else {
          return null;
        }
      },
      textCapitalization: TextCapitalization.words,
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      cursorWidth: 1,
      cursorColor: firstGrey,
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
        fillColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? firstGrey
            : firstWhite,
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: customTextStyleOne(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? firstWhite
              : firstBlack,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class CustomTextFieldForDate extends StatelessWidget {
  final String? hint;
  final Icon prefixIcon;
  final Function() onTap;
  final String? labelText;

  const CustomTextFieldForDate({
    Key? key,
    this.hint,
    required this.prefixIcon,
    required this.onTap,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: customTextStyleOne(),
      onTap: onTap,
      readOnly: true,
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? firstGrey
            : firstWhite,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: customTextStyleOne(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? firstWhite
              : firstBlack,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

RegExp numberReg = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

class CustomTextFieldFour extends StatelessWidget {
  final String? labelText;
  final double initialValue;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  const CustomTextFieldFour({
    Key? key,
    this.initialValue = 0,
    this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.number,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      style: customTextStyleOne(),
      initialValue: initialValue != 0 ? '$initialValue' : '',
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
      ],
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Enter a valid amount';
        } else {
          return null;
        }
      },
      maxLength: 9,
      onChanged: onChanged,
      keyboardType: keyboardType,
      cursorWidth: 1,
      cursorColor: firstGrey,
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
        fillColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? firstGrey
            : firstWhite,
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: customTextStyleOne(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? firstWhite
              : firstBlack,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class CustomTextFieldThree extends StatelessWidget {
  final String? labelText;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  final String initialValue;

  const CustomTextFieldThree({
    Key? key,
    this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.number,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLength: 30,
      keyboardType: keyboardType,
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        labelText: labelText,
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
    );
  }
}

class CustomOutlinedButton extends StatefulWidget {
  final Function() onPressed;
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Text(
        'Submit',
        style: customTextStyleOne(fontSize: 18),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h)),
          backgroundColor: MaterialStateProperty.all(walletPink)),
    );
  }
}
