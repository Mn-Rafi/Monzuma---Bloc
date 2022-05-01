import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

systemUi(context) {
  MediaQuery.of(context).platformBrightness == Brightness.dark
      ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.grey.shade900,
          statusBarIconBrightness: Brightness.light))
      : SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark));
}

