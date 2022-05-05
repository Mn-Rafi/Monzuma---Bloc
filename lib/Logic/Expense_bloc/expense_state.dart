part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class AllExpenseState extends ExpenseState {
  final List<Transactions> transList;
  const AllExpenseState({
    required this.transList,
  });

  @override
  List<Object> get props => [transList];
}
