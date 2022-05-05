part of 'regularpayments_bloc.dart';

abstract class RegularpaymentsEvent extends Equatable {
  const RegularpaymentsEvent();
}

class AddRegularPayment extends RegularpaymentsEvent {
  @override
  List<Object> get props => [];
}

class EditRegularPayment extends RegularpaymentsEvent {
  @override
  List<Object> get props => [];
}

class DeleteRegularPayment extends RegularpaymentsEvent {
  @override
  List<Object> get props => [];
}