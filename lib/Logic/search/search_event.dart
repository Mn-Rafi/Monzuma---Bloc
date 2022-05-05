part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  
}

class EnterInput extends SearchEvent {

  final String searchInput;
  const EnterInput({
    required this.searchInput,
  });
  @override
  List<Object?> get props => [searchInput];

}

class ClearInput extends SearchEvent{
  @override
  List<Object?> get props => [];

}
