import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.w,
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? firstWhite
            : firstBlack,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? firstWhite
                      : firstBlack,
              blurRadius: 0.1),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: ValueListenableBuilder(
          valueListenable: ScreenHome.selectedIndexNotifier,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return BottomNavigationBar(
              backgroundColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.grey.shade900
                      : firstWhite,
              elevation: 0,
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                ScreenHome.selectedIndexNotifier.value = newIndex;
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? firstWhite
                      : firstBlack,
              selectedLabelStyle: TextStyle(
                fontSize: 10.sp,
              ),
              unselectedItemColor: MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white30
                      : firstGrey,
              showUnselectedLabels: false,
              iconSize: 20.w,
              items: [
                BottomNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.house),
                  label: '⦿',
                  activeIcon: FaIcon(FontAwesomeIcons.houseChimney, size: 20.w),
                ),
                BottomNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.chartGantt),
                  activeIcon: FaIcon(FontAwesomeIcons.chartPie, size: 20.w),
                  label: '⦿',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 45.w,
                    width: 45.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: firstGrey, width: 2)),
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      size: 30.w,
                    ),
                  ),
                  label: '',
                  activeIcon: FaIcon(FontAwesomeIcons.plus, size: 30.w),
                ),
                BottomNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.solidBell),
                  label: '⦿',
                  activeIcon: FaIcon(FontAwesomeIcons.calendarPlus, size: 20.w),
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.screwdriverWrench,
                    size: 24.w,
                  ),
                  label: '⦿',
                  activeIcon: FaIcon(
                    FontAwesomeIcons.solidPenToSquare,
                    size: 20.w,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}