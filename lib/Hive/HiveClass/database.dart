import 'package:hive/hive.dart';

part 'database.g.dart';

@HiveType(typeId: 0)
class ProfileDetails extends HiveObject {
  @HiveField(0)
  final String nameofUser;

  @HiveField(1)
  final String initialWalletBalance;

  @HiveField(2)
  final String? imageUrl;

  ProfileDetails({
    required this.nameofUser,
    required this.initialWalletBalance,
    this.imageUrl,
  });
}

@HiveType(typeId: 1)
class Categories extends HiveObject {
  @HiveField(0)
  late final String category;

  @HiveField(1)
  final bool type;

  Categories({required this.category, required this.type});
}

@HiveType(typeId: 2)
class Transactions extends HiveObject {
  @HiveField(0)
  String categoryName;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime dateofTransaction;

  @HiveField(3)
  final String notes;

  @HiveField(4)
  final bool type;

  @HiveField(5)
  final Categories categoryCat;

  Transactions(
      {required this.categoryName,
      required this.categoryCat,
      required this.amount,
      required this.dateofTransaction,
      required this.notes,
      required this.type});
}

@HiveType(typeId: 3)
class RegularPayments extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime upcomingDate;

  RegularPayments({required this.title, required this.upcomingDate});
}

@HiveType(typeId: 4)
class LockAuthentication extends HiveObject {
  @HiveField(0)
  final bool enableAuth;

  @HiveField(1)
  final bool enableNoti;

  LockAuthentication({
    required this.enableAuth,
    required this.enableNoti,
  });
}
