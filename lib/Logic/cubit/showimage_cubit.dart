import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Logic/search/search_bloc.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

part 'showimage_state.dart';

class ShowimageCubit extends Cubit<ShowimageState> {
  ShowimageCubit() : super(const ShowimageState());

  String imageAdd(String img) {
    emit(ShowimageState(imageUrl: img));
    return state.imageUrl!;
  }

  bool canCheckBiometrics(bool notification) {
    emit(BiometricState(notification: notification));
    return notification;
  }

  DateTime changeTime(DateTime dateTime){
    emit(DateChangeState(dateTime: dateTime));
    return dateTime;
  }

  Categories dropdownValue(Categories dropVal) {
    emit(DropdownState(dropVal: dropVal));
    return dropVal;
  }

  

  IconData changeIcon(IconData iconData, Widget myField, String searchInput,
      BuildContext context) {
    if (iconData == Icons.clear) {
      emit(SearchIconState(iconData: Icons.clear, myField: myField));
      return SearchIconState(
          iconData: iconData,
          myField: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 233, 233, 233),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: TextField(
                style: customTextStyleOne(),
                onChanged: (value) {
                  searchInput = value;
                  context
                      .read<SearchBloc>()
                      .add(EnterInput(searchInput: value));
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: customTextStyleOne(),
                  hintText: 'Search here...',
                ),
              ),
            ),
          )).iconData;
    } else {
      emit(SearchIconState(
          iconData: Icons.search,
          myField: Text(
            'Latest Transactions',
            style: customTextStyleOne(
                fontSize: 20.sp, color: isDarkMode ? firstWhite : firstBlack),
          )));
      return SearchIconState(iconData: iconData, myField: myField).iconData;
    }
  }

  Widget changeMyField(IconData iconData, Widget myField, String searchInput,
      BuildContext context) {
    if (iconData == Icons.clear) {
      emit(SearchIconState(
        iconData: iconData,
        myField: myField,
      ));
      return SearchIconState(
        iconData: iconData,
        myField: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 233, 233),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: TextField(
              style: customTextStyleOne(),
              onChanged: (value) {
                searchInput = value;
                context.read<SearchBloc>().add(EnterInput(searchInput: value));
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: customTextStyleOne(),
                hintText: 'Search here...',
              ),
            ),
          ),
        ),
      ).myField;
    } else {
      emit(SearchIconState(
          iconData: Icons.clear,
          myField: Text(
            'Latest Transactions',
            style: customTextStyleOne(
                fontSize: 20.sp, color: isDarkMode ? firstWhite : firstBlack),
          )));

      context.read<SearchBloc>().add(ClearInput());
      return SearchIconState(iconData: iconData, myField: myField).myField;
    }
  }
}

bool isDarkMode =
    SchedulerBinding.instance!.window.platformBrightness == Brightness.dark;
