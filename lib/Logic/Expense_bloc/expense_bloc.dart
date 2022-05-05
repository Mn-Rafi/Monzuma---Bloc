import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc()
      : super(AllExpenseState(
            transList:
                Hive.box<Transactions>('transactions').values.toList())) {
    on<ExpenseEvent>((event, emit) {
      emit(AllExpenseState(
          transList: Hive.box<Transactions>('transactions').values.toList()));
    });
  }
}
