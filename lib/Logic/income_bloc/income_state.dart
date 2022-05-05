part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();
}

class AllIncomeState extends IncomeState {
  final List<Transactions> transList;
  const AllIncomeState({
    required this.transList,
  });

  @override
  List<Object> get props => [transList];
}
