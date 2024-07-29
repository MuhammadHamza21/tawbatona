// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.gettingPersonsState = RequestState.initial,
    this.deletingPersonsState = RequestState.initial,
    this.addingPersonsState = RequestState.initial,
    this.updatingPersonsState = RequestState.initial,
  });
  final RequestState gettingPersonsState;
  final RequestState deletingPersonsState;
  final RequestState addingPersonsState;
  final RequestState updatingPersonsState;

  @override
  List<Object> get props => [
        gettingPersonsState,
        deletingPersonsState,
        addingPersonsState,
        updatingPersonsState
      ];

  AppState copyWith({
    RequestState? gettingPersonsState,
    RequestState? deletingPersonsState,
    RequestState? addingPersonsState,
    RequestState? updatingPersonsState,
  }) =>
      AppState(
        gettingPersonsState: gettingPersonsState ?? this.gettingPersonsState,
        deletingPersonsState: deletingPersonsState ?? this.deletingPersonsState,
        addingPersonsState: addingPersonsState ?? this.addingPersonsState,
        updatingPersonsState: updatingPersonsState ?? this.updatingPersonsState,
      );
}

final class AppInitial extends AppState {}
