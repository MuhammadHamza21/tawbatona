// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final int noOfBadWords;
  final String date;
  final String id;
  const Person({
    required this.name,
    required this.noOfBadWords,
    required this.date,
    required this.id,
  });
  @override
  List<Object?> get props => [id, name, noOfBadWords, date];
}