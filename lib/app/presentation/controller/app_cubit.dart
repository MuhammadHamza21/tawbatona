import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawbatona/app/domain/entities/person.dart';
import 'package:tawbatona/app/domain/usecases/add_person.dart';
import 'package:tawbatona/app/domain/usecases/delete_person.dart';
import 'package:tawbatona/app/domain/usecases/get_persons.dart';
import 'package:tawbatona/app/domain/usecases/update_person.dart';
import 'package:tawbatona/app/presentation/screens/athkar_screen.dart';
import 'package:tawbatona/app/presentation/screens/home_screen.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';
import 'package:tawbatona/core/utils/enums/enums.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.getPersonsUsecase, this.deletePersonUsecase,
      this.updatePersonUsecase, this.addPersonUsecase)
      : super(AppInitial());
  final GetPersonsUsecase getPersonsUsecase;
  final DeletePersonUsecase deletePersonUsecase;
  final UpdatePersonUsecase updatePersonUsecase;
  final AddPersonUsecase addPersonUsecase;

  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  List<Person> personsList = [];
  String gettingPersonsMessage = "";
  String deletingPersonsMessage = "";
  String updatingPersonsMessage = "";
  String addingPersonsMessage = "";
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const AthkarScreen(),
  ];

  void changeCurrentIndex(int index) {
    emit(state.copyWith(changingCurrentIndexState: RequestState.loading));
    currentIndex = index;
    emit(state.copyWith(changingCurrentIndexState: RequestState.loaded));
  }

  int getTotalToPay() {
    var totalToPay = 0;
    for (var element in personsList) {
      totalToPay += element.amountToPay;
    }
    return totalToPay;
  }

  FutureOr<void> getPersons({bool isLoadAgain = false}) async {
    if (!isLoadAgain) {
      emit(state.copyWith(gettingPersonsState: RequestState.loading));
    } else {
      emit(state.copyWith(gettingPersonsState: RequestState.loadMore));
    }
    final result = await getPersonsUsecase(NoParams());
    result.fold(
      (l) {
        gettingPersonsMessage = l.message;
        if (l is ServerFailure) {
          emit(state.copyWith(gettingPersonsState: RequestState.error));
        } else if (l is OfflineFailure) {
          emit(state.copyWith(gettingPersonsState: RequestState.offline));
        }
      },
      (r) {
        personsList = r;
        personsList.sort(
          (a, b) => b.amountToPay.compareTo(a.amountToPay),
        );
        emit(state.copyWith(gettingPersonsState: RequestState.loaded));
      },
    );
  }

  FutureOr<void> deletePerson(String id) async {
    emit(state.copyWith(deletingPersonsState: RequestState.loading));
    final result = await deletePersonUsecase(id);
    result.fold(
      (l) {
        deletingPersonsMessage = l.message;
        if (l is ServerFailure) {
          emit(state.copyWith(deletingPersonsState: RequestState.error));
        } else if (l is OfflineFailure) {
          emit(state.copyWith(deletingPersonsState: RequestState.offline));
        }
      },
      (r) {
        emit(state.copyWith(deletingPersonsState: RequestState.loaded));
        emit(state.copyWith(deletingPersonsState: RequestState.initial));
      },
    );
  }

  FutureOr<void> addPerson(AddingPersonParams params) async {
    emit(state.copyWith(addingPersonsState: RequestState.loading));
    final result = await addPersonUsecase(params);
    result.fold(
      (l) {
        addingPersonsMessage = l.message;
        if (l is ServerFailure) {
          emit(state.copyWith(addingPersonsState: RequestState.error));
        } else if (l is OfflineFailure) {
          emit(state.copyWith(addingPersonsState: RequestState.offline));
        }
      },
      (r) {
        emit(state.copyWith(addingPersonsState: RequestState.loaded));
        emit(state.copyWith(addingPersonsState: RequestState.initial));
      },
    );
  }

  FutureOr<void> updatePerson(UpdatingPersonParams params) async {
    emit(state.copyWith(updatingPersonsState: RequestState.loading));
    final result = await updatePersonUsecase(params);
    result.fold(
      (l) {
        updatingPersonsMessage = l.message;
        if (l is ServerFailure) {
          emit(state.copyWith(updatingPersonsState: RequestState.error));
        } else if (l is OfflineFailure) {
          emit(state.copyWith(updatingPersonsState: RequestState.offline));
        }
      },
      (r) {
        emit(state.copyWith(updatingPersonsState: RequestState.loaded));
        emit(state.copyWith(updatingPersonsState: RequestState.initial));
      },
    );
  }
}
