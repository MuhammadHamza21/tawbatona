import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tawbatona/app/domain/entities/person.dart';
import 'package:tawbatona/core/constants/app_constants.dart';

class PersonsModel extends Person {
  const PersonsModel(
      {required super.name,
      required super.noOfBadWords,
      required super.date,
      required super.id,
      required super.amountToPay});

  factory PersonsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return PersonsModel(
      id: document.id,
      name: document[AppConstants.name] ?? "",
      noOfBadWords: document[AppConstants.noOfBadWords] ?? 0,
      date: document[AppConstants.date] ?? "",
      amountToPay: document[AppConstants.amountToPay] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.name: name,
      'id': id,
      AppConstants.noOfBadWords: noOfBadWords,
      AppConstants.date: date,
    };
  }
}
