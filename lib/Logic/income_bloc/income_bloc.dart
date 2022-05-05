import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc()
      : super(AllIncomeState(
            transList:
                Hive.box<Transactions>('transactions').values.toList())) {
    on<IncomeEvent>((event, emit) {
      emit(AllIncomeState(
          transList: Hive.box<Transactions>('transactions').values.toList()));
    });
  }
}
