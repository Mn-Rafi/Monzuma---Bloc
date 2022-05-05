part of 'showimage_cubit.dart';

@immutable
class ShowimageState extends Equatable {
  final String? imageUrl;
  const ShowimageState({
    this.imageUrl,
  });

  @override
  List<Object?> get props => [imageUrl];
}

class BiometricState extends ShowimageState {
  final bool notification;
  const BiometricState({
    required this.notification,
  });
  @override
  List<Object?> get props => [notification];
}

class SearchIconState extends ShowimageState {
  final IconData iconData;
  final Widget myField;
  const SearchIconState({
    required this.iconData,
    required this.myField,
  });
  @override
  List<Object?> get props => [iconData, myField];
}

class DropdownState extends ShowimageState {
  final Categories dropVal;
  const DropdownState({
    required this.dropVal,
  });
  @override
  List<Object?> get props => [dropVal];
}

class DateChangeState extends ShowimageState {
  final DateTime dateTime;
  const DateChangeState({
    required this.dateTime,
  });

  @override
  List<Object?> get props => [dateTime];
}
