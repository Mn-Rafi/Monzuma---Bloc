part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
}

class SearchInitial extends SearchState {

  final List<Transactions> transactions;
  const SearchInitial({
    required this.transactions,
  });


  @override
  List<Object?> get props => [transactions];
}


