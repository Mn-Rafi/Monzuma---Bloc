part of 'regularpayments_bloc.dart';

abstract class RegularpaymentsState extends Equatable {
  const RegularpaymentsState();
}

class RegularpaymentsInitial extends RegularpaymentsState {
  final List<RegularPayments> regList;
  const RegularpaymentsInitial({
    required this.regList,
  });
  @override
  List<Object> get props => [regList];
}
