import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tawbatona/app/domain/entities/person.dart';

class PersonsModel extends Person {
  const PersonsModel(
      {required super.name,
      required super.noOfBadWords,
      required super.date,
      required super.id});

  factory PersonsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return PersonsModel(
      id: document.id,
      name: document['name'] ?? "",
      noOfBadWords: document['noOfBadWords'] ?? 0,
      date: document['date'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'noOfBadWords': noOfBadWords,
      'date': date,
    };
  }
}
