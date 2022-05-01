part of 'showimage_cubit.dart';

@immutable
class ShowimageState {
  final String? imageUrl;
  const ShowimageState({
    this.imageUrl,
  });
}

class BiometricState extends ShowimageState {
  final bool notification;
  const BiometricState({
    required this.notification,
  });
}

class SearchIconState extends ShowimageState {
  final IconData iconData;
  final Widget myField;
  const SearchIconState({
    required this.iconData,
    required this.myField,
  });
}

