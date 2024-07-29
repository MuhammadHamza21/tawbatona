// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final int noOfBadWords;
  final String date;
  final String id;
  final int amountToPay;
  const Person({
    required this.name,
    required this.noOfBadWords,
    required this.date,
    required this.id,
    required this.amountToPay,
  });
  @override
  List<Object?> get props => [id, name, noOfBadWords, date, amountToPay];
}
