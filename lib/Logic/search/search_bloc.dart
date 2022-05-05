import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchInitial(
            transactions:
                Hive.box<Transactions>('transactions').values.toList())) {
    on<EnterInput>((event, emit) {
      List<Transactions> translist = Hive.box<Transactions>('transactions')
          .values
          .toList()
          .where((element) => element.categoryName
              .toLowerCase()
              .contains(event.searchInput.toLowerCase()))
          .toList();
      emit(SearchInitial(transactions: translist));
    });
    on<ClearInput>((event, emit) {
      List<Transactions> translist =
          Hive.box<Transactions>('transactions').values.toList();
      emit(SearchInitial(transactions: translist));
    });
  }
}
