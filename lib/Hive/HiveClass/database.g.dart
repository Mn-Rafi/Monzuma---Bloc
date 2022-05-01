// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileDetailsAdapter extends TypeAdapter<ProfileDetails> {
  @override
  final int typeId = 0;

  @override
  ProfileDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileDetails(
      nameofUser: fields[0] as String,
      initialWalletBalance: fields[1] as String,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameofUser)
      ..writeByte(1)
      ..write(obj.initialWalletBalance)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final int typeId = 1;

  @override
  Categories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categories(
      category: fields[0] as String,
      type: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionsAdapter extends TypeAdapter<Transactions> {
  @override
  final int typeId = 2;

  @override
  Transactions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transactions(
      categoryName: fields[0] as String,
      categoryCat: fields[5] as Categories,
      amount: fields[1] as double,
      dateofTransaction: fields[2] as DateTime,
      notes: fields[3] as String,
      type: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Transactions obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.dateofTransaction)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.categoryCat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RegularPaymentsAdapter extends TypeAdapter<RegularPayments> {
  @override
  final int typeId = 3;

  @override
  RegularPayments read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegularPayments(
      title: fields[0] as String,
      upcomingDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RegularPayments obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.upcomingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegularPaymentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LockAuthenticationAdapter extends TypeAdapter<LockAuthentication> {
  @override
  final int typeId = 4;

  @override
  LockAuthentication read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LockAuthentication(
      enableAuth: fields[0] as bool,
      enableNoti: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LockAuthentication obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.enableAuth)
      ..writeByte(1)
      ..write(obj.enableNoti);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LockAuthenticationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
