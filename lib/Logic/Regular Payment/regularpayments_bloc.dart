import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';

part 'regularpayments_event.dart';
part 'regularpayments_state.dart';

class RegularpaymentsBloc
    extends Bloc<RegularpaymentsEvent, RegularpaymentsState> {
  RegularpaymentsBloc()
      : super(RegularpaymentsInitial(
            regList:
                Hive.box<RegularPayments>('regularPayments').values.toList())) {
    on<AddRegularPayment>((event, emit) {
      emit(RegularpaymentsInitial(regList: Hive.box<RegularPayments>('regularPayments').values.toList()));
    });
    
  }
}
